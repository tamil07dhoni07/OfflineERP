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

final leaveRequestsProvider = StreamProvider((ref) => ref.watch(hrRepositoryProvider).watchLeaveRequests());

const _leaveTypes = ['casual', 'sick', 'earned', 'unpaid'];
const _leaveTypeLabel = {'casual': 'Casual', 'sick': 'Sick', 'earned': 'Earned', 'unpaid': 'Unpaid'};
const _leaveStatusTone = {'pending': PillTone.warn, 'approved': PillTone.paid, 'rejected': PillTone.late};

class LeaveScreen extends ConsumerWidget {
  const LeaveScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(leaveRequestsProvider);
    final employeesAsync = ref.watch(employeesProvider);

    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load leave requests: $e'),
      data: (requests) {
        final employeesById = {for (final e in employeesAsync.valueOrNull ?? <Employee>[]) e.id: e};
        final rows = requests
            .map(
              (r) => RowSpec([
                Cell.text(employeesById[r.employeeId]?.name ?? r.employeeId),
                Cell.text(_leaveTypeLabel[r.leaveType] ?? r.leaveType),
                Cell.text('${_fmtDate(r.fromDate)} – ${_fmtDate(r.toDate)}', mono: true, color: AppColors.mutedInk),
                Cell.number(r.days.toStringAsFixed(1)),
                Cell.text(r.reason, color: AppColors.mutedInk),
                pillCell(_leaveStatusTone[r.status] ?? PillTone.draft, r.status[0].toUpperCase() + r.status.substring(1)),
              ], onTap: r.status == 'pending' ? () => _decide(context, ref, r) : null),
            )
            .toList();

        final spec = TableSpec(
          title: 'Leave',
          subtitle: 'Applications and approvals · tap a pending row to decide',
          devNote: 'features/hr · leave_requests',
          filters: const [FilterSpec('Status', 'All'), FilterSpec('Type', 'Any')],
          columns: const [
            ColumnSpec('EMPLOYEE'),
            ColumnSpec('TYPE'),
            ColumnSpec('DATES'),
            ColumnSpec('DAYS', align: CellAlign.right),
            ColumnSpec('REASON'),
            ColumnSpec('STATUS'),
          ],
          rows: rows,
          count: '${rows.length} request(s) · queried live from Drift',
          cta: 'Apply for leave',
          onCta: () => showDialog(context: context, builder: (_) => const _ApplyLeaveDialog()),
        );
        return ListScreen(spec: spec);
      },
    );
  }

  void _decide(BuildContext context, WidgetRef ref, LeaveRequest request) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.card,
        title: const Text('Decide leave request'),
        content: Text('${request.days.toStringAsFixed(1)} day(s) · ${request.reason}'),
        actions: [
          TextButton(
            onPressed: () async {
              await ref
                  .read(hrRepositoryProvider)
                  .decideLeave(request.id, approve: false, decidedBy: ref.read(authControllerProvider)?.username ?? 'unknown', device: currentDeviceId);
              if (context.mounted) Navigator.of(context).pop();
            },
            child: const Text('Reject', style: TextStyle(color: AppColors.danger)),
          ),
          TextButton(
            onPressed: () async {
              await ref
                  .read(hrRepositoryProvider)
                  .decideLeave(request.id, approve: true, decidedBy: ref.read(authControllerProvider)?.username ?? 'unknown', device: currentDeviceId);
              if (context.mounted) Navigator.of(context).pop();
            },
            child: const Text('Approve', style: TextStyle(color: AppColors.successText)),
          ),
        ],
      ),
    );
  }
}

String _fmtDate(DateTime d) {
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${d.day.toString().padLeft(2, '0')} ${months[d.month - 1]}';
}

class _ApplyLeaveDialog extends ConsumerStatefulWidget {
  const _ApplyLeaveDialog();

  @override
  ConsumerState<_ApplyLeaveDialog> createState() => _ApplyLeaveDialogState();
}

class _ApplyLeaveDialogState extends ConsumerState<_ApplyLeaveDialog> {
  Employee? _employee;
  String _type = 'casual';
  DateTime _from = DateTime.now();
  DateTime _to = DateTime.now();
  final _reasonCtrl = TextEditingController();
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
              Text('Apply for leave', style: AppText.sans(size: 16, weight: FontWeight.w600)),
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
              Text('TYPE', style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                children: [
                  for (final t in _leaveTypes)
                    GestureDetector(
                      onTap: () => setState(() => _type = t),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          color: _type == t ? AppColors.accent : AppColors.fieldFill,
                          border: Border.all(color: _type == t ? AppColors.accent : AppColors.controlBorder),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(_leaveTypeLabel[t]!, style: AppText.sans(size: 12, weight: FontWeight.w600, color: _type == t ? AppColors.white : AppColors.ink)),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _dateField('FROM', _from, (d) => setState(() => _from = d))),
                  const SizedBox(width: 10),
                  Expanded(child: _dateField('TO', _to, (d) => setState(() => _to = d))),
                ],
              ),
              const SizedBox(height: 12),
              Text('REASON', style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
              const SizedBox(height: 5),
              Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 11),
                decoration: BoxDecoration(color: AppColors.fieldFill, border: Border.all(color: AppColors.fieldBorder), borderRadius: BorderRadius.circular(7)),
                child: TextField(
                  controller: _reasonCtrl,
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
                  PrimaryButton(label: _submitting ? 'Submitting…' : 'Apply', onTap: _submitting ? null : _submit),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateField(String label, DateTime value, void Function(DateTime) onPicked) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () async {
            final picked = await showDatePicker(context: context, initialDate: value, firstDate: DateTime(2020), lastDate: DateTime(2100));
            if (picked != null) onPicked(picked);
          },
          child: Container(
            height: 38,
            padding: const EdgeInsets.symmetric(horizontal: 11),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(color: AppColors.fieldFill, border: Border.all(color: AppColors.fieldBorder), borderRadius: BorderRadius.circular(7)),
            child: Text(_fmtDate(value), style: AppText.sans(size: 13)),
          ),
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (_employee == null || _reasonCtrl.text.trim().isEmpty) {
      setState(() => _error = 'Pick an employee and enter a reason.');
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref
          .read(hrRepositoryProvider)
          .applyForLeave(
            employee: _employee!,
            leaveType: _type,
            fromDate: _from,
            toDate: _to,
            reason: _reasonCtrl.text.trim(),
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
