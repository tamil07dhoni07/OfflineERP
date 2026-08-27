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

  Future<void> updateCompany(
    String id, {
    required String legalName,
    required String gstin,
    required String pan,
    required String state,
    required String stateCode,
  }) {
    return (_db.update(_db.companies)..where((t) => t.id.equals(id))).write(
      CompaniesCompanion(
        legalName: Value(legalName),
        gstin: Value(gstin),
        pan: Value(pan),
        state: Value(state),
        stateCode: Value(stateCode),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<Customer?> customerById(String id) => (_db.select(_db.customers)..where((t) => t.id.equals(id))).getSingleOrNull();
  Future<Supplier?> supplierById(String id) => (_db.select(_db.suppliers)..where((t) => t.id.equals(id))).getSingleOrNull();
  Future<Product?> productById(String id) => (_db.select(_db.products)..where((t) => t.id.equals(id))).getSingleOrNull();

  Future<void> updateCustomer(
    String id, {
    required String code,
    required String name,
    required String groupName,
    String? gstin,
    required String state,
    required String stateCode,
    required int creditLimitPaise,
  }) {
    return (_db.update(_db.customers)..where((t) => t.id.equals(id))).write(
      CustomersCompanion(
        code: Value(code),
        name: Value(name),
        groupName: Value(groupName),
        gstin: Value(gstin),
        state: Value(state),
        stateCode: Value(stateCode),
        creditLimitPaise: Value(creditLimitPaise),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateSupplier(
    String id, {
    required String code,
    required String name,
    required String category,
    String? gstin,
    required String terms,
  }) {
    return (_db.update(_db.suppliers)..where((t) => t.id.equals(id))).write(
      SuppliersCompanion(
        code: Value(code),
        name: Value(name),
        category: Value(category),
        gstin: Value(gstin),
        terms: Value(terms),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateProduct(
    String id, {
    required String sku,
    required String name,
    required String category,
    required String uom,
    required String hsn,
    required int purchasePricePaise,
    required int sellingPricePaise,
    required double gstRate,
    required int reorderLevel,
  }) {
    return (_db.update(_db.products)..where((t) => t.id.equals(id))).write(
      ProductsCompanion(
        sku: Value(sku),
        name: Value(name),
        category: Value(category),
        uom: Value(uom),
        hsn: Value(hsn),
        purchasePricePaise: Value(purchasePricePaise),
        sellingPricePaise: Value(sellingPricePaise),
        gstRate: Value(gstRate),
        reorderLevel: Value(reorderLevel),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// Soft delete only — rows never physically disappear, per the spec's
  /// "never silently delete production data" rule. Every read already
  /// filters `deletedAt.isNull()`.
  Future<void> deleteCustomer(String id) =>
      (_db.update(_db.customers)..where((t) => t.id.equals(id))).write(CustomersCompanion(deletedAt: Value(DateTime.now())));

  Future<void> deleteSupplier(String id) =>
      (_db.update(_db.suppliers)..where((t) => t.id.equals(id))).write(SuppliersCompanion(deletedAt: Value(DateTime.now())));

  Future<void> deleteProduct(String id) =>
      (_db.update(_db.products)..where((t) => t.id.equals(id))).write(ProductsCompanion(deletedAt: Value(DateTime.now())));
}
