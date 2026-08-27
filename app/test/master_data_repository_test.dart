import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_erp/core/database/app_database.dart';
import 'package:nexus_erp/core/database/repositories/master_data_repository.dart';

void main() {
  group('MasterDataRepository', () {
    late AppDatabase db;
    late MasterDataRepository repo;

    setUp(() async {
      db = AppDatabase.forTesting(NativeDatabase.memory());
      repo = MasterDataRepository(db);
    });

    tearDown(() => db.close());

    test('updateCompany changes the row in place', () async {
      final companyId = await db
          .into(db.companies)
          .insertReturning(
            CompaniesCompanion.insert(
              legalName: 'Old Name Pvt Ltd',
              gstin: '27AAAAA0000A1Z5',
              pan: 'AAAAA0000A',
              state: 'Maharashtra',
              stateCode: '27',
            ),
          );

      await repo.updateCompany(companyId.id, legalName: 'New Name Pvt Ltd', gstin: '27AAAAA0000A1Z5', pan: 'AAAAA0000A', state: 'Karnataka', stateCode: '29');

      final updated = await (db.select(db.companies)..where((t) => t.id.equals(companyId.id))).getSingle();
      expect(updated.legalName, 'New Name Pvt Ltd');
      expect(updated.state, 'Karnataka');
      expect(updated.stateCode, '29');
    });

    test('deleting a customer is soft — it disappears from watchCustomers but the row survives', () async {
      final customer = await repo.createCustomer(
        code: 'C-TEST',
        name: 'Test Customer',
        groupName: 'Retail',
        state: 'Maharashtra',
        stateCode: '27',
        creditLimitPaise: 100000,
      );

      await repo.deleteCustomer(customer.id);

      final visible = await repo.watchCustomers().first;
      expect(visible, isEmpty);

      final raw = await (db.select(db.customers)..where((t) => t.id.equals(customer.id))).getSingle();
      expect(raw.deletedAt, isNotNull);
    });

    test('editing a product changes its fields without touching its id', () async {
      final product = await repo.createProduct(
        sku: 'SKU-1',
        name: 'Widget',
        category: 'General',
        uom: 'PCS',
        hsn: '00000000',
        purchasePricePaise: 1000,
        sellingPricePaise: 1500,
        gstRate: 18,
        reorderLevel: 10,
      );

      await repo.updateProduct(
        product.id,
        sku: 'SKU-1',
        name: 'Widget Mk2',
        category: 'General',
        uom: 'PCS',
        hsn: '00000000',
        purchasePricePaise: 1200,
        sellingPricePaise: 1800,
        gstRate: 18,
        reorderLevel: 20,
      );

      final updated = await repo.productById(product.id);
      expect(updated!.id, product.id);
      expect(updated.name, 'Widget Mk2');
      expect(updated.sellingPricePaise, 1800);
      expect(updated.reorderLevel, 20);
    });
  });
}
