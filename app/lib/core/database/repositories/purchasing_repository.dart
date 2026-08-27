import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../app_database.dart';
import 'accounting_repository.dart';
import 'audit_repository.dart';
import 'collections_repository.dart' show PaymentMethod, PaymentMethodLabel;
import 'stock_repository.dart';

const _uuid = Uuid();

/// One line composed in the PO editor before it's ever written to the DB —
/// mirrors [DraftInvoiceLine] on the sales side.
class DraftPoLine {
  const DraftPoLine({required this.product, required this.qty, required this.ratePaise});
  final Product product;
  final int qty;
  final int ratePaise;

  int get amountPaise => qty * ratePaise;
}

/// How much of a PO line the user is receiving right now — may be less
/// than what's still outstanding (partial receipt).
class ReceiveLine {
  const ReceiveLine({required this.poItem, required this.product, required this.qty});
  final PurchaseOrderItem poItem;
  final Product product;
  final int qty;

  int get amountPaise => qty * poItem.ratePaise;
}

class PurchasingRepository {
  PurchasingRepository(this._db, this._accounting, this._stock, this._audit);
  final AppDatabase _db;
  final AccountingRepository _accounting;
  final StockRepository _stock;
  final AuditRepository _audit;

  // ---- Purchase orders -----------------------------------------------------

