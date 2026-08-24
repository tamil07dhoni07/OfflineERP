import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/money.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';

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
          return RowSpec([
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
          ]);
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
