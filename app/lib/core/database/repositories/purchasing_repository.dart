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

  /// Reverses a posted receipt: stock goes back out, the PO's received
  /// quantities and status roll back, and a reversing Cr Inventory / Dr AP
  /// journal is posted — the receipt stays on record as voided rather than
  /// being deleted, same "reversal, not edit" policy as invoices. Refused
  /// if a supplier payment has already been allocated against it, since
  /// that payment would otherwise reference a balance that no longer
  /// makes sense; reverse the payment first.
  Future<void> voidGoodsReceipt(String grnId, {required String actor, required String device}) async {
    final grn = await (_db.select(_db.goodsReceipts)..where((t) => t.id.equals(grnId))).getSingle();
    if (grn.status == 'voided') return;
    if (grn.balancePaise != grn.totalPaise) {
      throw StateError('A payment has been allocated against this receipt — reverse the payment before voiding.');
    }
    final supplier = await (_db.select(_db.suppliers)..where((t) => t.id.equals(grn.supplierId))).getSingle();
    final items = await itemsForGrn(grnId);

    await _db.transaction(() async {
      for (final item in items) {
        await _stock.recordMovement(
          productId: item.productId,
          warehouseId: grn.warehouseId,
          kind: 'out',
          qtyDelta: -item.qty,
          unitCostPaise: item.ratePaise,
          refType: 'grn_reversal',
          refId: grnId,
        );
        final poItems = await (_db.select(_db.purchaseOrderItems)
              ..where((t) => t.poId.equals(grn.poId) & t.productId.equals(item.productId)))
            .get();
        if (poItems.isNotEmpty) {
          final poItem = poItems.first;
          await (_db.update(_db.purchaseOrderItems)..where((t) => t.id.equals(poItem.id))).write(
            PurchaseOrderItemsCompanion(
              receivedQty: Value(poItem.receivedQty - item.qty < 0 ? 0 : poItem.receivedQty - item.qty),
              updatedAt: Value(DateTime.now()),
            ),
          );
        }
      }

      final po = await (_db.select(_db.purchaseOrders)..where((t) => t.id.equals(grn.poId))).getSingleOrNull();
      if (po != null && po.status != 'cancelled') {
        final allItems = await (_db.select(_db.purchaseOrderItems)..where((t) => t.poId.equals(grn.poId))).get();
        final anyReceived = allItems.any((i) => i.receivedQty > 0);
        final fullyReceived = allItems.every((i) => i.receivedQty >= i.qty);
        final newStatus = fullyReceived ? 'received' : (anyReceived ? 'part_received' : 'approved');
        await (_db.update(_db.purchaseOrders)..where((t) => t.id.equals(grn.poId))).write(
          PurchaseOrdersCompanion(status: Value(newStatus), updatedAt: Value(DateTime.now())),
        );
      }

      if (grn.totalPaise > 0) {
        final inventoryAccount = await _accountIdByCode('1400');
        final apAccount = await _accountIdByCode('2100');
        await _accounting.postJournal(
          voucherNo: '${grn.grnNo}/VOID',
          date: DateTime.now(),
          narration: 'Void ${grn.grnNo} — ${supplier.name}',
          sourceType: 'goods_receipt_void',
          sourceId: grnId,
          lines: [
            (accountId: apAccount, debitPaise: grn.totalPaise, creditPaise: 0, particulars: '${supplier.name} (void)'),
            (accountId: inventoryAccount, debitPaise: 0, creditPaise: grn.totalPaise, particulars: '${items.length} movements OUT (void)'),
          ],
        );
      }

      await (_db.update(_db.goodsReceipts)..where((t) => t.id.equals(grnId))).write(
        GoodsReceiptsCompanion(status: const Value('voided'), balancePaise: const Value(0), updatedAt: Value(DateTime.now())),
      );

      await _audit.log(
        username: actor,
        module: 'Purchasing',
        action: 'grn.voided',
        recordRef: grn.grnNo,
        oldValue: 'posted',
        newValue: 'voided',
        device: device,
      );
    });
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

  Future<List<SupplierPaymentAllocation>> allocationsForPayment(String paymentId) =>
      (_db.select(_db.supplierPaymentAllocations)..where((t) => t.paymentId.equals(paymentId))).get();

  /// Reverses a payment: every GRN it was allocated against gets its
  /// balance restored, and a reversing Dr Bank / Cr AP journal is posted.
  /// The voucher stays on record as voided rather than deleted.
  Future<void> voidSupplierPayment(String paymentId, {required String actor, required String device}) async {
    final payment = await (_db.select(_db.supplierPayments)..where((t) => t.id.equals(paymentId))).getSingle();
    if (payment.status == 'voided') return;
    final supplier = await (_db.select(_db.suppliers)..where((t) => t.id.equals(payment.supplierId))).getSingle();
    final allocations = await allocationsForPayment(paymentId);
    final allocatedTotal = allocations.fold<int>(0, (a, l) => a + l.amountPaise);

    await _db.transaction(() async {
      for (final alloc in allocations) {
        final grn = await (_db.select(_db.goodsReceipts)..where((t) => t.id.equals(alloc.grnId))).getSingleOrNull();
        if (grn == null) continue;
        final restored = grn.balancePaise + alloc.amountPaise;
        await (_db.update(_db.goodsReceipts)..where((t) => t.id.equals(grn.id))).write(
          GoodsReceiptsCompanion(
            balancePaise: Value(restored > grn.totalPaise ? grn.totalPaise : restored),
            updatedAt: Value(DateTime.now()),
          ),
        );
      }

      if (allocatedTotal > 0) {
        final method = PaymentMethod.values.byName(payment.method);
        final cashOrBankAccount = await _accountIdByCode(method.accountCode);
        final apAccount = await _accountIdByCode('2100');
        await _accounting.postJournal(
          voucherNo: '${payment.voucherNo}/VOID',
          date: DateTime.now(),
          narration: 'Void ${payment.voucherNo} — ${supplier.name}',
          sourceType: 'supplier_payment_void',
          sourceId: paymentId,
          lines: [
            (accountId: cashOrBankAccount, debitPaise: allocatedTotal, creditPaise: 0, particulars: '${method.label} (void)'),
            (accountId: apAccount, debitPaise: 0, creditPaise: allocatedTotal, particulars: '${supplier.name} (void)'),
          ],
        );
      }

      await (_db.update(_db.supplierPayments)..where((t) => t.id.equals(paymentId)))
          .write(const SupplierPaymentsCompanion(status: Value('voided')));

      await _audit.log(
        username: actor,
        module: 'Purchasing',
        action: 'supplier_payment.voided',
        recordRef: payment.voucherNo,
        oldValue: 'posted',
        newValue: 'voided',
        device: device,
      );
    });
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
