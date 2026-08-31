import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_erp/core/database/app_database.dart';
import 'package:nexus_erp/core/database/repositories/accounting_repository.dart';
import 'package:nexus_erp/core/database/repositories/audit_repository.dart';
import 'package:nexus_erp/core/database/repositories/sales_repository.dart';
import 'package:nexus_erp/core/database/repositories/stock_repository.dart';

Future<AppDatabase> _openTestDb() async {
  final db = AppDatabase.forTesting(NativeDatabase.memory());

  const accounts = [
    ('1200', 'Accounts Receivable', 'Current Assets', 'asset', 'debit'),
    ('1400', 'Inventory — Trading Goods', 'Current Assets', 'asset', 'debit'),
    ('2210', 'Output CGST', 'Duties & Taxes', 'liability', 'credit'),
    ('2211', 'Output SGST', 'Duties & Taxes', 'liability', 'credit'),
    ('2212', 'Output IGST', 'Duties & Taxes', 'liability', 'credit'),
    ('4000', 'Sales — Trading Goods', 'Revenue', 'income', 'credit'),
    ('5000', 'Cost of Goods Sold', 'Direct Costs', 'expense', 'debit'),
  ];
  for (final a in accounts) {
    await db
        .into(db.accounts)
        .insert(AccountsCompanion.insert(code: a.$1, name: a.$2, groupName: a.$3, type: a.$4, nature: a.$5));
  }
  return db;
}

Future<Customer> _insertCustomer(AppDatabase db, {required String stateCode}) {
  return db
      .into(db.customers)
      .insertReturning(
        CustomersCompanion.insert(
          code: 'C-TEST',
          name: 'Test Retail LLP',
          groupName: 'Retail',
          state: stateCode == '27' ? 'Maharashtra' : 'Karnataka',
          stateCode: stateCode,
          creditLimitPaise: const Value(100000000),
        ),
      );
}

Future<Product> _insertProduct(AppDatabase db, {int purchase = 50000, int selling = 70000, double gst = 18}) {
  return db
      .into(db.products)
      .insertReturning(
        ProductsCompanion.insert(
          sku: 'SKU-TEST',
          name: 'Test Widget',
          category: 'General',
          uom: 'PCS',
          hsn: '00000000',
          purchasePricePaise: purchase,
          sellingPricePaise: selling,
          gstRate: gst,
        ),
      );
}

