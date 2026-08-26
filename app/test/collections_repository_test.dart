import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_erp/core/database/app_database.dart';
import 'package:nexus_erp/core/database/repositories/accounting_repository.dart';
import 'package:nexus_erp/core/database/repositories/audit_repository.dart';
import 'package:nexus_erp/core/database/repositories/collections_repository.dart';

Future<AppDatabase> _openTestDb() async {
  final db = AppDatabase.forTesting(NativeDatabase.memory());
  const accounts = [
    ('1000', 'Cash in Hand', 'Current Assets', 'asset', 'debit'),
    ('1010', 'Bank', 'Current Assets', 'asset', 'debit'),
    ('1200', 'Accounts Receivable', 'Current Assets', 'asset', 'debit'),
  ];
  for (final a in accounts) {
    await db
        .into(db.accounts)
        .insert(AccountsCompanion.insert(code: a.$1, name: a.$2, groupName: a.$3, type: a.$4, nature: a.$5));
  }
  return db;
}

Future<Customer> _insertCustomer(AppDatabase db) {
  return db
      .into(db.customers)
      .insertReturning(
        CustomersCompanion.insert(
          code: 'C-TEST',
          name: 'Test Retail LLP',
          groupName: 'Retail',
          state: 'Maharashtra',
          stateCode: '27',
          creditLimitPaise: const Value(100000000),
        ),
      );
}

Future<SalesInvoice> _insertInvoice(
  AppDatabase db, {
  required String customerId,
  required String invoiceNo,
  required int totalPaise,
  required int balancePaise,
  required DateTime date,
  String status = 'posted',
}) {
  return db
      .into(db.salesInvoices)
      .insertReturning(
        SalesInvoicesCompanion.insert(
          invoiceNo: invoiceNo,
          date: date,
          customerId: customerId,
          warehouseId: 'wh-test',
          placeOfSupplyState: 'Maharashtra',
          placeOfSupplyCode: '27',
          paymentTerms: 'Net 30',
          salesperson: 'Test',
          taxableValuePaise: totalPaise,
          totalPaise: totalPaise,
          balancePaise: balancePaise,
          status: status,
        ),
      );
}

void main() {
  group('CollectionsRepository', () {
    late AppDatabase db;
    late CollectionsRepository collections;

    setUp(() async {
      db = await _openTestDb();
      collections = CollectionsRepository(db, AccountingRepository(db), AuditRepository(db));
    });

    tearDown(() => db.close());

    test('autoAdjust fills the oldest invoice first, then the next', () async {
      final customer = await _insertCustomer(db);
      final older = await _insertInvoice(
        db,
        customerId: customer.id,
        invoiceNo: 'INV/0001',
        totalPaise: 100000,
        balancePaise: 100000,
        date: DateTime(2026, 8, 1),
      );
      final newer = await _insertInvoice(
        db,
        customerId: customer.id,
        invoiceNo: 'INV/0002',
        totalPaise: 200000,
        balancePaise: 200000,
        date: DateTime(2026, 8, 10),
      );

      final open = await collections.openInvoicesFor(customer.id);
      expect(open.map((i) => i.invoiceNo), [older.invoiceNo, newer.invoiceNo]);

      final result = collections.autoAdjust(open, 150000);
      expect(result.unallocatedPaise, 0);
      expect(result.lines, hasLength(2));
      expect(result.lines[0].invoice.id, older.id);
      expect(result.lines[0].amountPaise, 100000);
      expect(result.lines[1].invoice.id, newer.id);
      expect(result.lines[1].amountPaise, 50000);
    });

    test('autoAdjust reports the leftover when the payment exceeds everything owed', () async {
      final customer = await _insertCustomer(db);
      final invoice = await _insertInvoice(
        db,
        customerId: customer.id,
        invoiceNo: 'INV/0001',
        totalPaise: 100000,
        balancePaise: 100000,
        date: DateTime(2026, 8, 1),
      );

      final result = collections.autoAdjust([invoice], 150000);
      expect(result.lines.single.amountPaise, 100000);
      expect(result.unallocatedPaise, 50000);
    });

    test('recordCollection fully settles an invoice and posts a balanced Dr Cash / Cr AR journal', () async {
      final customer = await _insertCustomer(db);
      final invoice = await _insertInvoice(
        db,
        customerId: customer.id,
        invoiceNo: 'INV/0001',
        totalPaise: 100000,
        balancePaise: 100000,
        date: DateTime(2026, 8, 1),
      );

      await collections.recordCollection(
        date: DateTime(2026, 8, 15),
        customer: customer,
        method: PaymentMethod.cash,
        amountPaise: 100000,
        allocations: [AllocationLine(invoice: invoice, amountPaise: 100000)],
        unallocatedPaise: 0,
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      final updated = await (db.select(db.salesInvoices)..where((t) => t.id.equals(invoice.id))).getSingle();
      expect(updated.balancePaise, 0);
      expect(updated.status, 'paid');

      final lines = await db.select(db.journalLines).get();
      final totalDebit = lines.fold<int>(0, (a, l) => a + l.debitPaise);
      final totalCredit = lines.fold<int>(0, (a, l) => a + l.creditPaise);
      expect(totalDebit, totalCredit);
      expect(totalDebit, 100000);

      final receipts = await db.select(db.receipts).get();
      expect(receipts.single.voucherNo, 'RCP/0001');

      final logs = await db.select(db.auditLogs).get();
      expect(logs.where((l) => l.action == 'receipt.recorded'), hasLength(1));
    });

    test('a partial collection leaves the invoice part_paid with a smaller balance', () async {
      final customer = await _insertCustomer(db);
      final invoice = await _insertInvoice(
        db,
        customerId: customer.id,
        invoiceNo: 'INV/0001',
        totalPaise: 100000,
        balancePaise: 100000,
        date: DateTime(2026, 8, 1),
      );

      await collections.recordCollection(
        date: DateTime(2026, 8, 15),
        customer: customer,
        method: PaymentMethod.cheque,
        reference: '882104',
        amountPaise: 40000,
        allocations: [AllocationLine(invoice: invoice, amountPaise: 40000)],
        unallocatedPaise: 0,
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      final updated = await (db.select(db.salesInvoices)..where((t) => t.id.equals(invoice.id))).getSingle();
      expect(updated.balancePaise, 60000);
      expect(updated.status, 'part_paid');

      final bankAccount = (await db.select(db.accounts).get()).firstWhere((a) => a.code == '1010');
      final lines = await db.select(db.journalLines).get();
      expect(lines.any((l) => l.accountId == bankAccount.id && l.debitPaise == 40000), isTrue);
    });

    test('rejects mismatched allocation vs collected amount before writing anything', () async {
      final customer = await _insertCustomer(db);
      final invoice = await _insertInvoice(
        db,
        customerId: customer.id,
        invoiceNo: 'INV/0001',
        totalPaise: 100000,
        balancePaise: 100000,
        date: DateTime(2026, 8, 1),
      );

      expect(
        () => collections.recordCollection(
          date: DateTime(2026, 8, 15),
          customer: customer,
          method: PaymentMethod.cash,
          amountPaise: 100000,
          allocations: [AllocationLine(invoice: invoice, amountPaise: 40000)],
          unallocatedPaise: 0,
          actor: 'test-user',
          device: 'TEST-DEVICE',
        ),
        throwsStateError,
      );
      expect(await db.select(db.receipts).get(), isEmpty);
    });
  });
}
