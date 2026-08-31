import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../utils/gst.dart';
import '../app_database.dart';
import 'accounting_repository.dart';
import 'audit_repository.dart';
import 'stock_repository.dart';

const _uuid = Uuid();

/// One line the user has composed in the invoice editor, before it's ever
/// written to the database.
class DraftInvoiceLine {
  const DraftInvoiceLine({
    required this.product,
    required this.qty,
    required this.ratePaise,
    required this.discountPct,
  });
  final Product product;
  final int qty;
  final int ratePaise;
  final double discountPct;

  int get grossPaise => qty * ratePaise;
  int get amountPaise => (grossPaise * (1 - discountPct / 100)).round();
}

class PostedInvoiceTotals {
  const PostedInvoiceTotals({
    required this.taxableValuePaise,
    required this.cgstPaise,
    required this.sgstPaise,
    required this.igstPaise,
    required this.totalPaise,
  });
  final int taxableValuePaise;
  final int cgstPaise;
  final int sgstPaise;
  final int igstPaise;
  final int totalPaise;
}

class SalesRepository {
  SalesRepository(this._db, this._accounting, this._stock, this._audit);
  final AppDatabase _db;
  final AccountingRepository _accounting;
  final StockRepository _stock;
  final AuditRepository _audit;

  Stream<List<SalesInvoice>> watchInvoices() =>
      (_db.select(_db.salesInvoices)
            ..where((t) => t.deletedAt.isNull())
            ..orderBy([(t) => OrderingTerm.desc(t.date)]))
          .watch();

  Stream<List<({SalesInvoice invoice, Customer customer})>> watchInvoicesWithCustomers() {
    final query = _db.select(_db.salesInvoices).join([
      innerJoin(_db.customers, _db.customers.id.equalsExp(_db.salesInvoices.customerId)),
    ])
      ..where(_db.salesInvoices.deletedAt.isNull())
      ..orderBy([OrderingTerm.desc(_db.salesInvoices.date)]);
    return query.watch().map(
      (rows) => rows
          .map((r) => (invoice: r.readTable(_db.salesInvoices), customer: r.readTable(_db.customers)))
          .toList(),
    );
  }

  Future<Map<String, SalesInvoiceItem>> firstItemByInvoice() async => {};

  Future<List<SalesInvoiceItem>> itemsFor(String invoiceId) =>
      (_db.select(_db.salesInvoiceItems)..where((t) => t.invoiceId.equals(invoiceId))).get();

  Future<SalesInvoice?> invoiceById(String invoiceId) =>
      (_db.select(_db.salesInvoices)..where((t) => t.id.equals(invoiceId))).getSingleOrNull();

  PostedInvoiceTotals computeTotals(List<DraftInvoiceLine> lines, {required bool interState}) {
    var taxable = 0;
    var cgst = 0;
    var sgst = 0;
    var igst = 0;
    for (final line in lines) {
      taxable += line.amountPaise;
      final split = splitGst(taxableValuePaise: line.amountPaise, gstRatePercent: line.product.gstRate, interState: interState);
      cgst += split.cgstPaise;
      sgst += split.sgstPaise;
      igst += split.igstPaise;
    }
    return PostedInvoiceTotals(
      taxableValuePaise: taxable,
      cgstPaise: cgst,
      sgstPaise: sgst,
      igstPaise: igst,
      totalPaise: taxable + cgst + sgst + igst,
    );
  }

  Future<String> nextInvoiceNumber(String financialYearLabel) async {
    final existing = await _db.select(_db.salesInvoices).get();
    var maxSeq = 0;
    final pattern = RegExp(r'INV/' + RegExp.escape(financialYearLabel) + r'/(\d+)');
    for (final inv in existing) {
      final m = pattern.firstMatch(inv.invoiceNo);
      if (m != null) {
        final seq = int.parse(m.group(1)!);
        if (seq > maxSeq) maxSeq = seq;
      }
    }
    final next = (maxSeq + 1).toString().padLeft(4, '0');
    return 'INV/$financialYearLabel/$next';
  }

