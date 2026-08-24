import 'package:drift/drift.dart';

import '../app_database.dart';

class MasterDataRepository {
  MasterDataRepository(this._db);
  final AppDatabase _db;

  Stream<List<Customer>> watchCustomers() =>
      (_db.select(_db.customers)..where((t) => t.deletedAt.isNull())..orderBy([(t) => OrderingTerm.desc(t.code)]))
          .watch();

  Stream<List<Supplier>> watchSuppliers() =>
      (_db.select(_db.suppliers)..where((t) => t.deletedAt.isNull())..orderBy([(t) => OrderingTerm.desc(t.code)]))
          .watch();

  Future<List<Warehouse>> allWarehouses() => _db.select(_db.warehouses).get();

  Stream<List<Product>> watchProducts() =>
      (_db.select(_db.products)..where((t) => t.deletedAt.isNull())..orderBy([(t) => OrderingTerm.asc(t.sku)]))
          .watch();

  Future<List<Product>> allActiveProducts() =>
      (_db.select(_db.products)..where((t) => t.deletedAt.isNull() & t.active.equals(true))).get();

  /// Sum of unpaid balance across a customer's posted invoices — the
  /// "Outstanding" figure shown on the Customers screen, derived live
  /// rather than stored redundantly on the customer row.
  Future<Map<String, int>> outstandingByCustomer() async {
    final rows = await _db.select(_db.salesInvoices).get();
    final result = <String, int>{};
    for (final r in rows) {
      result[r.customerId] = (result[r.customerId] ?? 0) + r.balancePaise;
    }
    return result;
  }

  Future<Customer> createCustomer({
    required String code,
    required String name,
    required String groupName,
    String? gstin,
    required String state,
    required String stateCode,
    required int creditLimitPaise,
  }) async {
    final companion = CustomersCompanion.insert(
      code: code,
      name: name,
      groupName: groupName,
      gstin: Value(gstin),
      state: state,
      stateCode: stateCode,
      creditLimitPaise: Value(creditLimitPaise),
    );
    final id = await _db.into(_db.customers).insertReturning(companion);
    return id;
  }

  Future<Supplier> createSupplier({
    required String code,
    required String name,
    required String category,
    String? gstin,
    required String terms,
  }) async {
    final companion = SuppliersCompanion.insert(
      code: code,
      name: name,
      category: category,
      gstin: Value(gstin),
      terms: terms,
    );
    return _db.into(_db.suppliers).insertReturning(companion);
  }

  Future<Product> createProduct({
    required String sku,
    required String name,
    required String category,
    required String uom,
    required String hsn,
    required int purchasePricePaise,
    required int sellingPricePaise,
    required double gstRate,
    required int reorderLevel,
  }) async {
    final companion = ProductsCompanion.insert(
      sku: sku,
      name: name,
      category: category,
      uom: uom,
      hsn: hsn,
      purchasePricePaise: purchasePricePaise,
      sellingPricePaise: sellingPricePaise,
      gstRate: gstRate,
      reorderLevel: Value(reorderLevel),
    );
    return _db.into(_db.products).insertReturning(companion);
  }
}
