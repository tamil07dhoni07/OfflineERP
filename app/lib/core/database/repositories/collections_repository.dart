import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../app_database.dart';
import 'accounting_repository.dart';
import 'audit_repository.dart';

const _uuid = Uuid();

enum PaymentMethod { cash, cheque, dd }

extension PaymentMethodLabel on PaymentMethod {
  String get label => switch (this) {
    PaymentMethod.cash => 'Cash',
    PaymentMethod.cheque => 'Cheque',
    PaymentMethod.dd => 'DD',
  };

  String get dbValue => name;

  /// Which ledger account the money lands in. Cheques and DDs are modelled
  /// as going straight to the bank account (deposited), matching the
  /// seeded chart of accounts, which has no separate "instruments in hand"
  /// clearing account.
  String get accountCode => this == PaymentMethod.cash ? '1000' : '1010';
}

/// One line the collection screen lets the user edit before it's posted —
/// either computed by auto-adjust (oldest invoice first) or typed manually.
class AllocationLine {
  const AllocationLine({required this.invoice, required this.amountPaise});
  final SalesInvoice invoice;
  final int amountPaise;
}

class CollectionsRepository {
  CollectionsRepository(this._db, this._accounting, this._audit);
  final AppDatabase _db;
  final AccountingRepository _accounting;
  final AuditRepository _audit;