  Future<String> _accountIdByCode(String code) async {
    final account = await (_db.select(_db.accounts)..where((t) => t.code.equals(code))).getSingle();
    return account.id;
  }

  /// Writes the invoice, its items, the resulting stock movements, and the
  /// double-entry journal in one Drift transaction. If anything after this
  /// call throws, the whole write rolls back — nothing partial is ever
  /// visible, matching the spec's data-integrity requirement.
  Future<String> postInvoice({
    required String invoiceNo,
    required DateTime date,
    required Customer customer,
    required String warehouseId,
    required String placeOfSupplyState,
    required String placeOfSupplyCode,
    required String paymentTerms,
    required String salesperson,
    required List<DraftInvoiceLine> lines,
    required bool interState,
    required String actor,
    required String device,
    bool asDraft = false,
  }) async {
    final totals = computeTotals(lines, interState: interState);
    final invoiceId = _uuid.v4();

    await _db.transaction(() async {
      await _db
          .into(_db.salesInvoices)
          .insert(
            SalesInvoicesCompanion.insert(
              id: Value(invoiceId),
              invoiceNo: invoiceNo,
              date: date,
              customerId: customer.id,
              warehouseId: warehouseId,
              placeOfSupplyState: placeOfSupplyState,
              placeOfSupplyCode: placeOfSupplyCode,
              paymentTerms: paymentTerms,
              salesperson: salesperson,
              taxableValuePaise: totals.taxableValuePaise,
              cgstPaise: Value(totals.cgstPaise),
              sgstPaise: Value(totals.sgstPaise),
              igstPaise: Value(totals.igstPaise),
              totalPaise: totals.totalPaise,
              balancePaise: asDraft ? 0 : totals.totalPaise,
              status: asDraft ? 'draft' : 'posted',
            ),
          );

      var lineNo = 1;
      var cogsPaise = 0;
      for (final line in lines) {
        await _db
            .into(_db.salesInvoiceItems)
            .insert(
              SalesInvoiceItemsCompanion.insert(
                invoiceId: invoiceId,
                productId: line.product.id,
                lineNo: lineNo,
                qty: line.qty,
                ratePaise: line.ratePaise,
                discountPct: Value(line.discountPct),
                gstPct: line.product.gstRate,
                amountPaise: line.amountPaise,
              ),
            );
        cogsPaise += line.qty * line.product.purchasePricePaise;
        lineNo++;

        if (!asDraft) {
          await _stock.recordMovement(
            productId: line.product.id,
            warehouseId: warehouseId,
            kind: 'out',
            qtyDelta: -line.qty,
            unitCostPaise: line.product.purchasePricePaise,
            refType: 'invoice',
            refId: invoiceId,
          );
        }
      }

      if (!asDraft) {
        final arAccount = await _accountIdByCode('1200');
        final salesAccount = await _accountIdByCode('4000');
        final cgstAccount = await _accountIdByCode('2210');
        final sgstAccount = await _accountIdByCode('2211');
        final igstAccount = await _accountIdByCode('2212');
        final cogsAccount = await _accountIdByCode('5000');
        final inventoryAccount = await _accountIdByCode('1400');

        final journalLines = <({String accountId, int debitPaise, int creditPaise, String particulars})>[
          (accountId: arAccount, debitPaise: totals.totalPaise, creditPaise: 0, particulars: customer.name),
          (accountId: salesAccount, debitPaise: 0, creditPaise: totals.taxableValuePaise, particulars: 'revenue'),
          if (totals.cgstPaise > 0)
            (accountId: cgstAccount, debitPaise: 0, creditPaise: totals.cgstPaise, particulars: 'CGST'),
          if (totals.sgstPaise > 0)
            (accountId: sgstAccount, debitPaise: 0, creditPaise: totals.sgstPaise, particulars: 'SGST'),
          if (totals.igstPaise > 0)
            (accountId: igstAccount, debitPaise: 0, creditPaise: totals.igstPaise, particulars: 'IGST'),
          (accountId: cogsAccount, debitPaise: cogsPaise, creditPaise: 0, particulars: 'moving average'),
          (accountId: inventoryAccount, debitPaise: 0, creditPaise: cogsPaise, particulars: '${lines.length} movements OUT'),
        ];

        await _accounting.postJournal(
          voucherNo: 'JV/${invoiceNo.split('/').last}',
          date: date,
          narration: '$invoiceNo — ${customer.name}',
          sourceType: 'sales_invoice',
          sourceId: invoiceId,
          lines: journalLines,
        );
      }

      await _audit.log(
        username: actor,
        module: 'Sales',
        action: asDraft ? 'invoice.created' : 'invoice.posted',
        recordRef: invoiceNo,
        oldValue: '—',
        newValue: asDraft ? 'draft' : 'posted',
        device: device,
      );
    });

    return invoiceId;
  }