void main() {
  group('SalesRepository.postInvoice', () {
    late AppDatabase db;
    late AccountingRepository accounting;
    late StockRepository stock;
    late AuditRepository audit;
    late SalesRepository sales;

    setUp(() async {
      db = await _openTestDb();
      accounting = AccountingRepository(db);
      stock = StockRepository(db);
      audit = AuditRepository(db);
      sales = SalesRepository(db, accounting, stock, audit);
    });

    tearDown(() => db.close());

    test('posting a balanced intra-state invoice writes a balanced journal', () async {
      final customer = await _insertCustomer(db, stateCode: '27');
      final product = await _insertProduct(db);

      await sales.postInvoice(
        invoiceNo: 'INV/TEST/0001',
        date: DateTime(2026, 8, 24),
        customer: customer,
        warehouseId: 'wh-test',
        placeOfSupplyState: customer.state,
        placeOfSupplyCode: customer.stateCode,
        paymentTerms: 'Net 30',
        salesperson: 'Test',
        lines: [DraftInvoiceLine(product: product, qty: 10, ratePaise: 70000, discountPct: 0)],
        interState: false,
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      final invoices = await db.select(db.salesInvoices).get();
      expect(invoices, hasLength(1));
      final invoice = invoices.single;
      expect(invoice.status, 'posted');
      expect(invoice.taxableValuePaise, 700000);
      expect(invoice.cgstPaise, 63000);
      expect(invoice.sgstPaise, 63000);
      expect(invoice.igstPaise, 0);
      expect(invoice.totalPaise, 826000);
      expect(invoice.balancePaise, 826000);

      final items = await db.select(db.salesInvoiceItems).get();
      expect(items, hasLength(1));
      expect(items.single.qty, 10);

      final movements = await db.select(db.stockMovements).get();
      expect(movements, hasLength(1));
      expect(movements.single.qtyDelta, -10);

      final balances = await accounting.trialBalance();
      final totalDebit = balances.fold<int>(0, (a, b) => a + b.debitPaise);
      final totalCredit = balances.fold<int>(0, (a, b) => a + b.creditPaise);
      expect(totalDebit, totalCredit, reason: 'every posted journal entry must balance');
      expect(totalDebit, greaterThan(0));

      final logs = await db.select(db.auditLogs).get();
      expect(logs.where((l) => l.action == 'invoice.posted'), hasLength(1));
    });

    test('posting an inter-state invoice charges IGST only, still balanced', () async {
      final customer = await _insertCustomer(db, stateCode: '29');
      final product = await _insertProduct(db);

      await sales.postInvoice(
        invoiceNo: 'INV/TEST/0002',
        date: DateTime(2026, 8, 24),
        customer: customer,
        warehouseId: 'wh-test',
        placeOfSupplyState: customer.state,
        placeOfSupplyCode: customer.stateCode,
        paymentTerms: 'Net 30',
        salesperson: 'Test',
        lines: [DraftInvoiceLine(product: product, qty: 5, ratePaise: 70000, discountPct: 0)],
        interState: true,
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      final invoice = (await db.select(db.salesInvoices).get()).single;
      expect(invoice.igstPaise, greaterThan(0));
      expect(invoice.cgstPaise, 0);
      expect(invoice.sgstPaise, 0);

      final balances = await accounting.trialBalance();
      final totalDebit = balances.fold<int>(0, (a, b) => a + b.debitPaise);
      final totalCredit = balances.fold<int>(0, (a, b) => a + b.creditPaise);
      expect(totalDebit, totalCredit);
    });

    test('saving as a draft writes no journal and no stock movement', () async {
      final customer = await _insertCustomer(db, stateCode: '27');
      final product = await _insertProduct(db);

      await sales.postInvoice(
        invoiceNo: 'INV/TEST/0003',
        date: DateTime(2026, 8, 24),
        customer: customer,
        warehouseId: 'wh-test',
        placeOfSupplyState: customer.state,
        placeOfSupplyCode: customer.stateCode,
        paymentTerms: 'Net 30',
        salesperson: 'Test',
        lines: [DraftInvoiceLine(product: product, qty: 3, ratePaise: 70000, discountPct: 0)],
        interState: false,
        actor: 'test-user',
        device: 'TEST-DEVICE',
        asDraft: true,
      );

      final invoice = (await db.select(db.salesInvoices).get()).single;
      expect(invoice.status, 'draft');
      expect(invoice.balancePaise, 0);
      expect(await db.select(db.stockMovements).get(), isEmpty);
      expect(await db.select(db.journalLines).get(), isEmpty);
    });
  });

  group('SalesRepository draft edit/delete/void', () {
    late AppDatabase db;
    late AccountingRepository accounting;
    late StockRepository stock;
    late AuditRepository audit;
    late SalesRepository sales;

    setUp(() async {
      db = await _openTestDb();
      accounting = AccountingRepository(db);
      stock = StockRepository(db);
      audit = AuditRepository(db);
      sales = SalesRepository(db, accounting, stock, audit);
    });

    tearDown(() => db.close());

    test('updateDraftInvoice rewrites lines and totals on an existing draft', () async {
      final customer = await _insertCustomer(db, stateCode: '27');
      final product = await _insertProduct(db);

      final invoiceId = await sales.postInvoice(
        invoiceNo: 'INV/TEST/D1',
        date: DateTime(2026, 8, 24),
        customer: customer,
        warehouseId: 'wh-test',
        placeOfSupplyState: customer.state,
        placeOfSupplyCode: customer.stateCode,
        paymentTerms: 'Net 30',
        salesperson: 'Test',
        lines: [DraftInvoiceLine(product: product, qty: 2, ratePaise: 70000, discountPct: 0)],
        interState: false,
        actor: 'test-user',
        device: 'TEST-DEVICE',
        asDraft: true,
      );

      await sales.updateDraftInvoice(
        invoiceId: invoiceId,
        date: DateTime(2026, 8, 25),
        customer: customer,
        warehouseId: 'wh-test',
        placeOfSupplyState: customer.state,
        placeOfSupplyCode: customer.stateCode,
        paymentTerms: 'Net 15',
        salesperson: 'Test 2',
        lines: [DraftInvoiceLine(product: product, qty: 5, ratePaise: 70000, discountPct: 0)],
        interState: false,
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      final invoice = (await db.select(db.salesInvoices).get()).single;
      expect(invoice.status, 'draft');
      expect(invoice.paymentTerms, 'Net 15');
      expect(invoice.taxableValuePaise, 350000);
      final items = await db.select(db.salesInvoiceItems).get();
      expect(items, hasLength(1));
      expect(items.single.qty, 5);
    });

    test('updateDraftInvoice refuses to touch a posted invoice', () async {
      final customer = await _insertCustomer(db, stateCode: '27');
      final product = await _insertProduct(db);
      final invoiceId = await sales.postInvoice(
        invoiceNo: 'INV/TEST/D2',
        date: DateTime(2026, 8, 24),
        customer: customer,
        warehouseId: 'wh-test',
        placeOfSupplyState: customer.state,
        placeOfSupplyCode: customer.stateCode,
        paymentTerms: 'Net 30',
        salesperson: 'Test',
        lines: [DraftInvoiceLine(product: product, qty: 1, ratePaise: 70000, discountPct: 0)],
        interState: false,
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      expect(
        () => sales.updateDraftInvoice(
          invoiceId: invoiceId,
          date: DateTime.now(),
          customer: customer,
          warehouseId: 'wh-test',
          placeOfSupplyState: customer.state,
          placeOfSupplyCode: customer.stateCode,
          paymentTerms: 'Net 30',
          salesperson: 'Test',
          lines: [],
          interState: false,
          actor: 'test-user',
          device: 'TEST-DEVICE',
        ),
        throwsStateError,
      );
    });

    test('deleteDraftInvoice soft-deletes a draft and drops it from the watch list', () async {
      final customer = await _insertCustomer(db, stateCode: '27');
      final product = await _insertProduct(db);
      final invoiceId = await sales.postInvoice(
        invoiceNo: 'INV/TEST/D3',
        date: DateTime(2026, 8, 24),
        customer: customer,
        warehouseId: 'wh-test',
        placeOfSupplyState: customer.state,
        placeOfSupplyCode: customer.stateCode,
        paymentTerms: 'Net 30',
        salesperson: 'Test',
        lines: [DraftInvoiceLine(product: product, qty: 1, ratePaise: 70000, discountPct: 0)],
        interState: false,
        actor: 'test-user',
        device: 'TEST-DEVICE',
        asDraft: true,
      );

      await sales.deleteDraftInvoice(invoiceId, actor: 'test-user', device: 'TEST-DEVICE');

      final invoices = await sales.watchInvoices().first;
      expect(invoices, isEmpty);
    });

    test('deleteDraftInvoice refuses to delete a posted invoice', () async {
      final customer = await _insertCustomer(db, stateCode: '27');
      final product = await _insertProduct(db);
      final invoiceId = await sales.postInvoice(
        invoiceNo: 'INV/TEST/D4',
        date: DateTime(2026, 8, 24),
        customer: customer,
        warehouseId: 'wh-test',
        placeOfSupplyState: customer.state,
        placeOfSupplyCode: customer.stateCode,
        paymentTerms: 'Net 30',
        salesperson: 'Test',
        lines: [DraftInvoiceLine(product: product, qty: 1, ratePaise: 70000, discountPct: 0)],
        interState: false,
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      expect(
        () => sales.deleteDraftInvoice(invoiceId, actor: 'test-user', device: 'TEST-DEVICE'),
        throwsStateError,
      );
    });

    test('postExistingDraft posts stock + a balanced journal and keeps the same id', () async {
      final customer = await _insertCustomer(db, stateCode: '27');
      final product = await _insertProduct(db);
      final invoiceId = await sales.postInvoice(
        invoiceNo: 'INV/TEST/D5',
        date: DateTime(2026, 8, 24),
        customer: customer,
        warehouseId: 'wh-test',
        placeOfSupplyState: customer.state,
        placeOfSupplyCode: customer.stateCode,
        paymentTerms: 'Net 30',
        salesperson: 'Test',
        lines: [DraftInvoiceLine(product: product, qty: 4, ratePaise: 70000, discountPct: 0)],
        interState: false,
        actor: 'test-user',
        device: 'TEST-DEVICE',
        asDraft: true,
      );

      await sales.postExistingDraft(invoiceId, actor: 'test-user', device: 'TEST-DEVICE');

      final invoice = (await db.select(db.salesInvoices).get()).single;
      expect(invoice.id, invoiceId);
      expect(invoice.status, 'posted');
      expect(invoice.balancePaise, invoice.totalPaise);
      expect(await db.select(db.stockMovements).get(), hasLength(1));

      final balances = await accounting.trialBalance();
      final totalDebit = balances.fold<int>(0, (a, b) => a + b.debitPaise);
      final totalCredit = balances.fold<int>(0, (a, b) => a + b.creditPaise);
      expect(totalDebit, totalCredit);
    });

    test('voidInvoice reverses stock and posts a balancing reversal journal', () async {
      final customer = await _insertCustomer(db, stateCode: '27');
      final product = await _insertProduct(db);
      final invoiceId = await sales.postInvoice(
        invoiceNo: 'INV/TEST/D6',
        date: DateTime(2026, 8, 24),
        customer: customer,
        warehouseId: 'wh-test',
        placeOfSupplyState: customer.state,
        placeOfSupplyCode: customer.stateCode,
        paymentTerms: 'Net 30',
        salesperson: 'Test',
        lines: [DraftInvoiceLine(product: product, qty: 6, ratePaise: 70000, discountPct: 0)],
        interState: false,
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      await sales.voidInvoice(invoiceId, actor: 'test-user', device: 'TEST-DEVICE');

      final invoice = (await db.select(db.salesInvoices).get()).single;
      expect(invoice.status, 'voided');
      expect(invoice.balancePaise, 0);

      final movements = await db.select(db.stockMovements).get();
      expect(movements, hasLength(2));
      expect(movements.fold<int>(0, (a, m) => a + m.qtyDelta), 0, reason: 'the reversal must net back to zero stock impact');

      final balances = await accounting.trialBalance();
      final totalDebit = balances.fold<int>(0, (a, b) => a + b.debitPaise);
      final totalCredit = balances.fold<int>(0, (a, b) => a + b.creditPaise);
      expect(totalDebit, totalCredit);

      final logs = await db.select(db.auditLogs).get();
      expect(logs.where((l) => l.action == 'invoice.voided'), hasLength(1));
    });

    test('voidInvoice refuses when the invoice has payments allocated', () async {
      final customer = await _insertCustomer(db, stateCode: '27');
      final product = await _insertProduct(db);
      final invoiceId = await sales.postInvoice(
        invoiceNo: 'INV/TEST/D7',
        date: DateTime(2026, 8, 24),
        customer: customer,
        warehouseId: 'wh-test',
        placeOfSupplyState: customer.state,
        placeOfSupplyCode: customer.stateCode,
        paymentTerms: 'Net 30',
        salesperson: 'Test',
        lines: [DraftInvoiceLine(product: product, qty: 1, ratePaise: 70000, discountPct: 0)],
        interState: false,
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      await (db.update(db.salesInvoices)..where((t) => t.id.equals(invoiceId)))
          .write(SalesInvoicesCompanion(balancePaise: const Value(1)));

      expect(
        () => sales.voidInvoice(invoiceId, actor: 'test-user', device: 'TEST-DEVICE'),
        throwsStateError,
      );
    });
  });

  group('AccountingRepository.postJournal', () {
    test('refuses to commit an unbalanced entry', () async {
      final db = await _openTestDb();
      final accounting = AccountingRepository(db);
      final ar = (await db.select(db.accounts).get()).firstWhere((a) => a.code == '1200');
      final sales = (await db.select(db.accounts).get()).firstWhere((a) => a.code == '4000');

      expect(
        () => accounting.postJournal(
          voucherNo: 'JV/BAD',
          date: DateTime(2026, 1, 1),
          narration: 'unbalanced',
          sourceType: 'manual',
          sourceId: 'x',
          lines: [
            (accountId: ar.id, debitPaise: 1000, creditPaise: 0, particulars: 'x'),
            (accountId: sales.id, debitPaise: 0, creditPaise: 999, particulars: 'y'),
          ],
        ),
        throwsStateError,
      );

      expect(await db.select(db.journalEntries).get(), isEmpty);
      await db.close();
    });
  });
}
