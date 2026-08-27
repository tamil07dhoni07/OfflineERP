import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/widgets/list_screen.dart';
import '../auth/auth_controller.dart';
import 'employees_screen.dart';

final attendanceProvider = StreamProvider((ref) => ref.watch(hrRepositoryProvider).watchAttendance());

const _statusTone = {
  'present': PillTone.paid,
  'absent': PillTone.late,
  'half_day': PillTone.warn,
  'leave': PillTone.draft,
  'holiday': PillTone.posted,
};
const _statusLabel = {'present': 'Present', 'absent': 'Absent', 'half_day': 'Half day', 'leave': 'Leave', 'holiday': 'Holiday'};

class AttendanceScreen extends ConsumerWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(attendanceProvider);
    final employeesAsync = ref.watch(employeesProvider);

    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load attendance: $e'),
      data: (records) {
        final employeesById = {for (final e in employeesAsync.valueOrNull ?? <Employee>[]) e.id: e};
        final rows = records
            .map(
              (r) => RowSpec([
                Cell.text(_fmtDate(r.date), mono: true, color: AppColors.mutedInk),
                Cell.text(employeesById[r.employeeId]?.name ?? r.employeeId),
                pillCell(_statusTone[r.status] ?? PillTone.draft, _statusLabel[r.status] ?? r.status),
                Cell.text(r.note ?? '—', color: AppColors.mutedInk),
              ]),
            )
            .toList();

        final spec = TableSpec(
          title: 'Attendance',
          subtitle: 'Daily attendance register, one entry per employee per day',
          devNote: 'features/hr · attendance_records',
          filters: const [FilterSpec('Period', 'All time'), FilterSpec('Status', 'All')],
          columns: const [ColumnSpec('DATE'), ColumnSpec('EMPLOYEE'), ColumnSpec('STATUS'), ColumnSpec('NOTE')],
          rows: rows,
          count: '${rows.length} record(s) · queried live from Drift',
          cta: 'Mark attendance',
          onCta: () => showDialog(context: context, builder: (_) => const _MarkAttendanceDialog()),
        );
        return ListScreen(spec: spec);
      },
    );
  }
}

String _fmtDate(DateTime d) {
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${d.day.toString().padLeft(2, '0')} ${months[d.month - 1]} ${d.year}';
}

class _MarkAttendanceDialog extends ConsumerStatefulWidget {
  const _MarkAttendanceDialog();

  @override
  ConsumerState<_MarkAttendanceDialog> createState() => _MarkAttendanceDialogState();
}

class _MarkAttendanceDialogState extends ConsumerState<_MarkAttendanceDialog> {
  Employee? _employee;
  DateTime _date = DateTime.now();
  String _status = 'present';
  final _noteCtrl = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final employeesAsync = ref.watch(employeesProvider);

    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mark attendance', style: AppText.sans(size: 16, weight: FontWeight.w600)),
              const SizedBox(height: 16),
              Text('EMPLOYEE', style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
              const SizedBox(height: 5),
              employeesAsync.when(
                loading: () => const LinearProgressIndicator(),
                error: (e, st) => Text('$e'),
                data: (employees) => Container(
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  decoration: BoxDecoration(color: AppColors.fieldFill, border: Border.all(color: AppColors.fieldBorder), borderRadius: BorderRadius.circular(7)),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Employee>(
                      isExpanded: true,
                      value: _employee,
                      hint: Text('Select employee', style: AppText.sans(size: 13, color: AppColors.mutedFaint)),
                      items: [for (final e in employees) DropdownMenuItem(value: e, child: Text('${e.code} · ${e.name}', style: AppText.sans(size: 13)))],
                      onChanged: (e) => setState(() => _employee = e),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text('DATE', style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () async {
                  final picked = await showDatePicker(context: context, initialDate: _date, firstDate: DateTime(2020), lastDate: DateTime(2100));
                  if (picked != null) setState(() => _date = picked);
                },
                child: Container(
                  height: 38,
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(color: AppColors.fieldFill, border: Border.all(color: AppColors.fieldBorder), borderRadius: BorderRadius.circular(7)),
                  child: Text(_fmtDate(_date), style: AppText.sans(size: 13)),
                ),
              ),
              const SizedBox(height: 12),
              Text('STATUS', style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final s in _statusLabel.keys)
                    GestureDetector(
                      onTap: () => setState(() => _status = s),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          color: _status == s ? AppColors.accent : AppColors.fieldFill,
                          border: Border.all(color: _status == s ? AppColors.accent : AppColors.controlBorder),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(_statusLabel[s]!, style: AppText.sans(size: 12, weight: FontWeight.w600, color: _status == s ? AppColors.white : AppColors.ink)),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Text('NOTE (OPTIONAL)', style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
              const SizedBox(height: 5),
              Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 11),
                decoration: BoxDecoration(color: AppColors.fieldFill, border: Border.all(color: AppColors.fieldBorder), borderRadius: BorderRadius.circular(7)),
                child: TextField(
                  controller: _noteCtrl,
                  style: AppText.sans(size: 13),
                  decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: false),
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: 10),
                Text(_error!, style: AppText.sans(size: 12, color: AppColors.danger)),
              ],
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SecondaryButton(label: 'Cancel', onTap: _submitting ? null : () => Navigator.of(context).pop()),
                  const SizedBox(width: 8),
                  PrimaryButton(label: _submitting ? 'Saving…' : 'Save', onTap: _submitting ? null : _submit),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_employee == null) {
      setState(() => _error = 'Pick an employee.');
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref
          .read(hrRepositoryProvider)
          .markAttendance(
            employee: _employee!,
            date: _date,
            status: _status,
            note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
            actor: ref.read(authControllerProvider)?.username ?? 'unknown',
            device: currentDeviceId,
          );
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _error = '$e';
        _submitting = false;
      });
    }
  }
}