  Stream<List<Receipt>> watchReceipts() =>
      (_db.select(_db.receipts)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();

  Future<List<ReceiptAllocation>> allocationsFor(String receiptId) =>
      (_db.select(_db.receiptAllocations)..where((t) => t.receiptId.equals(receiptId))).get();

  /// Open (non-draft, unpaid) invoices for a customer, oldest first — the
  /// order auto-adjust allocates against.
  Future<List<SalesInvoice>> openInvoicesFor(String customerId) {
    return (_db.select(_db.salesInvoices)
          ..where((t) => t.customerId.equals(customerId) & t.status.isNotValue('draft') & t.balancePaise.isBiggerThanValue(0))
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .get();
  }

  /// FIFO allocation: fills the oldest invoice first, then the next, until
  /// the collected amount runs out. Whatever's left over (payment bigger
  /// than everything owed) is reported as unallocated rather than guessed
  /// at — the UI shows it and the caller decides whether to cap the amount.
  ({List<AllocationLine> lines, int unallocatedPaise}) autoAdjust(List<SalesInvoice> openInvoices, int amountPaise) {
    var remaining = amountPaise;
    final lines = <AllocationLine>[];
    for (final invoice in openInvoices) {
      if (remaining <= 0) break;
      final take = remaining < invoice.balancePaise ? remaining : invoice.balancePaise;
      if (take > 0) {
        lines.add(AllocationLine(invoice: invoice, amountPaise: take));
        remaining -= take;
      }
    }
    return (lines: lines, unallocatedPaise: remaining);
  }

  Future<String> nextVoucherNumber() async {
    final existing = await _db.select(_db.receipts).get();
    var maxSeq = 0;
    final pattern = RegExp(r'RCP/(\d+)');
    for (final r in existing) {
      final m = pattern.firstMatch(r.voucherNo);
      if (m != null) {
        final seq = int.parse(m.group(1)!);
        if (seq > maxSeq) maxSeq = seq;
      }
    }
    return 'RCP/${(maxSeq + 1).toString().padLeft(4, '0')}';
  }

  /// Records the collection, allocates it across invoices, updates each
  /// invoice's balance/status, and posts one balanced journal entry
  /// (Dr Cash/Bank, Cr Accounts Receivable) — all inside a single Drift
  /// transaction, matching the same all-or-nothing guarantee invoice
  /// posting uses.
  Future<String> recordCollection({
    required DateTime date,
    required Customer customer,
    required PaymentMethod method,
    String? reference,
    required int amountPaise,
    required List<AllocationLine> allocations,
    required int unallocatedPaise,
    required String actor,
    required String device,
  }) async {
    final allocatedTotal = allocations.fold<int>(0, (a, l) => a + l.amountPaise);
    if (allocatedTotal + unallocatedPaise != amountPaise) {
      throw StateError('Allocation ($allocatedTotal) + unallocated ($unallocatedPaise) must equal the collected amount ($amountPaise).');
    }

    final voucherNo = await nextVoucherNumber();
    final receiptId = _uuid.v4();

    await _db.transaction(() async {
      await _db
          .into(_db.receipts)
          .insert(
            ReceiptsCompanion.insert(
              id: Value(receiptId),
              voucherNo: voucherNo,
              date: date,
              customerId: customer.id,
              method: method.dbValue,
              reference: Value(reference),
              amountPaise: amountPaise,
              unallocatedPaise: Value(unallocatedPaise),
            ),
          );

      for (final line in allocations) {
        await _db
            .into(_db.receiptAllocations)
            .insert(
              ReceiptAllocationsCompanion.insert(receiptId: receiptId, invoiceId: line.invoice.id, amountPaise: line.amountPaise),
            );

        final newBalance = line.invoice.balancePaise - line.amountPaise;
        final newStatus = newBalance <= 0 ? 'paid' : 'part_paid';
        await (_db.update(_db.salesInvoices)..where((t) => t.id.equals(line.invoice.id))).write(
          SalesInvoicesCompanion(
            balancePaise: Value(newBalance < 0 ? 0 : newBalance),
            status: Value(newStatus),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }

      if (allocatedTotal > 0) {
        final cashOrBankAccount = await _accountIdByCode(method.accountCode);
        final arAccount = await _accountIdByCode('1200');
        await _accounting.postJournal(
          voucherNo: voucherNo,
          date: date,
          narration: '$voucherNo — ${customer.name} (${method.label})',
          sourceType: 'receipt',
          sourceId: receiptId,
          lines: [
            (accountId: cashOrBankAccount, debitPaise: allocatedTotal, creditPaise: 0, particulars: method.label),
            (accountId: arAccount, debitPaise: 0, creditPaise: allocatedTotal, particulars: customer.name),
          ],
        );
      }

      await _audit.log(
        username: actor,
        module: 'Sales',
        action: 'receipt.recorded',
        recordRef: voucherNo,
        oldValue: '—',
        newValue: '${method.label} · ${allocations.length} invoice(s) allocated',
        device: device,
      );
    });

    return receiptId;
  }

  /// Reverses a receipt: every invoice it settled has its balance and
  /// status restored, and a reversing Cr Cash/Bank / Dr AR journal is
  /// posted. The voucher stays on record as voided rather than deleted.
  Future<void> voidReceipt(String receiptId, {required String actor, required String device}) async {
    final receipt = await (_db.select(_db.receipts)..where((t) => t.id.equals(receiptId))).getSingle();
    if (receipt.status == 'voided') return;
    final customer = await (_db.select(_db.customers)..where((t) => t.id.equals(receipt.customerId))).getSingle();
    final allocations = await allocationsFor(receiptId);
    final allocatedTotal = allocations.fold<int>(0, (a, l) => a + l.amountPaise);

    await _db.transaction(() async {
      for (final alloc in allocations) {
        final invoice = await (_db.select(_db.salesInvoices)..where((t) => t.id.equals(alloc.invoiceId))).getSingleOrNull();
        if (invoice == null) continue;
        final restored = invoice.balancePaise + alloc.amountPaise;
        final cappedBalance = restored > invoice.totalPaise ? invoice.totalPaise : restored;
        await (_db.update(_db.salesInvoices)..where((t) => t.id.equals(invoice.id))).write(
          SalesInvoicesCompanion(
            balancePaise: Value(cappedBalance),
            status: Value(cappedBalance >= invoice.totalPaise ? 'posted' : 'part_paid'),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }

      if (allocatedTotal > 0) {
        final method = PaymentMethod.values.byName(receipt.method);
        final cashOrBankAccount = await _accountIdByCode(method.accountCode);
        final arAccount = await _accountIdByCode('1200');
        await _accounting.postJournal(
          voucherNo: '${receipt.voucherNo}/VOID',
          date: DateTime.now(),
          narration: 'Void ${receipt.voucherNo} — ${customer.name}',
          sourceType: 'receipt_void',
          sourceId: receiptId,
          lines: [
            (accountId: arAccount, debitPaise: allocatedTotal, creditPaise: 0, particulars: '${customer.name} (void)'),
            (accountId: cashOrBankAccount, debitPaise: 0, creditPaise: allocatedTotal, particulars: '${method.label} (void)'),
          ],
        );
      }

      await (_db.update(_db.receipts)..where((t) => t.id.equals(receiptId)))
          .write(const ReceiptsCompanion(status: Value('voided')));

      await _audit.log(
        username: actor,
        module: 'Sales',
        action: 'receipt.voided',
        recordRef: receipt.voucherNo,
        oldValue: 'posted',
        newValue: 'voided',
        device: device,
      );
    });
  }

  Future<String> _accountIdByCode(String code) async {
    final account = await (_db.select(_db.accounts)..where((t) => t.code.equals(code))).getSingle();
    return account.id;
  }
}
