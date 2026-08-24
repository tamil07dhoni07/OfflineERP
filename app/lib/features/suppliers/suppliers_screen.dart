import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';
import '../../shared/widgets/quick_add_dialog.dart';

final suppliersProvider = StreamProvider((ref) => ref.watch(masterDataRepositoryProvider).watchSuppliers());

class SuppliersScreen extends ConsumerWidget {
  const SuppliersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(suppliersProvider);
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load suppliers: $e'),
      data: (suppliers) {
        final rows = suppliers
            .map(
              (s) => RowSpec([
                Cell.text(s.code, mono: true, weight: FontWeight.w500),
                Cell.text(s.name),
                Cell.text(s.category, color: AppColors.mutedInk),
                Cell.text(s.gstin ?? '—', mono: true, color: AppColors.mutedInk),
                Cell.text(s.terms, mono: true, color: AppColors.mutedInk),
                Cell.number('—'),
                Cell.number('0', color: AppColors.mutedInk),
                pillCell(PillTone.paid, 'Active'),
              ]),
            )
            .toList();

        final spec = TableSpec(
          title: 'Suppliers',
          subtitle: 'Vendor accounts, payment terms and open payables',
          devNote: 'features/suppliers · suppliers · supplier_balances view',
          filters: const [FilterSpec('Group', 'All'), FilterSpec('State', 'All'), FilterSpec('Terms', 'Any')],
          columns: const [
            ColumnSpec('CODE'),
            ColumnSpec('NAME'),
            ColumnSpec('CATEGORY'),
            ColumnSpec('GSTIN'),
            ColumnSpec('TERMS'),
            ColumnSpec('PAYABLE', align: CellAlign.right),
            ColumnSpec('OVERDUE', align: CellAlign.right),
            ColumnSpec('STATUS'),
          ],
          rows: rows,
          count: '${rows.length} suppliers · queried live from Drift',
          cta: 'New supplier',
          onCta: () => _newSupplier(context, ref),
          note:
              'Payable balances aren\'t tracked yet — purchasing (POs, GRNs, supplier payments) isn\'t backed by the database in this build.',
        );
        return ListScreen(spec: spec);
      },
    );
  }

  void _newSupplier(BuildContext context, WidgetRef ref) {
    final code = QuickField('CODE', initial: 'S-0${DateTime.now().millisecondsSinceEpoch % 1000}');
    final name = QuickField('NAME');
    final category = QuickField('CATEGORY', initial: 'Raw material');
    final gstin = QuickField('GSTIN');
    final terms = QuickField('TERMS', initial: 'Net 30');

    showQuickAddDialog(
      context: context,
      title: 'New supplier',
      fields: [code, name, category, gstin, terms],
      onSubmit: () async {
        if (name.controller.text.trim().isEmpty) throw 'Name is required';
        await ref
            .read(masterDataRepositoryProvider)
            .createSupplier(
              code: code.controller.text.trim(),
              name: name.controller.text.trim(),
              category: category.controller.text.trim(),
              gstin: gstin.controller.text.trim().isEmpty ? null : gstin.controller.text.trim(),
              terms: terms.controller.text.trim(),
            );
      },
    );
  }
}
