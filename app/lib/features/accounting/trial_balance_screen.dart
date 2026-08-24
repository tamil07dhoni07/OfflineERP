import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/money.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';

class TrialBalanceScreen extends ConsumerWidget {
  const TrialBalanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(trialBalanceProvider);
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load trial balance: $e'),
      data: (balances) {
        final sorted = [...balances]..sort((a, b) => a.account.code.compareTo(b.account.code));
        var totalDebit = 0;
        var totalCredit = 0;
        final rows = <RowSpec>[];
        for (final b in sorted) {
          final debit = b.account.nature == 'debit' ? (b.netPaise > 0 ? b.netPaise : 0) : 0;
          final credit = b.account.nature == 'credit' ? (b.netPaise > 0 ? b.netPaise : 0) : 0;
          if (debit == 0 && credit == 0) continue;
          totalDebit += debit;
          totalCredit += credit;
          rows.add(
            RowSpec([
              Cell.text(b.account.code, mono: true),
              Cell.text(b.account.name),
              Cell.text(b.account.groupName, color: AppColors.mutedInk),
              Cell.number(debit == 0 ? '—' : debit.toIndianRupees(), color: debit == 0 ? AppColors.mutedInk : AppColors.ink),
              Cell.number(credit == 0 ? '—' : credit.toIndianRupees(), color: credit == 0 ? AppColors.mutedInk : AppColors.ink),
            ]),
          );
        }
        rows.add(
          RowSpec([
            Cell.text(''),
            Cell.text('TOTAL', weight: FontWeight.w600),
            Cell.text(''),
            Cell.number(totalDebit.toIndianRupees(), weight: FontWeight.w600),
            Cell.number(totalCredit.toIndianRupees(), weight: FontWeight.w600),
          ]),
        );

        final balanced = totalDebit == totalCredit;
        final spec = TableSpec(
          title: 'Trial Balance',
          subtitle: 'As at today · debits and credits ${balanced ? 'agree' : 'DO NOT AGREE'}',
          devNote: 'features/accounting · aggregate over journal_lines',
          filters: const [FilterSpec('Company', 'Nexus Traders'), FilterSpec('Level', 'Ledger')],
          columns: const [
            ColumnSpec('CODE'),
            ColumnSpec('ACCOUNT'),
            ColumnSpec('GROUP'),
            ColumnSpec('DEBIT', align: CellAlign.right),
            ColumnSpec('CREDIT', align: CellAlign.right),
          ],
          rows: rows,
          count: 'Difference ${(totalDebit - totalCredit).toIndianRupees()} · assertion enforced before any journal commits',
        );
        return ListScreen(spec: spec);
      },
    );
  }
}
