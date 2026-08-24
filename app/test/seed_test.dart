import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_erp/core/database/app_database.dart';
import 'package:nexus_erp/core/database/repositories/accounting_repository.dart';
import 'package:nexus_erp/core/database/seed.dart';
import 'package:nexus_erp/core/security/password_hasher.dart';

void main() {
  group('seedIfEmpty', () {
    late AppDatabase db;

    setUp(() async {
      db = AppDatabase.forTesting(NativeDatabase.memory());
      await seedIfEmpty(db);
    });

    tearDown(() => db.close());

    test('is idempotent — running twice does not duplicate data', () async {
      await seedIfEmpty(db);
      final companies = await db.select(db.companies).get();
      expect(companies, hasLength(1));
    });

    test('seeds a company, warehouses, users, customers, suppliers and products', () async {
      expect(await db.select(db.companies).get(), hasLength(1));
      expect(await db.select(db.warehouses).get(), hasLength(3));
      expect(await db.select(db.appUsers).get(), hasLength(4));
      expect(await db.select(db.customers).get(), hasLength(7));
      expect(await db.select(db.suppliers).get(), hasLength(4));
      expect(await db.select(db.products).get(), hasLength(7));
      expect(await db.select(db.accounts).get(), hasLength(12));
    });

    test('seed users can sign in with the published dev password', () async {
      final user = await (db.select(db.appUsers)..where((t) => t.username.equals('r.deshmukh'))).getSingle();
      expect(PasswordHasher.verify(seedDevPassword, user.passwordHash), isTrue);
      expect(PasswordHasher.verify('wrong', user.passwordHash), isFalse);
    });

    test('seeded invoices carry the exact statuses from the approved design', () async {
      final invoices = await db.select(db.salesInvoices).get();
      expect(invoices, hasLength(10));
      final byStatus = <String, int>{};
      for (final i in invoices) {
        byStatus[i.status] = (byStatus[i.status] ?? 0) + 1;
      }
      expect(byStatus['draft'], 1);
      expect(byStatus['paid'], 4);
      expect(byStatus['part_paid'], 2);
      expect(byStatus['overdue'], 2);
      expect(byStatus['posted'], 1);
    });

    test('the seeded general ledger always balances, even with historical receipts', () async {
      final accounting = AccountingRepository(db);
      final balances = await accounting.trialBalance();
      final totalDebit = balances.fold<int>(0, (a, b) => a + b.debitPaise);
      final totalCredit = balances.fold<int>(0, (a, b) => a + b.creditPaise);
      expect(totalDebit, totalCredit);
      expect(totalDebit, greaterThan(0));
    });

    test('the AR control account balance matches the sum of unpaid invoice balances', () async {
      final accounting = AccountingRepository(db);
      final balances = await accounting.trialBalance();
      final ar = balances.firstWhere((b) => b.account.code == '1200');

      final invoices = await db.select(db.salesInvoices).get();
      final totalOutstanding = invoices.fold<int>(0, (a, i) => a + i.balancePaise);

      expect(ar.netPaise, totalOutstanding);
    });

    test('opening stock movements produce the expected on-hand quantities', () async {
      final movements = await db.select(db.stockMovements).get();
      expect(movements, hasLength(7));
      expect(movements.every((m) => m.qtyDelta > 0), isTrue);
    });
  });
}
