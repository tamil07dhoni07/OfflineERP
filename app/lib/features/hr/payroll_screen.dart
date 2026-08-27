import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../core/utils/money.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';
import '../auth/auth_controller.dart';

final payrollRunsProvider = StreamProvider((ref) => ref.watch(hrRepositoryProvider).watchPayrollRuns());

const _payrollStatusTone = {'draft': PillTone.draft, 'posted': PillTone.posted, 'paid': PillTone.paid};
const _payrollStatusLabel = {'draft': 'Draft', 'posted': 'Posted', 'paid': 'Paid'};

class PayrollScreen extends ConsumerWidget {
  const PayrollScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(payrollRunsProvider);

    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load payroll runs: $e'),
      data: (runs) {
        final rows = runs
            .map(
              (r) => RowSpec([
                Cell.text(r.period, weight: FontWeight.w500),
                Cell.number('${r.headcount}'),
                Cell.number(r.grossPaise.toIndianRupees()),
                Cell.number(r.pfPaise.toIndianRupees()),
                Cell.number(r.esiPaise.toIndianRupees()),
                Cell.number(r.tdsPaise.toIndianRupees()),
                Cell.number(r.netPayablePaise.toIndianRupees(), weight: FontWeight.w600),
                pillCell(_payrollStatusTone[r.status] ?? PillTone.draft, _payrollStatusLabel[r.status] ?? r.status),
              ], onTap: r.status == 'draft' ? () => _confirmPost(context, ref, r) : null),
            )
            .toList();

        final spec = TableSpec(
          title: 'Payroll Runs',
          subtitle: 'Monthly cycles, statutory deductions and posting state · tap a draft to post it',
          devNote: 'features/hr · payroll_runs · posts to journal on posting',
          filters: const [FilterSpec('Status', 'All')],
          columns: const [
            ColumnSpec('PERIOD'),
            ColumnSpec('HEADCOUNT', align: CellAlign.right),
            ColumnSpec('GROSS', align: CellAlign.right),
            ColumnSpec('PF', align: CellAlign.right),
            ColumnSpec('ESI', align: CellAlign.right),
            ColumnSpec('TDS', align: CellAlign.right),
            ColumnSpec('NET PAYABLE', align: CellAlign.right),
            ColumnSpec('STATUS'),
          ],
          rows: rows,
          count: '${rows.length} run(s) · queried live from Drift',
          cta: 'New payroll run',
          onCta: () => _generate(context, ref),
          note: 'PF/ESI/TDS use flat placeholder rates (12% / 0.75% / 8% of gross) — this is not a compliant statutory payroll engine.',
        );
        return ListScreen(spec: spec);
      },
    );
  }

  Future<void> _generate(BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .read(hrRepositoryProvider)
          .generatePayrollRun(periodDate: DateTime.now(), actor: ref.read(authControllerProvider)?.username ?? 'unknown', device: currentDeviceId);
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
      }
    }
  }

  void _confirmPost(BuildContext context, WidgetRef ref, PayrollRun run) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.card,
        title: Text('Post payroll for ${run.period}?'),
        content: Text(
          'Posts a journal entry for ${run.netPayablePaise.toIndianRupees(withSymbol: true)} '
          '(Dr Salaries & Wages / Cr Bank) for ${run.headcount} employee(s).',
        ),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              await ref
                  .read(hrRepositoryProvider)
                  .postPayrollRun(run.id, actor: ref.read(authControllerProvider)?.username ?? 'unknown', device: currentDeviceId);
              if (context.mounted) Navigator.of(context).pop();
            },
            child: Text('Post', style: AppText.sans(size: 14, weight: FontWeight.w600, color: AppColors.accent)),
          ),
        ],
      ),
    );
  }
}
