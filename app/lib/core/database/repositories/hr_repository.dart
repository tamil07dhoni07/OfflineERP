import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../app_database.dart';
import 'accounting_repository.dart';
import 'audit_repository.dart';

const _uuid = Uuid();

/// Flat placeholder statutory rates — see the doc comment on [PayrollRuns]
/// in tables.dart. Real Indian payroll compliance (slabs, exemptions,
/// per-employee PF ceilings) is out of scope here.
const pfRate = 0.12;
const esiRate = 0.0075;
const tdsRate = 0.08;

class HrRepository {
  HrRepository(this._db, this._accounting, this._audit);
  final AppDatabase _db;
  final AccountingRepository _accounting;
  final AuditRepository _audit;

  // ---- Employees ----------------------------------------------------------

  Stream<List<Employee>> watchEmployees() =>
      (_db.select(_db.employees)..where((t) => t.deletedAt.isNull())..orderBy([(t) => OrderingTerm.asc(t.code)]))
          .watch();

  Future<List<Employee>> activeEmployees() =>
      (_db.select(_db.employees)..where((t) => t.deletedAt.isNull() & t.status.equals('active'))).get();

  Future<Employee> createEmployee({
    required String code,
    required String name,
    required String designation,
    required String department,
    required DateTime joinedDate,
    required int ctcPaise,
  }) {
    return _db
        .into(_db.employees)
        .insertReturning(
          EmployeesCompanion.insert(
            code: code,
            name: name,
            designation: designation,
            department: department,
            joinedDate: joinedDate,
            ctcPaise: ctcPaise,
          ),
        );
  }