  /// Rewrites a draft's header + lines in place. Posted invoices are never
  /// mutated this way — [postExistingDraft] promotes a draft, and
  /// [voidInvoice] is the only way to undo a posted one, matching the
  /// "reversal, not edit" rule that already governs stock transfers.
  Future<void> updateDraftInvoice({
    required String invoiceId,
    required DateTime date,
    required Customer customer,
    required String warehouseId,
    required String placeOfSupplyState,
    required String placeOfSupplyCode,
    required String paymentTerms,
    required String salesperson,
    required List<DraftInvoiceLine> lines,
    required bool interState,
    required String actor,
    required String device,
  }) async {
    final existing = await (_db.select(_db.salesInvoices)..where((t) => t.id.equals(invoiceId))).getSingle();
    if (existing.status != 'draft') {
      throw StateError('Only draft invoices can be edited directly — post or void instead.');
    }
    final totals = computeTotals(lines, interState: interState);

    await _db.transaction(() async {
      await (_db.update(_db.salesInvoices)..where((t) => t.id.equals(invoiceId))).write(
        SalesInvoicesCompanion(
          date: Value(date),
          customerId: Value(customer.id),
          warehouseId: Value(warehouseId),
          placeOfSupplyState: Value(placeOfSupplyState),
          placeOfSupplyCode: Value(placeOfSupplyCode),
          paymentTerms: Value(paymentTerms),
          salesperson: Value(salesperson),
          taxableValuePaise: Value(totals.taxableValuePaise),
          cgstPaise: Value(totals.cgstPaise),
          sgstPaise: Value(totals.sgstPaise),
          igstPaise: Value(totals.igstPaise),
          totalPaise: Value(totals.totalPaise),
          updatedAt: Value(DateTime.now()),
        ),
      );

      await (_db.delete(_db.salesInvoiceItems)..where((t) => t.invoiceId.equals(invoiceId))).go();
      var lineNo = 1;
      for (final line in lines) {
        await _db
            .into(_db.salesInvoiceItems)
            .insert(
              SalesInvoiceItemsCompanion.insert(
                invoiceId: invoiceId,
                productId: line.product.id,
                lineNo: lineNo,
                qty: line.qty,
                ratePaise: line.ratePaise,
                discountPct: Value(line.discountPct),
                gstPct: line.product.gstRate,
                amountPaise: line.amountPaise,
              ),
            );
        lineNo++;
      }

      await _audit.log(
        username: actor,
        module: 'Sales',
        action: 'invoice.updated',
        recordRef: existing.invoiceNo,
        oldValue: 'draft',
        newValue: 'draft',
        device: device,
      );
    });
  }

  /// Soft-deletes a draft. Posted invoices can never be deleted — call
  /// [voidInvoice] instead, which preserves the audit trail.
  Future<void> deleteDraftInvoice(String invoiceId, {required String actor, required String device}) async {
    final existing = await (_db.select(_db.salesInvoices)..where((t) => t.id.equals(invoiceId))).getSingle();
    if (existing.status != 'draft') {
      throw StateError('Only draft invoices can be deleted — posted invoices must be voided.');
    }
    await _db.transaction(() async {
      await (_db.update(_db.salesInvoices)..where((t) => t.id.equals(invoiceId)))
          .write(SalesInvoicesCompanion(deletedAt: Value(DateTime.now())));
      await _audit.log(
        username: actor,
        module: 'Sales',
        action: 'invoice.deleted',
        recordRef: existing.invoiceNo,
        oldValue: 'draft',
        newValue: 'deleted',
        device: device,
      );
    });
  }

