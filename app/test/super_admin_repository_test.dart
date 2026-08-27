import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_erp/core/database/app_database.dart';
import 'package:nexus_erp/core/database/repositories/audit_repository.dart';
import 'package:nexus_erp/core/database/repositories/super_admin_repository.dart';

void main() {
  group('SuperAdminRepository', () {
    late AppDatabase db;
    late SuperAdminRepository superAdmin;

    setUp(() async {
      db = AppDatabase.forTesting(NativeDatabase.memory());
      superAdmin = SuperAdminRepository(db, AuditRepository(db));
    });

    tearDown(() => db.close());

    test('creating a client also creates an active license with a generated key', () async {
      final clientId = await superAdmin.createClient(
        companyName: 'Test Traders LLP',
        contactEmail: 'ops@testtraders.example',
        plan: 'Starter · 2 devices',
        maxDevices: 2,
        enabledModules: ['Sales', 'Inventory'],
        actor: 'super-admin-test',
        device: 'TEST-DEVICE',
      );

      final license = await superAdmin.licenseFor(clientId);
      expect(license, isNotNull);
      expect(license!.status, 'active');
      expect(license.licenseKey, startsWith('NXS-IN-'));
      expect(license.maxDevices, 2);
      expect(license.enabledModulesCsv, 'Sales,Inventory');

      final logs = await db.select(db.auditLogs).get();
      expect(logs.where((l) => l.action == 'client.created' && l.module == 'SuperAdmin'), hasLength(1));
    });

    test('suspending a client is tracked and reversible via setClientStatus', () async {
      final clientId = await superAdmin.createClient(
        companyName: 'Test Traders LLP',
        contactEmail: 'ops@testtraders.example',
        plan: 'Starter',
        maxDevices: 1,
        enabledModules: const ['Sales'],
        actor: 'super-admin-test',
        device: 'TEST-DEVICE',
      );

      await superAdmin.setClientStatus(clientId, 'suspended', actor: 'super-admin-test', device: 'TEST-DEVICE');
      var client = await (db.select(db.clients)..where((t) => t.id.equals(clientId))).getSingle();
      expect(client.status, 'suspended');

      await superAdmin.setClientStatus(clientId, 'active', actor: 'super-admin-test', device: 'TEST-DEVICE');
      client = await (db.select(db.clients)..where((t) => t.id.equals(clientId))).getSingle();
      expect(client.status, 'active');
    });

    test('renewing a license pushes the expiry forward and reactivates it', () async {
      final clientId = await superAdmin.createClient(
        companyName: 'Test Traders LLP',
        contactEmail: 'ops@testtraders.example',
        plan: 'Starter',
        maxDevices: 1,
        enabledModules: const ['Sales'],
        actor: 'super-admin-test',
        device: 'TEST-DEVICE',
      );
      final license = (await superAdmin.licenseFor(clientId))!;
      await superAdmin.setLicenseStatus(license.id, 'suspended', actor: 'super-admin-test', device: 'TEST-DEVICE');

      final newExpiry = DateTime(2030, 1, 1);
      await superAdmin.renewLicense(license.id, newExpiry, actor: 'super-admin-test', device: 'TEST-DEVICE');

      final renewed = (await superAdmin.licenseFor(clientId))!;
      expect(renewed.status, 'active');
      expect(renewed.expiresAt, newExpiry);
    });

    test('revoking a device flips its status without touching other devices for the same client', () async {
      final clientId = await superAdmin.createClient(
        companyName: 'Test Traders LLP',
        contactEmail: 'ops@testtraders.example',
        plan: 'Starter',
        maxDevices: 2,
        enabledModules: const ['Sales'],
        actor: 'super-admin-test',
        device: 'TEST-DEVICE',
      );
      final deviceA = await db
          .into(db.clientDevices)
          .insertReturning(
            ClientDevicesCompanion.insert(clientId: clientId, deviceId: 'DEV-A', platform: 'Windows', lastSeenAt: DateTime.now(), status: 'active'),
          );
      final deviceB = await db
          .into(db.clientDevices)
          .insertReturning(
            ClientDevicesCompanion.insert(clientId: clientId, deviceId: 'DEV-B', platform: 'Android', lastSeenAt: DateTime.now(), status: 'active'),
          );

      await superAdmin.revokeDevice(deviceA.id, actor: 'super-admin-test', device: 'TEST-DEVICE');

      final devices = await superAdmin.devicesFor(clientId);
      final byId = {for (final d in devices) d.id: d};
      expect(byId[deviceA.id]!.status, 'revoked');
      expect(byId[deviceB.id]!.status, 'active');
    });
  });
}
