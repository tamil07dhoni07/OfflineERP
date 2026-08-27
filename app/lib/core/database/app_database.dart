import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../utils/ids.dart';
import 'tables.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    Companies,
    Branches,
    Warehouses,
    AppUsers,
    Customers,
    Suppliers,
    Products,
    StockMovements,
    Accounts,
    JournalEntries,
    JournalLines,
    SalesInvoices,
    SalesInvoiceItems,
    Receipts,
    ReceiptAllocations,
    PurchaseOrders,
    PurchaseOrderItems,
    GoodsReceipts,
    GoodsReceiptItems,
    SupplierPayments,
    SupplierPaymentAllocations,
    AuditLogs,
    AppSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// In-memory database for tests — never touches disk.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.createTable(receipts);
        await m.createTable(receiptAllocations);
      }
      if (from < 3) {
        await m.createTable(purchaseOrders);
        await m.createTable(purchaseOrderItems);
        await m.createTable(goodsReceipts);
        await m.createTable(goodsReceiptItems);
        await m.createTable(supplierPayments);
        await m.createTable(supplierPaymentAllocations);
      }
    },
  );
}

QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'nexus_erp',
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.dart.js'),
    ),
  );
}
