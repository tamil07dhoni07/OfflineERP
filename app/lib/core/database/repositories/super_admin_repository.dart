import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../app_database.dart';
import 'audit_repository.dart';

const _uuid = Uuid();

/// Super Admin's own control-plane operations — clients, their licenses,
/// their registered devices. Deliberately separate from every other
/// repository: nothing here touches SalesInvoices, StockMovements,
/// JournalEntries, or any other ERP operational table, matching the spec's
/// "Super Admin must NOT have direct access to the client's private ERP
/// transactions" rule.
class SuperAdminRepository {
  SuperAdminRepository(this._db, this._audit);
  final AppDatabase _db;
  final AuditRepository _audit;

  Stream<List<Client>> watchClients() => (_db.select(_db.clients)..orderBy([(t) => OrderingTerm.asc(t.companyName)])).watch();

  Future<ClientLicense?> licenseFor(String clientId) =>
      (_db.select(_db.clientLicenses)..where((t) => t.clientId.equals(clientId))).getSingleOrNull();

  Future<List<ClientDevice>> devicesFor(String clientId) =>
      (_db.select(_db.clientDevices)..where((t) => t.clientId.equals(clientId))).get();

  Future<String> createClient({
    required String companyName,
    required String contactEmail,
    required String plan,
    required int maxDevices,
    required List<String> enabledModules,
    required String actor,
    required String device,
  }) async {
    final clientId = _uuid.v4();
    await _db.transaction(() async {
      await _db
          .into(_db.clients)
          .insert(
            ClientsCompanion.insert(id: Value(clientId), companyName: companyName, contactEmail: contactEmail, status: 'active'),
          );
      final now = DateTime.now();
      await _db
          .into(_db.clientLicenses)
          .insert(
            ClientLicensesCompanion.insert(
              clientId: clientId,
              licenseKey: _generateLicenseKey(),
              plan: plan,
              status: 'active',
              activatedAt: now,
              expiresAt: DateTime(now.year + 1, now.month, now.day),
              maxDevices: maxDevices,
              enabledModulesCsv: enabledModules.join(','),
            ),
          );
      await _audit.log(
        username: actor,
        module: 'SuperAdmin',
        action: 'client.created',
        recordRef: companyName,
        oldValue: '—',
        newValue: 'active · $plan',
        device: device,
      );
    });
    return clientId;
  }

  Future<void> setClientStatus(String clientId, String status, {required String actor, required String device}) async {
    final client = await (_db.select(_db.clients)..where((t) => t.id.equals(clientId))).getSingle();
    await (_db.update(_db.clients)..where((t) => t.id.equals(clientId))).write(
      ClientsCompanion(status: Value(status), updatedAt: Value(DateTime.now())),
    );
    await _audit.log(
      username: actor,
      module: 'SuperAdmin',
      action: 'client.status_changed',
      recordRef: client.companyName,
      oldValue: client.status,
      newValue: status,
      device: device,
    );
  }

  Future<void> setLicenseStatus(String licenseId, String status, {required String actor, required String device}) async {
    final license = await (_db.select(_db.clientLicenses)..where((t) => t.id.equals(licenseId))).getSingle();
    await (_db.update(_db.clientLicenses)..where((t) => t.id.equals(licenseId))).write(
      ClientLicensesCompanion(status: Value(status), updatedAt: Value(DateTime.now())),
    );
    await _audit.log(
      username: actor,
      module: 'SuperAdmin',
      action: 'license.status_changed',
      recordRef: license.licenseKey,
      oldValue: license.status,
      newValue: status,
      device: device,
    );
  }

  Future<void> renewLicense(String licenseId, DateTime newExpiry, {required String actor, required String device}) async {
    final license = await (_db.select(_db.clientLicenses)..where((t) => t.id.equals(licenseId))).getSingle();
    await (_db.update(_db.clientLicenses)..where((t) => t.id.equals(licenseId))).write(
      ClientLicensesCompanion(status: const Value('active'), expiresAt: Value(newExpiry), updatedAt: Value(DateTime.now())),
    );
    await _audit.log(
      username: actor,
      module: 'SuperAdmin',
      action: 'license.renewed',
      recordRef: license.licenseKey,
      oldValue: license.expiresAt.toIso8601String(),
      newValue: newExpiry.toIso8601String(),
      device: device,
    );
  }

  Future<void> revokeDevice(String deviceRowId, {required String actor, required String device}) async {
    final row = await (_db.select(_db.clientDevices)..where((t) => t.id.equals(deviceRowId))).getSingle();
    await (_db.update(_db.clientDevices)..where((t) => t.id.equals(deviceRowId))).write(
      ClientDevicesCompanion(status: const Value('revoked'), updatedAt: Value(DateTime.now())),
    );
    await _audit.log(
      username: actor,
      module: 'SuperAdmin',
      action: 'device.revoked',
      recordRef: row.deviceId,
      oldValue: 'active',
      newValue: 'revoked',
      device: device,
    );
  }

  String _generateLicenseKey() {
    final chars = _uuid.v4().replaceAll('-', '').toUpperCase();
    return 'NXS-IN-${chars.substring(0, 4)}-${chars.substring(4, 8)}-${chars.substring(8, 11)}';
  }
}
