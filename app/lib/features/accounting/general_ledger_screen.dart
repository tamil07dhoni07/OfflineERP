import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/database/repositories/accounting_repository.dart';
import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../core/utils/money.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';

final selectedLedgerAccountProvider = StateProvider<String?>((ref) => null);

final ledgerRowsProvider = StreamProvider<List<LedgerRow>>((ref) async* {
  final accountId = ref.watch(selectedLedgerAccountProvider);
  final db = ref.watch(databaseProvider);
  if (accountId == null) {
    yield const <LedgerRow>[];
    return;
  }
  await for (final _ in db.select(db.journalLines).watch()) {
    yield await ref.read(accountingRepositoryProvider).ledgerFor(accountId);
  }
});

class GeneralLedgerScreen extends ConsumerWidget {
  const GeneralLedgerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(trialBalanceProvider);
    return accountsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load accounts: $e'),
      data: (balances) {
        final accounts = [...balances.map((b) => b.account)]..sort((a, b) => a.code.compareTo(b.code));
        final selected = ref.watch(selectedLedgerAccountProvider) ?? accounts.firstWhere((a) => a.code == '1200', orElse: () => accounts.first).id;
        final account = accounts.firstWhere((a) => a.id == selected);
        final ledgerAsync = ref.watch(ledgerRowsProvider);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                for (final a in accounts)
                  GestureDetector(
                    onTap: () => ref.read(selectedLedgerAccountProvider.notifier).state = a.id,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: a.id == selected ? AppColors.accent : AppColors.card,
                        border: Border.all(color: a.id == selected ? AppColors.accent : AppColors.controlBorder),
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '${a.code} · ${a.name}',
                        style: AppText.sans(size: 11.5, color: a.id == selected ? AppColors.white : AppColors.ink),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            ledgerAsync.when(
              loading: () => const Padding(padding: EdgeInsets.only(top: 40), child: Center(child: CircularProgressIndicator())),
              error: (e, st) => Text('$e'),
              data: (rows) {
                final rowSpecs = rows
                    .map(
                      (r) => RowSpec([
                        Cell.text(DateFormat('d MMM').format(r.date), mono: true, color: AppColors.mutedInk),
                        Cell.text(r.voucherNo, mono: true),
                        Cell.text(r.particulars),
                        Cell.number(r.debitPaise == 0 ? '—' : r.debitPaise.toIndianRupees()),
                        Cell.number(r.creditPaise == 0 ? '—' : r.creditPaise.toIndianRupees()),
                        Cell.number(r.runningBalancePaise.toIndianRupees(), weight: FontWeight.w600),
                      ]),
                    )
                    .toList();

                final closing = rows.isEmpty ? 0 : rows.last.runningBalancePaise;
                final spec = TableSpec(
                  title: 'General Ledger',
                  subtitle: '${account.code} · ${account.name}',
                  devNote: 'features/accounting · journal_lines · running balance',
                  filters: const [FilterSpec('Period', 'All time'), FilterSpec('Branch', 'Mumbai HQ')],
                  columns: const [
                    ColumnSpec('DATE'),
                    ColumnSpec('VOUCHER'),
                    ColumnSpec('PARTICULARS'),
                    ColumnSpec('DEBIT', align: CellAlign.right),
                    ColumnSpec('CREDIT', align: CellAlign.right),
                    ColumnSpec('BALANCE', align: CellAlign.right),
                  ],
                  rows: rowSpecs,
                  count: '${rowSpecs.length} entries · closing ${closing.toIndianRupees()}',
                );
                return ListScreen(spec: spec);
              },
            ),
          ],
        );
      },
    );
  }
}
