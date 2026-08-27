import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/money.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';
import '../../shared/widgets/quick_add_dialog.dart';

final suppliersProvider = StreamProvider((ref) => ref.watch(masterDataRepositoryProvider).watchSuppliers());

class SuppliersScreen extends ConsumerWidget {
  const SuppliersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(suppliersProvider);
    final payableAsync = ref.watch(payableBySupplierProvider);
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load suppliers: $e'),
      data: (suppliers) {
        final payable = payableAsync.valueOrNull ?? {};
        final rows = suppliers
            .map((s) {
              final owed = payable[s.id] ?? 0;
              return RowSpec([
                Cell.text(s.code, mono: true, weight: FontWeight.w500),
                Cell.text(s.name),
                Cell.text(s.category, color: AppColors.mutedInk),
                Cell.text(s.gstin ?? '—', mono: true, color: AppColors.mutedInk),
                Cell.text(s.terms, mono: true, color: AppColors.mutedInk),
                Cell.number(owed.toIndianRupees(), color: owed > 0 ? AppColors.danger : AppColors.mutedInk),
                pillCell(owed > 0 ? PillTone.warn : PillTone.paid, owed > 0 ? 'Payable due' : 'Settled'),
              ], onTap: () => _openForm(context, ref, existing: s));
            })
            .toList();

        final spec = TableSpec(
          title: 'Suppliers',
          subtitle: 'Vendor accounts, payment terms and open payables · tap a row to edit',
          devNote: 'features/suppliers · suppliers · goods_receipts balance',
          filters: const [FilterSpec('Group', 'All'), FilterSpec('State', 'All'), FilterSpec('Terms', 'Any')],
          columns: const [
            ColumnSpec('CODE'),
            ColumnSpec('NAME'),
            ColumnSpec('CATEGORY'),
            ColumnSpec('GSTIN'),
            ColumnSpec('TERMS'),
            ColumnSpec('PAYABLE', align: CellAlign.right),
            ColumnSpec('STATUS'),
          ],
          rows: rows,
          count: '${rows.length} suppliers · queried live from Drift',
          cta: 'New supplier',
          onCta: () => _openForm(context, ref),
        );
        return ListScreen(spec: spec);
      },
    );
  }

  void _openForm(BuildContext context, WidgetRef ref, {Supplier? existing}) {
    final isEdit = existing != null;
    final code = QuickField('CODE', initial: existing?.code ?? 'S-0${DateTime.now().millisecondsSinceEpoch % 1000}');
    final name = QuickField('NAME', initial: existing?.name ?? '');
    final category = QuickField('CATEGORY', initial: existing?.category ?? 'Raw material');
    final gstin = QuickField('GSTIN', initial: existing?.gstin ?? '');
    final terms = QuickField('TERMS', initial: existing?.terms ?? 'Net 30');

    showRecordFormDialog(
      context: context,
      title: isEdit ? 'Edit supplier' : 'New supplier',
      submitLabel: isEdit ? 'Save' : 'Create',
      fields: [code, name, category, gstin, terms],
      onSubmit: () async {
        if (name.controller.text.trim().isEmpty) throw 'Name is required';
        final repo = ref.read(masterDataRepositoryProvider);
        if (isEdit) {
          await repo.updateSupplier(
            existing.id,
            code: code.controller.text.trim(),
            name: name.controller.text.trim(),
            category: category.controller.text.trim(),
            gstin: gstin.controller.text.trim().isEmpty ? null : gstin.controller.text.trim(),
            terms: terms.controller.text.trim(),
          );
        } else {
          await repo.createSupplier(
            code: code.controller.text.trim(),
            name: name.controller.text.trim(),
            category: category.controller.text.trim(),
            gstin: gstin.controller.text.trim().isEmpty ? null : gstin.controller.text.trim(),
            terms: terms.controller.text.trim(),
          );
        }
      },
      onDelete: isEdit ? () => ref.read(masterDataRepositoryProvider).deleteSupplier(existing.id) : null,
      deleteConfirmMessage: 'This removes ${existing?.name ?? 'the supplier'} from lists.',
    );
  }
}
