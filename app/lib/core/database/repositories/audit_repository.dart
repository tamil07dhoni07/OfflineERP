import 'package:drift/drift.dart';

import '../app_database.dart';

class AuditRepository {
  AuditRepository(this._db);
  final AppDatabase _db;

  Stream<List<AuditLog>> watchRecent({int limit = 200}) =>
      (_db.select(_db.auditLogs)
            ..orderBy([(t) => OrderingTerm.desc(t.timestamp)])
            ..limit(limit))
          .watch();

  Future<void> log({
    required String username,
    required String module,
    required String action,
    required String recordRef,
    required String oldValue,
    required String newValue,
    required String device,
  }) {
    return _db
        .into(_db.auditLogs)
        .insert(
          AuditLogsCompanion.insert(
            timestamp: DateTime.now(),
            username: username,
            module: module,
            action: action,
            recordRef: recordRef,
            oldValue: oldValue,
            newValue: newValue,
            device: device,
          ),
        );
  }
}