  /// Posts an existing draft in place — same stock + journal effects as
  /// [postInvoice]'s posted path, but keeps the draft's id/invoiceNo rather
  /// than minting a new invoice.
  Future<void> postExistingDraft(String invoiceId, {required String actor, required String device}) async {
    final invoice = await (_db.select(_db.salesInvoices)..where((t) => t.id.equals(invoiceId))).getSingle();
    if (invoice.status != 'draft') {
      throw StateError('Only draft invoices can be posted.');
    }
    final customer = await (_db.select(_db.customers)..where((t) => t.id.equals(invoice.customerId))).getSingle();
    final items = await itemsFor(invoiceId);
    if (items.isEmpty) {
      throw StateError('Add at least one line before posting.');
    }

    await _db.transaction(() async {
      var cogsPaise = 0;
      for (final item in items) {
        final product = await (_db.select(_db.products)..where((t) => t.id.equals(item.productId))).getSingle();
        cogsPaise += item.qty * product.purchasePricePaise;
        await _stock.recordMovement(
          productId: item.productId,
          warehouseId: invoice.warehouseId,
          kind: 'out',
          qtyDelta: -item.qty,
          unitCostPaise: product.purchasePricePaise,
          refType: 'invoice',
          refId: invoiceId,
        );
      }

      final arAccount = await _accountIdByCode('1200');
      final salesAccount = await _accountIdByCode('4000');
      final cgstAccount = await _accountIdByCode('2210');
      final sgstAccount = await _accountIdByCode('2211');
      final igstAccount = await _accountIdByCode('2212');
      final cogsAccount = await _accountIdByCode('5000');
      final inventoryAccount = await _accountIdByCode('1400');

      final journalLines = <({String accountId, int debitPaise, int creditPaise, String particulars})>[
        (accountId: arAccount, debitPaise: invoice.totalPaise, creditPaise: 0, particulars: customer.name),
        (accountId: salesAccount, debitPaise: 0, creditPaise: invoice.taxableValuePaise, particulars: 'revenue'),
        if (invoice.cgstPaise > 0)
          (accountId: cgstAccount, debitPaise: 0, creditPaise: invoice.cgstPaise, particulars: 'CGST'),
        if (invoice.sgstPaise > 0)
          (accountId: sgstAccount, debitPaise: 0, creditPaise: invoice.sgstPaise, particulars: 'SGST'),
        if (invoice.igstPaise > 0)
          (accountId: igstAccount, debitPaise: 0, creditPaise: invoice.igstPaise, particulars: 'IGST'),
        (accountId: cogsAccount, debitPaise: cogsPaise, creditPaise: 0, particulars: 'moving average'),
        (accountId: inventoryAccount, debitPaise: 0, creditPaise: cogsPaise, particulars: '${items.length} movements OUT'),
      ];

      await _accounting.postJournal(
        voucherNo: 'JV/${invoice.invoiceNo.split('/').last}',
        date: invoice.date,
        narration: '${invoice.invoiceNo} — ${customer.name}',
        sourceType: 'sales_invoice',
        sourceId: invoiceId,
        lines: journalLines,
      );

      await (_db.update(_db.salesInvoices)..where((t) => t.id.equals(invoiceId))).write(
        SalesInvoicesCompanion(status: const Value('posted'), balancePaise: Value(invoice.totalPaise), updatedAt: Value(DateTime.now())),
      );

      await _audit.log(
        username: actor,
        module: 'Sales',
        action: 'invoice.posted',
        recordRef: invoice.invoiceNo,
        oldValue: 'draft',
        newValue: 'posted',
        device: device,
      );
    });
  }

