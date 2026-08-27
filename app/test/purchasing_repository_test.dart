import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_erp/core/database/app_database.dart';
import 'package:nexus_erp/core/database/repositories/accounting_repository.dart';
import 'package:nexus_erp/core/database/repositories/audit_repository.dart';
import 'package:nexus_erp/core/database/repositories/collections_repository.dart';
import 'package:nexus_erp/core/database/repositories/purchasing_repository.dart';
import 'package:nexus_erp/core/database/repositories/stock_repository.dart';

Future<AppDatabase> _openTestDb() async {
  final db = AppDatabase.forTesting(NativeDatabase.memory());
  const accounts = [
    ('1000', 'Cash in Hand', 'Current Assets', 'asset', 'debit'),
    ('1010', 'Bank', 'Current Assets', 'asset', 'debit'),
    ('1400', 'Inventory — Trading Goods', 'Current Assets', 'asset', 'debit'),
    ('2100', 'Accounts Payable', 'Current Liabilities', 'liability', 'credit'),
  ];
  for (final a in accounts) {
    await db
        .into(db.accounts)
        .insert(AccountsCompanion.insert(code: a.$1, name: a.$2, groupName: a.$3, type: a.$4, nature: a.$5));
  }
  return db;
}

Future<Supplier> _insertSupplier(AppDatabase db) {
  return db
      .into(db.suppliers)
      .insertReturning(
        SuppliersCompanion.insert(code: 'S-TEST', name: 'Test Vendor Co', category: 'Raw material', terms: 'Net 30'),
      );
}

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
  group('PurchasingRepository', () {
    late AppDatabase db;
    late AccountingRepository accounting;
    late PurchasingRepository purchasing;

    setUp(() async {
      db = await _openTestDb();
      accounting = AccountingRepository(db);
      purchasing = PurchasingRepository(db, accounting, StockRepository(db), AuditRepository(db));
    });

    tearDown(() => db.close());

    test('creating a PO writes no journal or stock movement — it is only a commitment', () async {
      final supplier = await _insertSupplier(db);
      final product = await _insertProduct(db);

      await purchasing.createPurchaseOrder(
        date: DateTime(2026, 8, 1),
        supplier: supplier,
        warehouseId: 'wh-test',
        lines: [DraftPoLine(product: product, qty: 100, ratePaise: 50000)],
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      final po = (await db.select(db.purchaseOrders).get()).single;
      expect(po.status, 'approved');
      expect(po.totalPaise, 5000000);
      expect(await db.select(db.journalLines).get(), isEmpty);
      expect(await db.select(db.stockMovements).get(), isEmpty);
    });

    test('a full goods receipt posts stock IN, a balanced Dr Inventory / Cr AP journal, and marks the PO received', () async {
      final supplier = await _insertSupplier(db);
      final product = await _insertProduct(db);
      final poId = await purchasing.createPurchaseOrder(
        date: DateTime(2026, 8, 1),
        supplier: supplier,
        warehouseId: 'wh-test',
        lines: [DraftPoLine(product: product, qty: 100, ratePaise: 50000)],
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );
      final po = await (db.select(db.purchaseOrders)..where((t) => t.id.equals(poId))).getSingle();
      final items = await purchasing.itemsForPo(poId);

      await purchasing.postGoodsReceipt(
        date: DateTime(2026, 8, 5),
        po: po,
        supplier: supplier,
        lines: [ReceiveLine(poItem: items.single, product: product, qty: 100)],
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      final updatedPo = await (db.select(db.purchaseOrders)..where((t) => t.id.equals(poId))).getSingle();
      expect(updatedPo.status, 'received');

      final movements = await db.select(db.stockMovements).get();
      expect(movements.single.qtyDelta, 100);

      final lines = await db.select(db.journalLines).get();
      final totalDebit = lines.fold<int>(0, (a, l) => a + l.debitPaise);
      final totalCredit = lines.fold<int>(0, (a, l) => a + l.creditPaise);
      expect(totalDebit, totalCredit);
      expect(totalDebit, 5000000);

      final grn = (await db.select(db.goodsReceipts).get()).single;
      expect(grn.balancePaise, 5000000);

      final logs = await db.select(db.auditLogs).get();
      expect(logs.where((l) => l.action == 'grn.posted'), hasLength(1));
    });

    test('a partial receipt leaves the PO part_received and the remaining qty receivable', () async {
      final supplier = await _insertSupplier(db);
      final product = await _insertProduct(db);
      final poId = await purchasing.createPurchaseOrder(
        date: DateTime(2026, 8, 1),
        supplier: supplier,
        warehouseId: 'wh-test',
        lines: [DraftPoLine(product: product, qty: 100, ratePaise: 50000)],
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );
      final po = await (db.select(db.purchaseOrders)..where((t) => t.id.equals(poId))).getSingle();
      final items = await purchasing.itemsForPo(poId);

      await purchasing.postGoodsReceipt(
        date: DateTime(2026, 8, 5),
        po: po,
        supplier: supplier,
        lines: [ReceiveLine(poItem: items.single, product: product, qty: 40)],
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      final updatedPo = await (db.select(db.purchaseOrders)..where((t) => t.id.equals(poId))).getSingle();
      expect(updatedPo.status, 'part_received');

      final updatedItem = (await purchasing.itemsForPo(poId)).single;
      expect(updatedItem.receivedQty, 40);
      expect(updatedItem.qty - updatedItem.receivedQty, 60);
    });

    test('a supplier payment settles the oldest GRN first and posts Dr AP / Cr Bank', () async {
      final supplier = await _insertSupplier(db);
      final product = await _insertProduct(db);
      final poId = await purchasing.createPurchaseOrder(
        date: DateTime(2026, 8, 1),
        supplier: supplier,
        warehouseId: 'wh-test',
        lines: [DraftPoLine(product: product, qty: 100, ratePaise: 50000)],
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );
      final po = await (db.select(db.purchaseOrders)..where((t) => t.id.equals(poId))).getSingle();
      final items = await purchasing.itemsForPo(poId);
      await purchasing.postGoodsReceipt(
        date: DateTime(2026, 8, 5),
        po: po,
        supplier: supplier,
        lines: [ReceiveLine(poItem: items.single, product: product, qty: 100)],
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      final openGrns = await purchasing.openGoodsReceiptsFor(supplier.id);
      expect(openGrns, hasLength(1));
      final preview = purchasing.autoAdjust(openGrns, 2000000);
      expect(preview.unallocatedPaise, 0);
      expect(preview.lines.single.amountPaise, 2000000);

      await purchasing.recordSupplierPayment(
        date: DateTime(2026, 8, 10),
        supplier: supplier,
        method: PaymentMethod.cheque,
        reference: '112233',
        amountPaise: 2000000,
        allocations: preview.lines,
        unallocatedPaise: 0,
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      final updatedGrn = (await db.select(db.goodsReceipts).get()).single;
      expect(updatedGrn.balancePaise, 3000000);

      final payable = await purchasing.payableBySupplier();
      expect(payable[supplier.id], 3000000);

      final bankAccount = (await db.select(db.accounts).get()).firstWhere((a) => a.code == '1010');
      final lines = await db.select(db.journalLines).get();
      expect(lines.any((l) => l.accountId == bankAccount.id && l.creditPaise == 2000000), isTrue);
    });
  });
}