  Stream<List<PurchaseOrder>> watchPurchaseOrders() =>
      (_db.select(_db.purchaseOrders)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();

  Future<List<PurchaseOrderItem>> itemsForPo(String poId) =>
      (_db.select(_db.purchaseOrderItems)..where((t) => t.poId.equals(poId))).get();

  /// POs that still have at least one line with qty left to receive.
  Future<List<PurchaseOrder>> openPurchaseOrders() async {
    final all = await (_db.select(
      _db.purchaseOrders,
    )..where((t) => t.status.isNotValue('cancelled') & t.status.isNotValue('received'))).get();
    return all;
  }

  Future<String> nextPoNumber() async {
    final existing = await _db.select(_db.purchaseOrders).get();
    return 'PO/${_nextSeq(existing.map((e) => e.poNo), r'PO/(\d+)')}';
  }

  Future<String> createPurchaseOrder({
    required DateTime date,
    required Supplier supplier,
    required String warehouseId,
    required List<DraftPoLine> lines,
    required String actor,
    required String device,
  }) async {
    final poNo = await nextPoNumber();
    final poId = _uuid.v4();
    final total = lines.fold<int>(0, (a, l) => a + l.amountPaise);

    await _db.transaction(() async {
      await _db
          .into(_db.purchaseOrders)
          .insert(
            PurchaseOrdersCompanion.insert(
              id: Value(poId),
              poNo: poNo,
              date: date,
              supplierId: supplier.id,
              warehouseId: warehouseId,
              totalPaise: total,
              status: 'approved',
            ),
          );
      var lineNo = 1;
      for (final line in lines) {
        await _db
            .into(_db.purchaseOrderItems)
            .insert(
              PurchaseOrderItemsCompanion.insert(
                poId: poId,
                productId: line.product.id,
                lineNo: lineNo,
                qty: line.qty,
                ratePaise: line.ratePaise,
              ),
            );
        lineNo++;
      }
      await _audit.log(
        username: actor,
        module: 'Purchasing',
        action: 'po.created',
        recordRef: poNo,
        oldValue: '—',
        newValue: 'approved · ${lines.length} line(s)',
        device: device,
      );
    });
    return poId;
  }

  Future<void> cancelPurchaseOrder(String poId, {required String actor, required String device}) async {
    final po = await (_db.select(_db.purchaseOrders)..where((t) => t.id.equals(poId))).getSingle();
    await (_db.update(_db.purchaseOrders)..where((t) => t.id.equals(poId))).write(
      PurchaseOrdersCompanion(status: const Value('cancelled'), updatedAt: Value(DateTime.now())),
    );
    await _audit.log(
      username: actor,
      module: 'Purchasing',
      action: 'po.cancelled',
      recordRef: po.poNo,
      oldValue: po.status,
      newValue: 'cancelled',
      device: device,
    );
  }

  // ---- Goods receipt --------------------------------------------------------

  Stream<List<GoodsReceipt>> watchGoodsReceipts() =>
      (_db.select(_db.goodsReceipts)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();

  Future<List<GoodsReceiptItem>> itemsForGrn(String grnId) =>
      (_db.select(_db.goodsReceiptItems)..where((t) => t.grnId.equals(grnId))).get();

  Future<String> nextGrnNumber() async {
    final existing = await _db.select(_db.goodsReceipts).get();
    return 'GRN/${_nextSeq(existing.map((e) => e.grnNo), r'GRN/(\d+)')}';
  }

  /// Posts the receipt: stock IN for every line, Dr Inventory / Cr Accounts
  /// Payable for the total, and marks each PO line's received quantity —
  /// the PO moves to part_received or received depending on whether
  /// anything is still outstanding. One transaction, same all-or-nothing
  /// guarantee as invoice posting.
  Future<String> postGoodsReceipt({
    required DateTime date,
    required PurchaseOrder po,
    required Supplier supplier,
    required List<ReceiveLine> lines,
    required String actor,
    required String device,
  }) async {
    final grnNo = await nextGrnNumber();
    final grnId = _uuid.v4();
    final total = lines.fold<int>(0, (a, l) => a + l.amountPaise);

    await _db.transaction(() async {
      await _db
          .into(_db.goodsReceipts)
          .insert(
            GoodsReceiptsCompanion.insert(
              id: Value(grnId),
              grnNo: grnNo,
              date: date,
              poId: po.id,
              supplierId: supplier.id,
              warehouseId: po.warehouseId,
              totalPaise: total,
              balancePaise: total,
              status: 'posted',
            ),
          );

      for (final line in lines) {
        if (line.qty <= 0) continue;
        await _db
            .into(_db.goodsReceiptItems)
            .insert(
              GoodsReceiptItemsCompanion.insert(
                grnId: grnId,
                productId: line.product.id,
                qty: line.qty,
                ratePaise: line.poItem.ratePaise,
                amountPaise: line.amountPaise,
              ),
            );
        await _stock.recordMovement(
          productId: line.product.id,
          warehouseId: po.warehouseId,
          kind: 'in',
          qtyDelta: line.qty,
          unitCostPaise: line.poItem.ratePaise,
          refType: 'grn',
          refId: grnId,
        );
        await (_db.update(_db.purchaseOrderItems)..where((t) => t.id.equals(line.poItem.id))).write(
          PurchaseOrderItemsCompanion(
            receivedQty: Value(line.poItem.receivedQty + line.qty),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }

      final allItems = await (_db.select(_db.purchaseOrderItems)..where((t) => t.poId.equals(po.id))).get();
      final fullyReceived = allItems.every((i) => i.receivedQty >= i.qty);
      final anyReceived = allItems.any((i) => i.receivedQty > 0);
      final newStatus = fullyReceived ? 'received' : (anyReceived ? 'part_received' : po.status);
      await (_db.update(_db.purchaseOrders)..where((t) => t.id.equals(po.id))).write(
        PurchaseOrdersCompanion(status: Value(newStatus), updatedAt: Value(DateTime.now())),
      );

      if (total > 0) {
        final inventoryAccount = await _accountIdByCode('1400');
        final apAccount = await _accountIdByCode('2100');
        await _accounting.postJournal(
          voucherNo: grnNo,
          date: date,
          narration: '$grnNo — ${supplier.name}',
          sourceType: 'goods_receipt',
          sourceId: grnId,
          lines: [
            (accountId: inventoryAccount, debitPaise: total, creditPaise: 0, particulars: '${lines.length} line(s) IN'),
            (accountId: apAccount, debitPaise: 0, creditPaise: total, particulars: supplier.name),
          ],
        );
      }

      await _audit.log(
        username: actor,
        module: 'Purchasing',
        action: 'grn.posted',
        recordRef: grnNo,
        oldValue: '—',
        newValue: 'posted · against ${po.poNo}',
        device: device,
      );
    });
    return grnId;
  }

  // ---- Supplier payments ------------------------------------------------

  Stream<List<SupplierPayment>> watchSupplierPayments() =>
      (_db.select(_db.supplierPayments)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();

  Future<List<GoodsReceipt>> openGoodsReceiptsFor(String supplierId) {
    return (_db.select(_db.goodsReceipts)
          ..where((t) => t.supplierId.equals(supplierId) & t.balancePaise.isBiggerThanValue(0))
          ..orderBy([(t) => OrderingTerm.asc(t.date)]))
        .get();
  }

  /// FIFO across open GRNs, oldest first — same shape as
  /// `CollectionsRepository.autoAdjust`.
  ({List<({GoodsReceipt grn, int amountPaise})> lines, int unallocatedPaise}) autoAdjust(
    List<GoodsReceipt> openGrns,
    int amountPaise,
  ) {
    var remaining = amountPaise;
    final lines = <({GoodsReceipt grn, int amountPaise})>[];
    for (final grn in openGrns) {
      if (remaining <= 0) break;
      final take = remaining < grn.balancePaise ? remaining : grn.balancePaise;
      if (take > 0) {
        lines.add((grn: grn, amountPaise: take));
        remaining -= take;
      }
    }
    return (lines: lines, unallocatedPaise: remaining);
  }

  Future<String> nextPaymentVoucherNumber() async {
    final existing = await _db.select(_db.supplierPayments).get();
    return 'PMT/${_nextSeq(existing.map((e) => e.voucherNo), r'PMT/(\d+)')}';
  }

  Future<String> recordSupplierPayment({
    required DateTime date,
    required Supplier supplier,
    required PaymentMethod method,
    String? reference,
    required int amountPaise,
    required List<({GoodsReceipt grn, int amountPaise})> allocations,
    required int unallocatedPaise,
    required String actor,
    required String device,
  }) async {
    final allocatedTotal = allocations.fold<int>(0, (a, l) => a + l.amountPaise);
    if (allocatedTotal + unallocatedPaise != amountPaise) {
      throw StateError('Allocation ($allocatedTotal) + unallocated ($unallocatedPaise) must equal the amount ($amountPaise).');
    }

    final voucherNo = await nextPaymentVoucherNumber();
    final paymentId = _uuid.v4();

    await _db.transaction(() async {
      await _db
          .into(_db.supplierPayments)
          .insert(
            SupplierPaymentsCompanion.insert(
              id: Value(paymentId),
              voucherNo: voucherNo,
              date: date,
              supplierId: supplier.id,
              method: method.dbValue,
              reference: Value(reference),
              amountPaise: amountPaise,
              unallocatedPaise: Value(unallocatedPaise),
            ),
          );

      for (final line in allocations) {
        await _db
            .into(_db.supplierPaymentAllocations)
            .insert(
              SupplierPaymentAllocationsCompanion.insert(paymentId: paymentId, grnId: line.grn.id, amountPaise: line.amountPaise),
            );
        final newBalance = line.grn.balancePaise - line.amountPaise;
        await (_db.update(_db.goodsReceipts)..where((t) => t.id.equals(line.grn.id))).write(
          GoodsReceiptsCompanion(balancePaise: Value(newBalance < 0 ? 0 : newBalance), updatedAt: Value(DateTime.now())),
        );
      }

      if (allocatedTotal > 0) {
        final cashOrBankAccount = await _accountIdByCode(method.accountCode);
        final apAccount = await _accountIdByCode('2100');
        await _accounting.postJournal(
          voucherNo: voucherNo,
          date: date,
          narration: '$voucherNo — ${supplier.name}',
          sourceType: 'supplier_payment',
          sourceId: paymentId,
          lines: [
            (accountId: apAccount, debitPaise: allocatedTotal, creditPaise: 0, particulars: supplier.name),
            (accountId: cashOrBankAccount, debitPaise: 0, creditPaise: allocatedTotal, particulars: method.label),
          ],
        );
      }

      await _audit.log(
        username: actor,
        module: 'Purchasing',
        action: 'supplier_payment.recorded',
        recordRef: voucherNo,
        oldValue: '—',
        newValue: '${method.label} · ${allocations.length} GRN(s) allocated',
        device: device,
      );
    });
    return paymentId;
  }

  /// Sum of unpaid balance across a supplier's goods receipts — the
  /// "Payable" figure shown on the Suppliers screen.
  Future<Map<String, int>> payableBySupplier() async {
    final rows = await _db.select(_db.goodsReceipts).get();
    final result = <String, int>{};
    for (final r in rows) {
      result[r.supplierId] = (result[r.supplierId] ?? 0) + r.balancePaise;
    }
    return result;
  }

  Future<String> _accountIdByCode(String code) async {
    final account = await (_db.select(_db.accounts)..where((t) => t.code.equals(code))).getSingle();
    return account.id;
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
