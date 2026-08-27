import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_erp/core/security/roles.dart';

void main() {
  group('AppRole.fromDb', () {
    test('parses every seeded role slug back to its enum value', () {
      expect(AppRole.fromDb('admin'), AppRole.admin);
      expect(AppRole.fromDb('accountant'), AppRole.accountant);
      expect(AppRole.fromDb('sales'), AppRole.sales);
      expect(AppRole.fromDb('store'), AppRole.store);
      expect(AppRole.fromDb('hr'), AppRole.hr);
      expect(AppRole.fromDb('auditor'), AppRole.auditor);
      expect(AppRole.fromDb('superAdmin'), AppRole.superAdmin);
    });

    test('falls back to admin for an unrecognised value rather than throwing', () {
      expect(AppRole.fromDb('not-a-real-role'), AppRole.admin);
    });
  });

  group('navKeyAllowedFor', () {
    test('admin can reach every ERP module', () {
      for (final key in roleNavAccess[AppRole.admin]!) {
        expect(navKeyAllowedFor(AppRole.admin, key), isTrue, reason: key);
      }
    });

    test('sales cannot reach Finance, Purchasing or People modules', () {
      for (final key in ['coa', 'ledger', 'tb', 'po', 'grn', 'suppay', 'employees', 'payroll']) {
        expect(navKeyAllowedFor(AppRole.sales, key), isFalse, reason: key);
      }
      expect(navKeyAllowedFor(AppRole.sales, 'invoices'), isTrue);
      expect(navKeyAllowedFor(AppRole.sales, 'customers'), isTrue);
    });

    test('store cannot reach Sales or Finance modules', () {
      for (final key in ['invoices', 'quotations', 'receipts', 'coa', 'ledger', 'tb']) {
        expect(navKeyAllowedFor(AppRole.store, key), isFalse, reason: key);
      }
      expect(navKeyAllowedFor(AppRole.store, 'stock'), isTrue);
      expect(navKeyAllowedFor(AppRole.store, 'grn'), isTrue);
    });

    test('auditor is read-scoped to financial + audit modules only', () {
      for (final key in ['invoices', 'po', 'stock', 'employees', 'payroll', 'company']) {
        expect(navKeyAllowedFor(AppRole.auditor, key), isFalse, reason: key);
      }
      expect(navKeyAllowedFor(AppRole.auditor, 'audit'), isTrue);
      expect(navKeyAllowedFor(AppRole.auditor, 'tb'), isTrue);
    });

    test('hr is scoped to People modules only', () {
      for (final key in ['invoices', 'po', 'stock', 'coa']) {
        expect(navKeyAllowedFor(AppRole.hr, key), isFalse, reason: key);
      }
      expect(navKeyAllowedFor(AppRole.hr, 'employees'), isTrue);
      expect(navKeyAllowedFor(AppRole.hr, 'leave'), isTrue);
      expect(navKeyAllowedFor(AppRole.hr, 'attendance'), isTrue);
    });

    test('superAdmin has no entry in the ERP nav access map at all', () {
      expect(roleNavAccess.containsKey(AppRole.superAdmin), isFalse);
      expect(navKeyAllowedFor(AppRole.superAdmin, 'dashboard'), isFalse);
    });

    test('every role\'s first allowed key is dashboard, so router fallback always lands somewhere valid', () {
      for (final role in roleNavAccess.keys) {
        expect(roleNavAccess[role]!.first, 'dashboard', reason: role.name);
      }
    });
  });
}
