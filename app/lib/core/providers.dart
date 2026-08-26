import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database/app_database.dart';
import 'database/repositories/accounting_repository.dart';
import 'database/repositories/audit_repository.dart';
import 'database/repositories/auth_repository.dart';
import 'database/repositories/collections_repository.dart';
import 'database/repositories/dashboard_repository.dart';
import 'database/repositories/master_data_repository.dart';
import 'database/repositories/sales_repository.dart';
import 'database/repositories/stock_repository.dart';
import 'database/seed.dart';

/// Overridden in [main] once the database is open and seeded — every other
/// provider derives from this one, so nothing can read the database before
/// startup has finished.
final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('databaseProvider must be overridden in main()');
});

Future<AppDatabase> openAndSeedDatabase() async {
  final db = AppDatabase();
  await seedIfEmpty(db);
  return db;
}

final authRepositoryProvider = Provider((ref) => AuthRepository(ref.watch(databaseProvider)));
final masterDataRepositoryProvider = Provider((ref) => MasterDataRepository(ref.watch(databaseProvider)));
final stockRepositoryProvider = Provider((ref) => StockRepository(ref.watch(databaseProvider)));
final accountingRepositoryProvider = Provider((ref) => AccountingRepository(ref.watch(databaseProvider)));
final auditRepositoryProvider = Provider((ref) => AuditRepository(ref.watch(databaseProvider)));
final salesRepositoryProvider = Provider(
  (ref) => SalesRepository(
    ref.watch(databaseProvider),
    ref.watch(accountingRepositoryProvider),
    ref.watch(stockRepositoryProvider),
    ref.watch(auditRepositoryProvider),
  ),
);
final dashboardRepositoryProvider = Provider(
  (ref) => DashboardRepository(
    ref.watch(databaseProvider),
    ref.watch(accountingRepositoryProvider),
    ref.watch(stockRepositoryProvider),
  ),
);
final collectionsRepositoryProvider = Provider(
  (ref) => CollectionsRepository(
    ref.watch(databaseProvider),
    ref.watch(accountingRepositoryProvider),
    ref.watch(auditRepositoryProvider),
  ),
);

/// Recomputes whenever an invoice or a receipt changes — the Collections
/// screen and every "Outstanding" figure derived from it stay live.
final outstandingByCustomerProvider = StreamProvider((ref) async* {
  final db = ref.watch(databaseProvider);
  await for (final _ in db.select(db.salesInvoices).watch()) {
    yield await ref.read(masterDataRepositoryProvider).outstandingByCustomer();
  }
});

/// Recomputes whenever an invoice is inserted/updated — the dashboard's
/// KPIs, chart and reorder alerts all stay live off one dependency.
final dashboardDataProvider = StreamProvider((ref) async* {
  final db = ref.watch(databaseProvider);
  await for (final _ in db.select(db.salesInvoices).watch()) {
    yield await ref.read(dashboardRepositoryProvider).load();
  }
});

/// Recomputes on every journal write — Chart of Accounts and Trial Balance
/// are always live, never a stale snapshot.
final appSettingsMapProvider = FutureProvider((ref) async {
  final db = ref.watch(databaseProvider);
  final rows = await db.select(db.appSettings).get();
  return {for (final r in rows) r.key: r.value};
});

final companyProvider = FutureProvider((ref) async {
  final db = ref.watch(databaseProvider);
  return db.select(db.companies).getSingle();
});

final warehousesProvider = FutureProvider((ref) => ref.watch(masterDataRepositoryProvider).allWarehouses());

final trialBalanceProvider = StreamProvider((ref) async* {
  final db = ref.watch(databaseProvider);
  await for (final _ in db.select(db.journalLines).watch()) {
    yield await ref.read(accountingRepositoryProvider).trialBalance();
  }
});
