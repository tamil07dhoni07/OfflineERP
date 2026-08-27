import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_erp/core/database/app_database.dart';
import 'package:nexus_erp/core/database/repositories/audit_repository.dart';
import 'package:nexus_erp/core/database/repositories/inventory_repository.dart';
import 'package:nexus_erp/core/database/repositories/stock_repository.dart';

Future<AppDatabase> _openTestDb() async => AppDatabase.forTesting(NativeDatabase.memory());

Future<Product> _insertProduct(AppDatabase db) {
  return db
      .into(db.products)
      .insertReturning(
        ProductsCompanion.insert(
          sku: 'SKU-TEST',
          name: 'Test Widget',
          category: 'General',
          uom: 'PCS',
          hsn: '00000000',
          purchasePricePaise: 50000,
          sellingPricePaise: 70000,
          gstRate: 18,
        ),
      );
}

void main() {
  group('InventoryRepository', () {
    late AppDatabase db;
    late InventoryRepository inventory;
    late StockRepository stock;

    setUp(() async {
      db = await _openTestDb();
      stock = StockRepository(db);
      inventory = InventoryRepository(db, stock, AuditRepository(db));
    });

    tearDown(() => db.close());

    test('transferring stock moves it out of one warehouse and into another', () async {
      final product = await _insertProduct(db);
      await stock.recordMovement(
        productId: product.id,
        warehouseId: 'wh-a',
        kind: 'in',
        qtyDelta: 100,
        unitCostPaise: 50000,
        refType: 'opening',
        refId: 'opening',
      );

      await inventory.createTransfer(
        date: DateTime(2026, 8, 1),
        from: Warehouse(id: 'wh-a', branchId: 'b', name: 'WH A', notes: null, createdAt: DateTime.now(), updatedAt: DateTime.now(), deletedAt: null),
        to: Warehouse(id: 'wh-b', branchId: 'b', name: 'WH B', notes: null, createdAt: DateTime.now(), updatedAt: DateTime.now(), deletedAt: null),
        lines: [(product: product, qty: 40)],
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      final levels = await stock.onHandByProductWarehouse();
      final byWarehouse = {for (final l in levels) l.warehouseId: l.onHand};
      expect(byWarehouse['wh-a'], 60);
      expect(byWarehouse['wh-b'], 40);

      final logs = await db.select(db.auditLogs).get();
      expect(logs.where((l) => l.action == 'transfer.completed'), hasLength(1));
    });

    test('reversing a transfer moves the quantity back', () async {
      final product = await _insertProduct(db);
      await stock.recordMovement(
        productId: product.id,
        warehouseId: 'wh-a',
        kind: 'in',
        qtyDelta: 100,
        unitCostPaise: 50000,
        refType: 'opening',
        refId: 'opening',
      );
      final wa = Warehouse(id: 'wh-a', branchId: 'b', name: 'WH A', notes: null, createdAt: DateTime.now(), updatedAt: DateTime.now(), deletedAt: null);
      final wb = Warehouse(id: 'wh-b', branchId: 'b', name: 'WH B', notes: null, createdAt: DateTime.now(), updatedAt: DateTime.now(), deletedAt: null);
      final transferId = await inventory.createTransfer(
        date: DateTime(2026, 8, 1),
        from: wa,
        to: wb,
        lines: [(product: product, qty: 40)],
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      await inventory.reverseTransfer(transferId, actor: 'test-user', device: 'TEST-DEVICE');

      final levels = await stock.onHandByProductWarehouse();
      final byWarehouse = {for (final l in levels) l.warehouseId: l.onHand};
      expect(byWarehouse['wh-a'], 100);
      expect(byWarehouse['wh-b'] ?? 0, 0);

      final transfer = (await db.select(db.stockTransfers).get()).single;
      expect(transfer.status, 'reversed');
    });

    test('a negative adjustment reduces on-hand and records a negative value impact', () async {
      final product = await _insertProduct(db);
      await stock.recordMovement(
        productId: product.id,
        warehouseId: 'wh-a',
        kind: 'in',
        qtyDelta: 100,
        unitCostPaise: 50000,
        refType: 'opening',
        refId: 'opening',
      );
      final wa = Warehouse(id: 'wh-a', branchId: 'b', name: 'WH A', notes: null, createdAt: DateTime.now(), updatedAt: DateTime.now(), deletedAt: null);

      await inventory.createAdjustment(
        date: DateTime(2026, 8, 1),
        product: product,
        warehouse: wa,
        deltaQty: -10,
        reason: 'Damage in handling',
        approvedBy: 'R. Deshmukh',
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      final levels = await stock.onHandByProductWarehouse();
      expect(levels.single.onHand, 90);

      final adjustment = (await db.select(db.stockAdjustments).get()).single;
      expect(adjustment.deltaQty, -10);
      expect(adjustment.valueImpactPaise, -500000);

      final logs = await db.select(db.auditLogs).get();
      expect(logs.where((l) => l.action == 'stock.adjusted'), hasLength(1));
    });

    test('reversing an adjustment restores the original quantity', () async {
      final product = await _insertProduct(db);
      await stock.recordMovement(
        productId: product.id,
        warehouseId: 'wh-a',
        kind: 'in',
        qtyDelta: 100,
        unitCostPaise: 50000,
        refType: 'opening',
        refId: 'opening',
      );
      final wa = Warehouse(id: 'wh-a', branchId: 'b', name: 'WH A', notes: null, createdAt: DateTime.now(), updatedAt: DateTime.now(), deletedAt: null);
      final adjustmentId = await inventory.createAdjustment(
        date: DateTime(2026, 8, 1),
        product: product,
        warehouse: wa,
        deltaQty: -10,
        reason: 'Damage',
        approvedBy: 'R. Deshmukh',
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      await inventory.reverseAdjustment(adjustmentId, actor: 'test-user', device: 'TEST-DEVICE');

      final levels = await stock.onHandByProductWarehouse();
      expect(levels.single.onHand, 100);
    });
  });
}
