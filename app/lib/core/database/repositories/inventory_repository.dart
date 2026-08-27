import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../app_database.dart';
import 'audit_repository.dart';
import 'stock_repository.dart';

const _uuid = Uuid();

/// Stock Transfers and Adjustments. Both write to the same
/// [StockMovements] ledger [StockRepository] already reads from, so
/// on-hand quantities update the moment either posts — there's no separate
/// counter to keep in sync.
///
/// Neither supports in-place editing of a posted transfer/adjustment, on
/// purpose: mutating a quantity after stock has already moved would corrupt
/// the movement ledger. "Delete" instead posts a reversal (equal and
/// opposite movements) and marks the record `reversed` — the same policy
/// the design already uses for posted invoices ("creates a reversing
/// journal... rather than mutating history").
class InventoryRepository {
  InventoryRepository(this._db, this._stock, this._audit);
  final AppDatabase _db;
  final StockRepository _stock;
  final AuditRepository _audit;

  // ---- Transfers ----------------------------------------------------------

  Stream<List<StockTransfer>> watchTransfers() =>
      (_db.select(_db.stockTransfers)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();

  Future<List<StockTransferItem>> itemsForTransfer(String transferId) =>
      (_db.select(_db.stockTransferItems)..where((t) => t.transferId.equals(transferId))).get();

  Future<String> nextTransferNumber() async {
    final existing = await _db.select(_db.stockTransfers).get();
    return 'TRF/${_nextSeq(existing.map((e) => e.transferNo), r'TRF/(\d+)')}';
  }

  Future<String> createTransfer({
    required DateTime date,
    required Warehouse from,
    required Warehouse to,
    required List<({Product product, int qty})> lines,
    required String actor,
    required String device,
  }) async {
    if (from.id == to.id) throw StateError('Source and destination warehouse must be different.');
    final transferNo = await nextTransferNumber();
    final transferId = _uuid.v4();

    await _db.transaction(() async {
      await _db
          .into(_db.stockTransfers)
          .insert(
            StockTransfersCompanion.insert(
              id: Value(transferId),
              transferNo: transferNo,
              date: date,
              fromWarehouseId: from.id,
              toWarehouseId: to.id,
              status: 'completed',
            ),
          );
      for (final line in lines) {
        if (line.qty <= 0) continue;
        await _db
            .into(_db.stockTransferItems)
            .insert(StockTransferItemsCompanion.insert(transferId: transferId, productId: line.product.id, qty: line.qty));
        await _stock.recordMovement(
          productId: line.product.id,
          warehouseId: from.id,
          kind: 'transfer_out',
          qtyDelta: -line.qty,
          unitCostPaise: line.product.purchasePricePaise,
          refType: 'transfer',
          refId: transferId,
        );
        await _stock.recordMovement(
          productId: line.product.id,
          warehouseId: to.id,
          kind: 'transfer_in',
          qtyDelta: line.qty,
          unitCostPaise: line.product.purchasePricePaise,
          refType: 'transfer',
          refId: transferId,
        );
      }
      await _audit.log(
        username: actor,
        module: 'Inventory',
        action: 'transfer.completed',
        recordRef: transferNo,
        oldValue: '—',
        newValue: '${from.name} → ${to.name} · ${lines.length} line(s)',
        device: device,
      );
    });
    return transferId;
  }

  Future<void> reverseTransfer(String transferId, {required String actor, required String device}) async {
    final transfer = await (_db.select(_db.stockTransfers)..where((t) => t.id.equals(transferId))).getSingle();
    if (transfer.status == 'reversed') return;
    final items = await itemsForTransfer(transferId);

    await _db.transaction(() async {
      for (final item in items) {
        final product = await (_db.select(_db.products)..where((t) => t.id.equals(item.productId))).getSingle();
        await _stock.recordMovement(
          productId: item.productId,
          warehouseId: transfer.toWarehouseId,
          kind: 'transfer_out',
          qtyDelta: -item.qty,
          unitCostPaise: product.purchasePricePaise,
          refType: 'transfer_reversal',
          refId: transferId,
        );
        await _stock.recordMovement(
          productId: item.productId,
          warehouseId: transfer.fromWarehouseId,
          kind: 'transfer_in',
          qtyDelta: item.qty,
          unitCostPaise: product.purchasePricePaise,
          refType: 'transfer_reversal',
          refId: transferId,
        );
      }
      await (_db.update(_db.stockTransfers)..where((t) => t.id.equals(transferId))).write(
        StockTransfersCompanion(status: const Value('reversed'), updatedAt: Value(DateTime.now())),
      );
      await _audit.log(
        username: actor,
        module: 'Inventory',
        action: 'transfer.reversed',
        recordRef: transfer.transferNo,
        oldValue: 'completed',
        newValue: 'reversed',
        device: device,
      );
    });
  }

  // ---- Adjustments ----------------------------------------------------------

  Stream<List<StockAdjustment>> watchAdjustments() =>
      (_db.select(_db.stockAdjustments)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();

  Future<String> nextAdjustmentNumber() async {
    final existing = await _db.select(_db.stockAdjustments).get();
    return 'ADJ/${_nextSeq(existing.map((e) => e.adjustmentNo), r'ADJ/(\d+)')}';
  }

  Future<String> createAdjustment({
    required DateTime date,
    required Product product,
    required Warehouse warehouse,
    required int deltaQty,
    required String reason,
    required String approvedBy,
    required String actor,
    required String device,
  }) async {
    if (deltaQty == 0) throw StateError('Adjustment quantity cannot be zero.');
    final adjustmentNo = await nextAdjustmentNumber();
    final adjustmentId = _uuid.v4();
    final valueImpact = deltaQty * product.purchasePricePaise;

    await _db.transaction(() async {
      await _db
          .into(_db.stockAdjustments)
          .insert(
            StockAdjustmentsCompanion.insert(
              id: Value(adjustmentId),
              adjustmentNo: adjustmentNo,
              date: date,
              productId: product.id,
              warehouseId: warehouse.id,
              deltaQty: deltaQty,
              reason: reason,
              approvedBy: approvedBy,
              valueImpactPaise: valueImpact,
              status: 'posted',
            ),
          );
      await _stock.recordMovement(
        productId: product.id,
        warehouseId: warehouse.id,
        kind: 'adjust',
        qtyDelta: deltaQty,
        unitCostPaise: product.purchasePricePaise,
        refType: 'adjustment',
        refId: adjustmentId,
        reason: reason,
        approvedBy: approvedBy,
      );
      await _audit.log(
        username: actor,
        module: 'Inventory',
        action: 'stock.adjusted',
        recordRef: '${product.sku} · $adjustmentNo',
        oldValue: reason,
        newValue: '${deltaQty > 0 ? '+' : ''}$deltaQty',
        device: device,
      );
    });
    return adjustmentId;
  }

  Future<void> reverseAdjustment(String adjustmentId, {required String actor, required String device}) async {
    final adjustment = await (_db.select(_db.stockAdjustments)..where((t) => t.id.equals(adjustmentId))).getSingle();
    if (adjustment.status == 'reversed') return;
    final product = await (_db.select(_db.products)..where((t) => t.id.equals(adjustment.productId))).getSingle();

    await _db.transaction(() async {
      await _stock.recordMovement(
        productId: adjustment.productId,
        warehouseId: adjustment.warehouseId,
        kind: 'adjust',
        qtyDelta: -adjustment.deltaQty,
        unitCostPaise: product.purchasePricePaise,
        refType: 'adjustment_reversal',
        refId: adjustmentId,
        reason: 'Reversal of ${adjustment.adjustmentNo}',
      );
      await (_db.update(_db.stockAdjustments)..where((t) => t.id.equals(adjustmentId))).write(
        StockAdjustmentsCompanion(status: const Value('reversed'), updatedAt: Value(DateTime.now())),
      );
      await _audit.log(
        username: actor,
        module: 'Inventory',
        action: 'adjustment.reversed',
        recordRef: adjustment.adjustmentNo,
        oldValue: 'posted',
        newValue: 'reversed',
        device: device,
      );
    });
  }
}

String _nextSeq(Iterable<String> existingNumbers, String patternStr) {
  final pattern = RegExp(patternStr);
  var maxSeq = 0;
  for (final no in existingNumbers) {
    final m = pattern.firstMatch(no);
    if (m != null) {
      final seq = int.parse(m.group(1)!);
      if (seq > maxSeq) maxSeq = seq;
    }
  }
  return (maxSeq + 1).toString().padLeft(4, '0');
}
