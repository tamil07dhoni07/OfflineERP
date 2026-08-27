import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/money.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';
import '../../shared/widgets/quick_add_dialog.dart';

final customersProvider = StreamProvider((ref) => ref.watch(masterDataRepositoryProvider).watchCustomers());

class CustomersScreen extends ConsumerWidget {
  const CustomersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customersAsync = ref.watch(customersProvider);
    final outstandingAsync = ref.watch(outstandingByCustomerProvider);

    return customersAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load customers: $e'),
      data: (customers) {
        final outstanding = outstandingAsync.valueOrNull ?? {};
        final rows = customers.map((c) {
          final out = outstanding[c.id] ?? 0;
          final pct = c.creditLimitPaise == 0 ? 0.0 : out / c.creditLimitPaise;
          final (tone, label) = pct >= 1
              ? (PillTone.late, 'Over limit')
              : pct >= 0.85
              ? (PillTone.warn, '${(pct * 100).round()}% of limit')
              : (PillTone.paid, 'Good');
          return RowSpec([
            Cell.text(c.code, mono: true, weight: FontWeight.w500),
            Cell.text(c.name),
            Cell.text(c.groupName, color: AppColors.mutedInk),
            Cell.text(c.gstin ?? '—', mono: true, color: AppColors.mutedInk),
            Cell.text(c.state, color: AppColors.mutedInk),
            Cell.number(c.creditLimitPaise.toIndianRupees()),
            Cell.number(out.toIndianRupees()),
            pillCell(tone, label),
          ], onTap: () => _openForm(context, ref, existing: c));
        }).toList();

        final spec = TableSpec(
          title: 'Customers',
          subtitle: 'Accounts, credit exposure and GST registration · tap a row to edit',
          devNote: 'features/customers · customers · customer_balances view',
          filters: const [
            FilterSpec('Group', 'All'),
            FilterSpec('State', 'All'),
            FilterSpec('Over limit', 'No'),
          ],
          columns: const [
            ColumnSpec('CODE'),
            ColumnSpec('NAME'),
            ColumnSpec('GROUP'),
            ColumnSpec('GSTIN'),
            ColumnSpec('STATE'),
            ColumnSpec('CREDIT LIMIT', align: CellAlign.right),
            ColumnSpec('OUTSTANDING', align: CellAlign.right),
            ColumnSpec('STATUS'),
          ],
          rows: rows,
          count: '${rows.length} customers · queried live from Drift',
          cta: 'New customer',
          onCta: () => _openForm(context, ref),
        );
        return ListScreen(spec: spec);
      },
    );
  }

  void _openForm(BuildContext context, WidgetRef ref, {Customer? existing}) {
    final isEdit = existing != null;
    final code = QuickField('CODE', initial: existing?.code ?? 'C-0${DateTime.now().millisecondsSinceEpoch % 1000}');
    final name = QuickField('NAME', initial: existing?.name ?? '');
    final group = QuickField('GROUP', initial: existing?.groupName ?? 'Retail');
    final gstin = QuickField('GSTIN', initial: existing?.gstin ?? '');
    final state = QuickField('STATE', initial: existing?.state ?? 'Maharashtra');
    final stateCode = QuickField('STATE CODE', initial: existing?.stateCode ?? '27');
    final creditLimit = QuickField(
      'CREDIT LIMIT (₹)',
      initial: existing == null ? '0' : existing.creditLimitPaise.toRupees.toString(),
      keyboardType: TextInputType.number,
    );

    showRecordFormDialog(
      context: context,
      title: isEdit ? 'Edit customer' : 'New customer',
      submitLabel: isEdit ? 'Save' : 'Create',
      fields: [code, name, group, gstin, state, stateCode, creditLimit],
      onSubmit: () async {
        if (name.controller.text.trim().isEmpty) throw 'Name is required';
        final repo = ref.read(masterDataRepositoryProvider);
        final args = (
          code: code.controller.text.trim(),
          name: name.controller.text.trim(),
          groupName: group.controller.text.trim(),
          gstin: gstin.controller.text.trim().isEmpty ? null : gstin.controller.text.trim(),
          state: state.controller.text.trim(),
          stateCode: stateCode.controller.text.trim(),
          creditLimitPaise: rupeesToPaise(num.tryParse(creditLimit.controller.text.trim()) ?? 0),
        );
        if (isEdit) {
          await repo.updateCustomer(
            existing.id,
            code: args.code,
            name: args.name,
            groupName: args.groupName,
            gstin: args.gstin,
            state: args.state,
            stateCode: args.stateCode,
            creditLimitPaise: args.creditLimitPaise,
          );
        } else {
          await repo.createCustomer(
            code: args.code,
            name: args.name,
            groupName: args.groupName,
            gstin: args.gstin,
            state: args.state,
            stateCode: args.stateCode,
            creditLimitPaise: args.creditLimitPaise,
          );
        }
      },
      onDelete: isEdit ? () => ref.read(masterDataRepositoryProvider).deleteCustomer(existing.id) : null,
      deleteConfirmMessage: 'This removes ${existing?.name ?? 'the customer'} from lists. Existing invoices are kept for the record.',
    );
  }
}
