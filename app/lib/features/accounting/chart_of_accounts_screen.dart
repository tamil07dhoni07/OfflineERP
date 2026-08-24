import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/money.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';

class ChartOfAccountsScreen extends ConsumerWidget {
  const ChartOfAccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(trialBalanceProvider);
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load accounts: $e'),
      data: (balances) {
        final sorted = [...balances]..sort((a, b) => a.account.code.compareTo(b.account.code));
        final rows = sorted
            .map(
              (b) => RowSpec([
                Cell.text(b.account.code, mono: true, weight: FontWeight.w500),
                Cell.text(b.account.name),
                Cell.text(b.account.groupName, color: AppColors.mutedInk),
                Cell.text(_titleCase(b.account.type), color: AppColors.mutedInk),
                Cell.text(_titleCase(b.account.nature), color: AppColors.mutedInk),
                Cell.number(b.netPaise.toIndianRupees()),
              ]),
            )
            .toList();

        final spec = TableSpec(
          title: 'Chart of Accounts',
          subtitle: 'Account tree with group, type and live balance',
          devNote: 'features/accounting · accounts · journal_lines aggregate',
          filters: const [FilterSpec('Type', 'All'), FilterSpec('Group', 'All'), FilterSpec('Zero balance', 'Show')],
          columns: const [
            ColumnSpec('CODE'),
            ColumnSpec('ACCOUNT'),
            ColumnSpec('GROUP'),
            ColumnSpec('TYPE'),
            ColumnSpec('NATURE'),
            ColumnSpec('BALANCE', align: CellAlign.right),
          ],
          rows: rows,
          count: '${rows.length} accounts · balance = live sum of journal_lines',
        );
        return ListScreen(spec: spec);
      },
    );
  }
}

String _titleCase(String s) => s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';
