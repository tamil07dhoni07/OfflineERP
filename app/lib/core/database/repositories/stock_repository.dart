import 'package:drift/drift.dart';

import '../app_database.dart';

class StockLevel {
  const StockLevel({
    required this.productId,
    required this.warehouseId,
    required this.onHand,
    required this.avgCostPaise,
  });
  final String productId;
  final String warehouseId;
  final int onHand;
  final int avgCostPaise;
}

class StockRow {
  const StockRow({
    required this.product,
    required this.warehouse,
    required this.onHand,
    required this.reserved,
    required this.avgCostPaise,
  });
  final Product product;
  final Warehouse warehouse;
  final int onHand;
  final int reserved;
  final int avgCostPaise;

  int get valuePaise => onHand * avgCostPaise;
}

class StockRepository {
  StockRepository(this._db);
  final AppDatabase _db;

  /// Recomputes on every movement — insertions from a real invoice post
  /// show up here immediately.
  Stream<List<StockRow>> watchStockRows() async* {
    await for (final _ in _db.select(_db.stockMovements).watch()) {
      final levels = await onHandByProductWarehouse();
      final reserved = await reservedByProduct();
      final products = {for (final p in await _db.select(_db.products).get()) p.id: p};
      final warehouses = {for (final w in await _db.select(_db.warehouses).get()) w.id: w};
      final rows = <StockRow>[];
      for (final l in levels) {
        final product = products[l.productId];
        final warehouse = warehouses[l.warehouseId];
        if (product == null || warehouse == null) continue;
        rows.add(
          StockRow(
            product: product,
            warehouse: warehouse,
            onHand: l.onHand,
            reserved: reserved[l.productId] ?? 0,
            avgCostPaise: l.avgCostPaise,
          ),
        );
      }
      yield rows;
    }
  }

  /// On-hand quantity per (product, warehouse), derived by summing the
  /// movement ledger — never stored as a mutable counter.
  Future<List<StockLevel>> onHandByProductWarehouse() async {
    final qtySum = _db.stockMovements.qtyDelta.sum();
    final query = _db.selectOnly(_db.stockMovements)
      ..addColumns([_db.stockMovements.productId, _db.stockMovements.warehouseId, qtySum])
      ..groupBy([_db.stockMovements.productId, _db.stockMovements.warehouseId]);
    final rows = await query.get();
    final result = <StockLevel>[];
    for (final row in rows) {
      final productId = row.read(_db.stockMovements.productId)!;
      final warehouseId = row.read(_db.stockMovements.warehouseId)!;
      final qty = row.read(qtySum) ?? 0;
      final lastCost = await (_db.select(_db.stockMovements)
            ..where((t) => t.productId.equals(productId) & t.warehouseId.equals(warehouseId))
            ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
            ..limit(1))
          .getSingleOrNull();
      result.add(
        StockLevel(
          productId: productId,
          warehouseId: warehouseId,
          onHand: qty,
          avgCostPaise: lastCost?.unitCostPaise ?? 0,
        ),
      );
    }
    return result;
  }

  Future<void> recordMovement({
    required String productId,
    required String warehouseId,
    required String kind,
    required int qtyDelta,
    required int unitCostPaise,
    required String refType,
    required String refId,
    String? batch,
    String? reason,
    String? approvedBy,
  }) {
    return _db
        .into(_db.stockMovements)
        .insert(
          StockMovementsCompanion.insert(
            productId: productId,
            warehouseId: warehouseId,
            kind: kind,
            qtyDelta: qtyDelta,
            unitCostPaise: unitCostPaise,
            refType: refType,
            refId: refId,
            batch: Value(batch),
            reason: Value(reason),
            approvedBy: Value(approvedBy),
          ),
        );
  }

  /// Full movement history for one (product, warehouse) — the "details
  /// page" behind a Stock on Hand row: every sale, receipt, transfer and
  /// adjustment that built up the current on-hand figure, newest first.
  Future<List<StockMovement>> movementsFor(String productId, String warehouseId) {
    return (_db.select(_db.stockMovements)
          ..where((t) => t.productId.equals(productId) & t.warehouseId.equals(warehouseId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .get();
  }

  /// Quantity "soft-reserved" by invoices raised but not yet posted —
  /// matches the design's "stock reserved on post" note: stock is only
  /// actually committed when an invoice posts, but draft invoices already
  /// earmark it so a second draft can't oversell the same units.
  Future<Map<String, int>> reservedByProduct() async {
    final rows = await (_db.select(_db.salesInvoiceItems).join([
      innerJoin(_db.salesInvoices, _db.salesInvoices.id.equalsExp(_db.salesInvoiceItems.invoiceId)),
    ])
          ..where(_db.salesInvoices.status.equals('draft')))
        .get();
    final result = <String, int>{};
    for (final row in rows) {
      final item = row.readTable(_db.salesInvoiceItems);
      result[item.productId] = (result[item.productId] ?? 0) + item.qty;
    }
    return result;
  }
}