  /// Reverses a posted invoice: stock goes back in, a reversing journal is
  /// posted, and the invoice is marked `voided` — history is kept intact
  /// rather than mutated, per the audit requirement. Refuses to void an
  /// invoice that already has payments allocated against it, since those
  /// receipts would otherwise reference a balance that no longer makes
  /// sense; reverse the receipts first.
  Future<void> voidInvoice(String invoiceId, {required String actor, required String device}) async {
    final invoice = await (_db.select(_db.salesInvoices)..where((t) => t.id.equals(invoiceId))).getSingle();
    if (invoice.status == 'voided') return;
    if (invoice.status == 'draft') {
      throw StateError('Draft invoices should be deleted, not voided.');
    }
    if (invoice.balancePaise != invoice.totalPaise) {
      throw StateError('This invoice has payments allocated against it — reverse the receipts before voiding.');
    }
    final customer = await (_db.select(_db.customers)..where((t) => t.id.equals(invoice.customerId))).getSingle();
    final items = await itemsFor(invoiceId);

    await _db.transaction(() async {
      var cogsPaise = 0;
      for (final item in items) {
        final product = await (_db.select(_db.products)..where((t) => t.id.equals(item.productId))).getSingle();
        cogsPaise += item.qty * product.purchasePricePaise;
        await _stock.recordMovement(
          productId: item.productId,
          warehouseId: invoice.warehouseId,
          kind: 'in',
          qtyDelta: item.qty,
          unitCostPaise: product.purchasePricePaise,
          refType: 'invoice_reversal',
          refId: invoiceId,
        );
      }

      final arAccount = await _accountIdByCode('1200');
      final salesAccount = await _accountIdByCode('4000');
      final cgstAccount = await _accountIdByCode('2210');
      final sgstAccount = await _accountIdByCode('2211');
      final igstAccount = await _accountIdByCode('2212');
      final cogsAccount = await _accountIdByCode('5000');
      final inventoryAccount = await _accountIdByCode('1400');

      final reversalLines = <({String accountId, int debitPaise, int creditPaise, String particulars})>[
        (accountId: arAccount, debitPaise: 0, creditPaise: invoice.totalPaise, particulars: '${customer.name} (void)'),
        (accountId: salesAccount, debitPaise: invoice.taxableValuePaise, creditPaise: 0, particulars: 'revenue reversed'),
        if (invoice.cgstPaise > 0)
          (accountId: cgstAccount, debitPaise: invoice.cgstPaise, creditPaise: 0, particulars: 'CGST reversed'),
        if (invoice.sgstPaise > 0)
          (accountId: sgstAccount, debitPaise: invoice.sgstPaise, creditPaise: 0, particulars: 'SGST reversed'),
        if (invoice.igstPaise > 0)
          (accountId: igstAccount, debitPaise: invoice.igstPaise, creditPaise: 0, particulars: 'IGST reversed'),
        (accountId: cogsAccount, debitPaise: 0, creditPaise: cogsPaise, particulars: 'moving average reversed'),
        (accountId: inventoryAccount, debitPaise: cogsPaise, creditPaise: 0, particulars: '${items.length} movements IN (void)'),
      ];

      await _accounting.postJournal(
        voucherNo: 'JV/${invoice.invoiceNo.split('/').last}/VOID',
        date: DateTime.now(),
        narration: 'Void ${invoice.invoiceNo} — ${customer.name}',
        sourceType: 'sales_invoice_void',
        sourceId: invoiceId,
        lines: reversalLines,
      );

      await (_db.update(_db.salesInvoices)..where((t) => t.id.equals(invoiceId))).write(
        SalesInvoicesCompanion(status: const Value('voided'), balancePaise: const Value(0), updatedAt: Value(DateTime.now())),
      );

      await _audit.log(
        username: actor,
        module: 'Sales',
        action: 'invoice.voided',
        recordRef: invoice.invoiceNo,
        oldValue: invoice.status,
        newValue: 'voided',
        device: device,
      );
    });
  }
}
