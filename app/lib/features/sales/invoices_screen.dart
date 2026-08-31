import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/money.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';
import '../auth/auth_controller.dart';

(PillTone, String) statusPillFor(String status) {
  switch (status) {
    case 'paid':
      return (PillTone.paid, 'Paid');
    case 'posted':
      return (PillTone.posted, 'Posted');
    case 'part_paid':
      return (PillTone.warn, 'Part paid');
    case 'overdue':
      return (PillTone.late, 'Overdue');
    case 'voided':
      return (PillTone.late, 'Voided');
    default:
      return (PillTone.draft, 'Draft');
  }
}

final invoicesWithCustomersProvider = StreamProvider((ref) => ref.watch(salesRepositoryProvider).watchInvoicesWithCustomers());

class InvoicesScreen extends ConsumerWidget {
  const InvoicesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(invoicesWithCustomersProvider);
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load invoices: $e'),
      data: (rows) {
        final rowSpecs = rows.map((r) {
          final inv = r.invoice;
          final (tone, label) = statusPillFor(inv.status);
          final isDraft = inv.status == 'draft';
          final isVoidable = !isDraft && inv.status != 'voided';
          return RowSpec(
            [
              Cell.text(inv.invoiceNo, mono: true, weight: FontWeight.w500),
              Cell.text(DateFormat('d MMM yyyy').format(inv.date), mono: true, color: AppColors.mutedInk),
              Cell.text(r.customer.name),
              Cell.text(r.customer.gstin ?? '—', mono: true, color: AppColors.mutedInk),
              Cell.text('${inv.placeOfSupplyState} (${inv.placeOfSupplyCode})', color: AppColors.mutedInk),
              Cell.number(inv.taxableValuePaise.toIndianRupees()),
              Cell.number((inv.cgstPaise + inv.sgstPaise + inv.igstPaise).toIndianRupees()),
              Cell.number(inv.totalPaise.toIndianRupees(), weight: FontWeight.w600),
              Cell.number(
                inv.balancePaise.toIndianRupees(),
                color: inv.balancePaise > 0 ? AppColors.danger : AppColors.mutedInk,
              ),
              pillCell(tone, label),
            ],
            onTap: isDraft ? () => context.go('/invoice-new?id=${inv.id}') : null,
            onEdit: isDraft ? () => context.go('/invoice-new?id=${inv.id}') : null,
            onDelete: isDraft
                ? () => ref.read(salesRepositoryProvider).deleteDraftInvoice(
                    inv.id,
                    actor: ref.read(authControllerProvider)?.username ?? 'unknown',
                    device: currentDeviceId,
                  )
                : isVoidable
                ? () => ref.read(salesRepositoryProvider).voidInvoice(
                    inv.id,
                    actor: ref.read(authControllerProvider)?.username ?? 'unknown',
                    device: currentDeviceId,
                  )
                : null,
            deleteTooltip: isDraft ? 'Delete' : 'Void',
            deleteConfirmTitle: isDraft ? 'Delete this draft?' : 'Void this invoice?',
            deleteConfirmMessage: isDraft
                ? 'This removes ${inv.invoiceNo} — it was never posted, so nothing else is affected.'
                : 'Reverses the stock movement and posts a reversing journal for ${inv.invoiceNo}. The invoice stays on record as voided.',
          );
        }).toList();

        final spec = TableSpec(
          title: 'Sales Invoices',
          subtitle: 'Posted and draft invoices for FY 2026-27 · Mumbai HQ',
          devNote: 'features/sales · sales_invoices · SalesInvoiceRepository',
          filters: const [
            FilterSpec('Status', 'All'),
            FilterSpec('Period', 'Aug 2026'),
            FilterSpec('Branch', 'Mumbai HQ'),
            FilterSpec('Customer', 'Any'),
          ],
          columns: const [
            ColumnSpec('INVOICE #'),
            ColumnSpec('DATE'),
            ColumnSpec('CUSTOMER'),
            ColumnSpec('GSTIN'),
            ColumnSpec('PLACE OF SUPPLY'),
            ColumnSpec('TAXABLE', align: CellAlign.right),
            ColumnSpec('GST', align: CellAlign.right),
            ColumnSpec('TOTAL', align: CellAlign.right),
            ColumnSpec('BALANCE', align: CellAlign.right),
            ColumnSpec('STATUS'),
          ],
          rows: rowSpecs,
          count: '${rowSpecs.length} invoices · queried live from Drift',
          cta: 'New invoice',
          onCta: () => context.go('/invoice-new'),
          note: 'Editing a posted invoice creates a reversing journal and a new audit-log entry rather than mutating history.',
        );
        return ListScreen(spec: spec);
      },
    );
  }
}
