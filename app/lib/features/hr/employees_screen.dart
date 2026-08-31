import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/money.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';
import '../../shared/widgets/quick_add_dialog.dart';

final employeesProvider = StreamProvider((ref) => ref.watch(hrRepositoryProvider).watchEmployees());
final leaveUsedByEmployeeProvider = StreamProvider((ref) async* {
  final db = ref.watch(databaseProvider);
  await for (final _ in db.select(db.leaveRequests).watch()) {
    yield await ref.read(hrRepositoryProvider).leaveUsedByEmployee();
  }
});

class EmployeesScreen extends ConsumerWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(employeesProvider);
    final leaveUsedAsync = ref.watch(leaveUsedByEmployeeProvider);

    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load employees: $e'),
      data: (employees) {
        final leaveUsed = leaveUsedAsync.valueOrNull ?? {};
        final rows = employees
            .map(
              (e) => RowSpec([
                Cell.text(e.code, mono: true, weight: FontWeight.w500),
                Cell.text(e.name),
                Cell.text(e.designation, color: AppColors.mutedInk),
                Cell.text(e.department, color: AppColors.mutedInk),
                Cell.text(_fmtDate(e.joinedDate), mono: true, color: AppColors.mutedInk),
                Cell.number(e.ctcPaise.toIndianRupees()),
                Cell.number((leaveUsed[e.id] ?? 0).toStringAsFixed(1)),
                pillCell(e.status == 'active' ? PillTone.paid : PillTone.draft, e.status == 'active' ? 'Active' : 'Inactive'),
              ],
                onTap: () => _openForm(context, ref, existing: e),
                onEdit: () => _openForm(context, ref, existing: e),
                onDelete: () => ref.read(hrRepositoryProvider).deleteEmployee(e.id),
              ),
            )
            .toList();

        final spec = TableSpec(
          title: 'Employees',
          subtitle: 'Roster with designation, department and salary structure · tap a row to edit',
          devNote: 'features/hr · employees · leave_requests',
          filters: const [FilterSpec('Department', 'All'), FilterSpec('Status', 'Active')],
          columns: const [
            ColumnSpec('CODE'),
            ColumnSpec('NAME'),
            ColumnSpec('DESIGNATION'),
            ColumnSpec('DEPARTMENT'),
            ColumnSpec('JOINED'),
            ColumnSpec('CTC / MONTH', align: CellAlign.right),
            ColumnSpec('LEAVE USED (YTD)', align: CellAlign.right),
            ColumnSpec('STATUS'),
          ],
          rows: rows,
          count: '${rows.length} employee(s) · queried live from Drift',
          cta: 'New employee',
          onCta: () => _openForm(context, ref),
        );
        return ListScreen(spec: spec);
      },
    );
  }

  void _openForm(BuildContext context, WidgetRef ref, {Employee? existing}) {
    final isEdit = existing != null;
    final code = QuickField('CODE', initial: existing?.code ?? 'E-0${DateTime.now().millisecondsSinceEpoch % 1000}');
    final name = QuickField('NAME', initial: existing?.name ?? '');
    final designation = QuickField('DESIGNATION', initial: existing?.designation ?? '');
    final department = QuickField('DEPARTMENT', initial: existing?.department ?? '');
    final ctc = QuickField(
      'CTC / MONTH (₹)',
      initial: existing == null ? '0' : existing.ctcPaise.toRupees.toString(),
      keyboardType: TextInputType.number,
    );

    showRecordFormDialog(
      context: context,
      title: isEdit ? 'Edit employee' : 'New employee',
      submitLabel: isEdit ? 'Save' : 'Create',
      fields: [code, name, designation, department, ctc],
      onSubmit: () async {
        if (name.controller.text.trim().isEmpty) throw 'Name is required';
        final repo = ref.read(hrRepositoryProvider);
        if (isEdit) {
          await repo.updateEmployee(
            existing.id,
            code: code.controller.text.trim(),
            name: name.controller.text.trim(),
            designation: designation.controller.text.trim(),
            department: department.controller.text.trim(),
            ctcPaise: rupeesToPaise(num.tryParse(ctc.controller.text.trim()) ?? 0),
          );
        } else {
          await repo.createEmployee(
            code: code.controller.text.trim(),
            name: name.controller.text.trim(),
            designation: designation.controller.text.trim(),
            department: department.controller.text.trim(),
            joinedDate: DateTime.now(),
            ctcPaise: rupeesToPaise(num.tryParse(ctc.controller.text.trim()) ?? 0),
          );
        }
      },
      onDelete: isEdit ? () => ref.read(hrRepositoryProvider).deleteEmployee(existing.id) : null,
      deleteConfirmMessage: 'This removes ${existing?.name ?? 'the employee'} from the roster.',
    );
  }
}

String _fmtDate(DateTime d) {
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${d.day.toString().padLeft(2, '0')} ${months[d.month - 1]} ${d.year}';
}
