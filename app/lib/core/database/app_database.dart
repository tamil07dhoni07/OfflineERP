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
    StockTransfers,
    StockTransferItems,
    StockAdjustments,
    Employees,
    LeaveRequests,
    AttendanceRecords,
    PayrollRuns,
    Clients,
    ClientLicenses,
    ClientDevices,
    AuditLogs,
    AppSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// In-memory database for tests — never touches disk.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 6;

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
      if (from < 4) {
        await m.createTable(stockTransfers);
        await m.createTable(stockTransferItems);
        await m.createTable(stockAdjustments);
      }
      if (from < 5) {
        await m.createTable(employees);
        await m.createTable(leaveRequests);
        await m.createTable(attendanceRecords);
        await m.createTable(payrollRuns);
      }
      if (from < 6) {
        await m.createTable(clients);
        await m.createTable(clientLicenses);
        await m.createTable(clientDevices);
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
