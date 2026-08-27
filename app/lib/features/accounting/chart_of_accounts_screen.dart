import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../core/utils/money.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/buttons.dart';
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
          cta: 'New account',
          onCta: () => showDialog(context: context, builder: (_) => const _NewAccountDialog()),
          note: 'Accounts can be created here but not edited or deleted once they exist — renaming or removing an account with '
              'transaction history would corrupt every report built from it. Fix a mistake with a new account instead.',
        );
        return ListScreen(spec: spec);
      },
    );
  }
}

String _titleCase(String s) => s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';

const _accountTypes = ['asset', 'liability', 'equity', 'income', 'expense'];

class _NewAccountDialog extends ConsumerStatefulWidget {
  const _NewAccountDialog();

  @override
  ConsumerState<_NewAccountDialog> createState() => _NewAccountDialogState();
}

class _NewAccountDialogState extends ConsumerState<_NewAccountDialog> {
  final _code = TextEditingController();
  final _name = TextEditingController();
  final _group = TextEditingController();
  String _type = 'asset';
  bool _submitting = false;
  String? _error;

  String get _nature => (_type == 'asset' || _type == 'expense') ? 'debit' : 'credit';

  @override
  Widget build(BuildContext context) {
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
              Text('New account', style: AppText.sans(size: 16, weight: FontWeight.w600)),
              const SizedBox(height: 16),
              _field('CODE', _code),
              const SizedBox(height: 12),
              _field('NAME', _name),
              const SizedBox(height: 12),
              _field('GROUP', _group, hint: 'e.g. Current Assets'),
              const SizedBox(height: 12),
              Text('TYPE', style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final t in _accountTypes)
                    GestureDetector(
                      onTap: () => setState(() => _type = t),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                        decoration: BoxDecoration(
                          color: _type == t ? AppColors.accent : AppColors.fieldFill,
                          border: Border.all(color: _type == t ? AppColors.accent : AppColors.controlBorder),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(_titleCase(t), style: AppText.sans(size: 12, weight: FontWeight.w600, color: _type == t ? AppColors.white : AppColors.ink)),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Text('Nature: ${_titleCase(_nature)} (set automatically by type)', style: AppText.sans(size: 11, color: AppColors.mutedFaint)),
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
                  PrimaryButton(label: _submitting ? 'Creating…' : 'Create', onTap: _submitting ? null : _submit),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_code.text.trim().isEmpty || _name.text.trim().isEmpty || _group.text.trim().isEmpty) {
      setState(() => _error = 'Code, name and group are required.');
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref
          .read(accountingRepositoryProvider)
          .createAccount(code: _code.text.trim(), name: _name.text.trim(), groupName: _group.text.trim(), type: _type, nature: _nature);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _error = '$e';
        _submitting = false;
      });
    }
  }

  Widget _field(String label, TextEditingController controller, {String? hint}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
        const SizedBox(height: 5),
        Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 11),
          decoration: BoxDecoration(color: AppColors.fieldFill, border: Border.all(color: AppColors.fieldBorder), borderRadius: BorderRadius.circular(7)),
          child: TextField(
            controller: controller,
            style: AppText.sans(size: 13),
            decoration: InputDecoration(border: InputBorder.none, isDense: true, filled: false, hintText: hint, hintStyle: AppText.sans(size: 13, color: AppColors.mutedFaint)),
          ),
        ),
      ],
    );
  }
}
