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
      (_db.select(_db.salesInvoices)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();

  Stream<List<({SalesInvoice invoice, Customer customer})>> watchInvoicesWithCustomers() {
    final query = _db.select(_db.salesInvoices).join([
      innerJoin(_db.customers, _db.customers.id.equalsExp(_db.salesInvoices.customerId)),
    ])..orderBy([OrderingTerm.desc(_db.salesInvoices.date)]);
    return query.watch().map(
      (rows) => rows
          .map((r) => (invoice: r.readTable(_db.salesInvoices), customer: r.readTable(_db.customers)))
          .toList(),
    );
  }

  Future<Map<String, SalesInvoiceItem>> firstItemByInvoice() async => {};

  Future<List<SalesInvoiceItem>> itemsFor(String invoiceId) =>
      (_db.select(_db.salesInvoiceItems)..where((t) => t.invoiceId.equals(invoiceId))).get();

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
}