  Future<void> updateEmployee(
    String id, {
    required String code,
    required String name,
    required String designation,
    required String department,
    required int ctcPaise,
  }) {
    return (_db.update(_db.employees)..where((t) => t.id.equals(id))).write(
      EmployeesCompanion(
        code: Value(code),
        name: Value(name),
        designation: Value(designation),
        department: Value(department),
        ctcPaise: Value(ctcPaise),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteEmployee(String id) =>
      (_db.update(_db.employees)..where((t) => t.id.equals(id))).write(EmployeesCompanion(deletedAt: Value(DateTime.now())));

  /// Leave days used this calendar year — approved requests only.
  Future<Map<String, double>> leaveUsedByEmployee() async {
    final rows = await (_db.select(_db.leaveRequests)..where((t) => t.status.equals('approved'))).get();
    final result = <String, double>{};
    for (final r in rows) {
      result[r.employeeId] = (result[r.employeeId] ?? 0) + r.days;
    }
    return result;
  }

  // ---- Leave ----------------------------------------------------------------

  Stream<List<LeaveRequest>> watchLeaveRequests() =>
      (_db.select(_db.leaveRequests)..orderBy([(t) => OrderingTerm.desc(t.fromDate)])).watch();

  Future<String> applyForLeave({
    required Employee employee,
    required String leaveType,
    required DateTime fromDate,
    required DateTime toDate,
    required String reason,
    required String actor,
    required String device,
  }) async {
    if (toDate.isBefore(fromDate)) throw StateError('End date must be on or after the start date.');
    final days = toDate.difference(fromDate).inDays + 1;
    final id = await _db
        .into(_db.leaveRequests)
        .insertReturning(
          LeaveRequestsCompanion.insert(
            employeeId: employee.id,
            leaveType: leaveType,
            fromDate: fromDate,
            toDate: toDate,
            days: days.toDouble(),
            reason: reason,
            status: 'pending',
          ),
        );
    await _audit.log(
      username: actor,
      module: 'People',
      action: 'leave.applied',
      recordRef: '${employee.code} · $days day(s)',
      oldValue: '—',
      newValue: 'pending',
      device: device,
    );
    return id.id;
  }

  Future<void> decideLeave(
    String leaveId, {
    required bool approve,
    required String decidedBy,
    required String device,
  }) async {
    final leave = await (_db.select(_db.leaveRequests)..where((t) => t.id.equals(leaveId))).getSingle();
    await (_db.update(_db.leaveRequests)..where((t) => t.id.equals(leaveId))).write(
      LeaveRequestsCompanion(
        status: Value(approve ? 'approved' : 'rejected'),
        decidedBy: Value(decidedBy),
        updatedAt: Value(DateTime.now()),
      ),
    );
    await _audit.log(
      username: decidedBy,
      module: 'People',
      action: approve ? 'leave.approved' : 'leave.rejected',
      recordRef: leave.employeeId,
      oldValue: 'pending',
      newValue: approve ? 'approved' : 'rejected',
      device: device,
    );
  }

  // ---- Attendance -------------------------------------------------------

  Stream<List<AttendanceRecord>> watchAttendance() =>
      (_db.select(_db.attendanceRecords)..orderBy([(t) => OrderingTerm.desc(t.date)])).watch();

  Future<void> markAttendance({
    required Employee employee,
    required DateTime date,
    required String status,
    String? note,
    required String actor,
    required String device,
  }) async {
    final day = DateTime(date.year, date.month, date.day);
    final existing = await (_db.select(
      _db.attendanceRecords,
    )..where((t) => t.employeeId.equals(employee.id) & t.date.equals(day))).getSingleOrNull();

    if (existing != null) {
      await (_db.update(_db.attendanceRecords)..where((t) => t.id.equals(existing.id))).write(
        AttendanceRecordsCompanion(status: Value(status), note: Value(note), updatedAt: Value(DateTime.now())),
      );
    } else {
      await _db
          .into(_db.attendanceRecords)
          .insert(AttendanceRecordsCompanion.insert(employeeId: employee.id, date: day, status: status, note: Value(note)));
    }
    await _audit.log(
      username: actor,
      module: 'People',
      action: 'attendance.marked',
      recordRef: '${employee.code} · ${day.toIso8601String().split('T').first}',
      oldValue: existing?.status ?? '—',
      newValue: status,
      device: device,
    );
  }

  // ---- Payroll ----------------------------------------------------------

  Stream<List<PayrollRun>> watchPayrollRuns() =>
      (_db.select(_db.payrollRuns)..orderBy([(t) => OrderingTerm.desc(t.periodDate)])).watch();

  /// Sums active employees' CTC into a gross figure and applies the flat
  /// placeholder rates — see the module doc comment for why these aren't
  /// real statutory slabs.
  Future<String> generatePayrollRun({
    required DateTime periodDate,
    required String actor,
    required String device,
  }) async {
    final period = '${periodDate.year}-${periodDate.month.toString().padLeft(2, '0')}';
    final existing = await (_db.select(_db.payrollRuns)..where((t) => t.period.equals(period))).getSingleOrNull();
    if (existing != null) throw StateError('A payroll run for $period already exists.');

    final employees = await activeEmployees();
    final gross = employees.fold<int>(0, (a, e) => a + e.ctcPaise);
    final pf = (gross * pfRate).round();
    final esi = (gross * esiRate).round();
    final tds = (gross * tdsRate).round();
    final net = gross - pf - esi - tds;

    final id = _uuid.v4();
    await _db
        .into(_db.payrollRuns)
        .insert(
          PayrollRunsCompanion.insert(
            id: Value(id),
            period: period,
            periodDate: periodDate,
            headcount: employees.length,
            grossPaise: gross,
            pfPaise: pf,
            esiPaise: esi,
            tdsPaise: tds,
            netPayablePaise: net,
            status: 'draft',
          ),
        );
    await _audit.log(
      username: actor,
      module: 'People',
      action: 'payroll.generated',
      recordRef: period,
      oldValue: '—',
      newValue: 'draft · $employees.length employees',
      device: device,
    );
    return id;
  }

  /// Posts Dr Salaries & Wages / Cr Bank for the net payable — the same
  /// balanced-journal guarantee every other posting flow uses.
  Future<void> postPayrollRun(String runId, {required String actor, required String device}) async {
    final run = await (_db.select(_db.payrollRuns)..where((t) => t.id.equals(runId))).getSingle();
    if (run.status != 'draft') throw StateError('Only a draft payroll run can be posted.');

    await _db.transaction(() async {
      final salariesAccount = await _accountIdByCode('6100');
      final bankAccount = await _accountIdByCode('1010');
      await _accounting.postJournal(
        voucherNo: 'JV/PAYROLL-${run.period}',
        date: run.periodDate,
        narration: 'Payroll — ${run.period}',
        sourceType: 'payroll',
        sourceId: run.id,
        lines: [
          (accountId: salariesAccount, debitPaise: run.netPayablePaise, creditPaise: 0, particulars: '${run.headcount} employee(s) net payable'),
          (accountId: bankAccount, debitPaise: 0, creditPaise: run.netPayablePaise, particulars: 'bank'),
        ],
      );
      await (_db.update(_db.payrollRuns)..where((t) => t.id.equals(runId))).write(
        PayrollRunsCompanion(status: const Value('posted'), updatedAt: Value(DateTime.now())),
      );
      await _audit.log(
        username: actor,
        module: 'People',
        action: 'payroll.posted',
        recordRef: run.period,
        oldValue: 'draft',
        newValue: 'posted',
        device: device,
      );
    });
  }

  Future<String> _accountIdByCode(String code) async {
    final account = await (_db.select(_db.accounts)..where((t) => t.code.equals(code))).getSingle();
    return account.id;
  }
}
