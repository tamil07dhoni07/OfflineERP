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
    AuditLogs,
    AppSettings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  /// In-memory database for tests — never touches disk.
  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
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
