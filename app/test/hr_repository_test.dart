import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexus_erp/core/database/app_database.dart';
import 'package:nexus_erp/core/database/repositories/accounting_repository.dart';
import 'package:nexus_erp/core/database/repositories/audit_repository.dart';
import 'package:nexus_erp/core/database/repositories/hr_repository.dart';

Future<AppDatabase> _openTestDb() async {
  final db = AppDatabase.forTesting(NativeDatabase.memory());
  const accounts = [
    ('1010', 'Bank', 'Current Assets', 'asset', 'debit'),
    ('6100', 'Salaries & Wages', 'Operating Expenses', 'expense', 'debit'),
  ];
  for (final a in accounts) {
    await db
        .into(db.accounts)
        .insert(AccountsCompanion.insert(code: a.$1, name: a.$2, groupName: a.$3, type: a.$4, nature: a.$5));
  }
  return db;
}

void main() {
  group('HrRepository', () {
    late AppDatabase db;
    late HrRepository hr;

    setUp(() async {
      db = await _openTestDb();
      hr = HrRepository(db, AccountingRepository(db), AuditRepository(db));
    });

    tearDown(() => db.close());

    test('editing and soft-deleting an employee', () async {
      final employee = await hr.createEmployee(
        code: 'E-001',
        name: 'Test Employee',
        designation: 'Clerk',
        department: 'Finance',
        joinedDate: DateTime(2024, 1, 1),
        ctcPaise: 5000000,
      );

      await hr.updateEmployee(employee.id, code: 'E-001', name: 'Renamed Employee', designation: 'Senior Clerk', department: 'Finance', ctcPaise: 6000000);
      final updated = await (db.select(db.employees)..where((t) => t.id.equals(employee.id))).getSingle();
      expect(updated.name, 'Renamed Employee');
      expect(updated.ctcPaise, 6000000);

      await hr.deleteEmployee(employee.id);
      final visible = await hr.activeEmployees();
      expect(visible, isEmpty);
      final raw = await (db.select(db.employees)..where((t) => t.id.equals(employee.id))).getSingle();
      expect(raw.deletedAt, isNotNull, reason: 'delete must be soft, not physical');
    });

    test('leave request lifecycle: apply, approve, and leaveUsedByEmployee only counts approved', () async {
      final employee = await hr.createEmployee(
        code: 'E-002',
        name: 'Leave Taker',
        designation: 'Executive',
        department: 'Sales',
        joinedDate: DateTime(2024, 1, 1),
        ctcPaise: 4000000,
      );

      final leaveId = await hr.applyForLeave(
        employee: employee,
        leaveType: 'casual',
        fromDate: DateTime(2026, 8, 10),
        toDate: DateTime(2026, 8, 12),
        reason: 'Family function',
        actor: 'test-user',
        device: 'TEST-DEVICE',
      );

      var usedBeforeApproval = await hr.leaveUsedByEmployee();
      expect(usedBeforeApproval[employee.id] ?? 0, 0, reason: 'pending leave should not count as used yet');

      await hr.decideLeave(leaveId, approve: true, decidedBy: 'manager', device: 'TEST-DEVICE');

      final usedAfterApproval = await hr.leaveUsedByEmployee();
      expect(usedAfterApproval[employee.id], 3);

      final logs = await db.select(db.auditLogs).get();
      expect(logs.where((l) => l.action == 'leave.approved'), hasLength(1));
    });

    test('marking attendance twice for the same day updates rather than duplicates', () async {
      final employee = await hr.createEmployee(
        code: 'E-003',
        name: 'Punctual Person',
        designation: 'Executive',
        department: 'Ops',
        joinedDate: DateTime(2024, 1, 1),
        ctcPaise: 3000000,
      );
      final day = DateTime(2026, 8, 20);

      await hr.markAttendance(employee: employee, date: day, status: 'present', actor: 'test-user', device: 'TEST-DEVICE');
      await hr.markAttendance(employee: employee, date: day, status: 'half_day', note: 'Left early', actor: 'test-user', device: 'TEST-DEVICE');

      final records = await db.select(db.attendanceRecords).get();
      expect(records, hasLength(1));
      expect(records.single.status, 'half_day');
      expect(records.single.note, 'Left early');
    });

    test('generating and posting payroll writes a balanced Dr Salaries / Cr Bank journal', () async {
      await hr.createEmployee(code: 'E-004', name: 'A', designation: 'X', department: 'Y', joinedDate: DateTime(2024, 1, 1), ctcPaise: 5000000);
      await hr.createEmployee(code: 'E-005', name: 'B', designation: 'X', department: 'Y', joinedDate: DateTime(2024, 1, 1), ctcPaise: 3000000);

      final runId = await hr.generatePayrollRun(periodDate: DateTime(2026, 8, 1), actor: 'test-user', device: 'TEST-DEVICE');
      final run = (await db.select(db.payrollRuns).get()).single;
      expect(run.headcount, 2);
      expect(run.grossPaise, 8000000);
      expect(run.status, 'draft');
      expect(run.netPayablePaise, 8000000 - run.pfPaise - run.esiPaise - run.tdsPaise);

      await hr.postPayrollRun(runId, actor: 'test-user', device: 'TEST-DEVICE');

      final updatedRun = (await db.select(db.payrollRuns).get()).single;
      expect(updatedRun.status, 'posted');

      final lines = await db.select(db.journalLines).get();
      final totalDebit = lines.fold<int>(0, (a, l) => a + l.debitPaise);
      final totalCredit = lines.fold<int>(0, (a, l) => a + l.creditPaise);
      expect(totalDebit, totalCredit);
      expect(totalDebit, run.netPayablePaise);

      expect(() => hr.postPayrollRun(runId, actor: 'test-user', device: 'TEST-DEVICE'), throwsStateError);
    });

    test('cannot generate two payroll runs for the same period', () async {
      await hr.createEmployee(code: 'E-006', name: 'A', designation: 'X', department: 'Y', joinedDate: DateTime(2024, 1, 1), ctcPaise: 1000000);
      await hr.generatePayrollRun(periodDate: DateTime(2026, 8, 15), actor: 'test-user', device: 'TEST-DEVICE');
      expect(() => hr.generatePayrollRun(periodDate: DateTime(2026, 8, 20), actor: 'test-user', device: 'TEST-DEVICE'), throwsStateError);
    });
  });
}
