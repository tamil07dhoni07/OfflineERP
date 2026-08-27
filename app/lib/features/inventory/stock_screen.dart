import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/database/repositories/stock_repository.dart';
import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../core/utils/money.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/widgets/list_screen.dart';

final stockRowsProvider = StreamProvider((ref) => ref.watch(stockRepositoryProvider).watchStockRows());

class StockScreen extends ConsumerWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(stockRowsProvider);
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load stock: $e'),
      data: (rows) {
        final sorted = [...rows]..sort((a, b) => a.product.sku.compareTo(b.product.sku));
        final rowSpecs = sorted.map((r) {
          final below = r.onHand < r.product.reorderLevel;
          return RowSpec([
            Cell.text(r.product.sku, mono: true, weight: FontWeight.w500),
            Cell.text(r.product.name),
            Cell.text(r.product.hsn, mono: true, color: AppColors.mutedInk),
            Cell.text(r.warehouse.name),
            Cell.text('—', color: AppColors.mutedInk),
            Cell.number(
              '${r.onHand}',
              color: below ? AppColors.danger : AppColors.ink,
              weight: below ? FontWeight.w600 : FontWeight.w400,
            ),
            Cell.number('${r.reserved}'),
            Cell.number('${r.product.reorderLevel}'),
            Cell.number(r.avgCostPaise.toIndianRupees()),
            Cell.number(r.valuePaise.toIndianRupees()),
          ], onTap: () => showDialog(context: context, builder: (_) => _StockDetailDialog(row: r)));
        }).toList();

        final spec = TableSpec(
          title: 'Stock on Hand',
          subtitle: 'Live quantities across warehouses, valued at moving average · tap a row for movement history',
          devNote: 'features/inventory · stock_movements · running balance view',
          filters: const [
            FilterSpec('Warehouse', 'All'),
            FilterSpec('Category', 'All'),
            FilterSpec('Below reorder', 'Off'),
          ],
          columns: const [
            ColumnSpec('SKU'),
            ColumnSpec('PRODUCT'),
            ColumnSpec('HSN'),
            ColumnSpec('WAREHOUSE'),
            ColumnSpec('BATCH'),
            ColumnSpec('ON HAND', align: CellAlign.right),
            ColumnSpec('RESERVED', align: CellAlign.right),
            ColumnSpec('REORDER', align: CellAlign.right),
            ColumnSpec('AVG COST', align: CellAlign.right),
            ColumnSpec('VALUE', align: CellAlign.right),
          ],
          rows: rowSpecs,
          count: '${rowSpecs.length} rows · derived by summing stock_movements',
          note:
              'On-hand is never a mutable counter — it\'s the live sum of every stock movement. Reserved counts quantity on draft (unposted) invoices. Use Stock Transfers or Adjustments to move or correct quantities.',
        );
        return ListScreen(spec: spec);
      },
    );
  }
}

const _movementKindLabel = {
  'in': 'Opening / GRN',
  'out': 'Sale',
  'transfer_in': 'Transfer in',
  'transfer_out': 'Transfer out',
  'adjust': 'Adjustment',
};

class _StockDetailDialog extends ConsumerWidget {
  const _StockDetailDialog({required this.row});
  final StockRow row;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520, maxHeight: 560),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(row.product.name, style: AppText.sans(size: 16, weight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text('${row.product.sku} · ${row.warehouse.name}', style: AppText.mono(size: 11.5, color: AppColors.mutedInk)),
              const SizedBox(height: 16),
              Flexible(
                child: SingleChildScrollView(
                  child: FutureBuilder<List<StockMovement>>(
                    future: ref.read(stockRepositoryProvider).movementsFor(row.product.id, row.warehouse.id),
                    builder: (context, snap) {
                      if (!snap.hasData) return const Padding(padding: EdgeInsets.all(12), child: LinearProgressIndicator());
                      final movements = snap.data!;
                      if (movements.isEmpty) return Text('No movements yet.', style: AppText.sans(size: 12.5, color: AppColors.mutedInk));
                      return Column(
                        children: [
                          for (final m in movements)
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderFaint))),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(_movementKindLabel[m.kind] ?? m.kind, style: AppText.sans(size: 12.5, weight: FontWeight.w500)),
                                        Text(
                                          '${m.createdAt.day}/${m.createdAt.month}/${m.createdAt.year}'
                                          '${m.reason != null ? ' · ${m.reason}' : ''}',
                                          style: AppText.sans(size: 10.5, color: AppColors.mutedFaint),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    '${m.qtyDelta > 0 ? '+' : ''}${m.qtyDelta}',
                                    style: AppText.mono(
                                      size: 13,
                                      weight: FontWeight.w600,
                                      color: m.qtyDelta > 0 ? AppColors.successText : AppColors.danger,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Align(alignment: Alignment.centerRight, child: SecondaryButton(label: 'Close', onTap: () => Navigator.of(context).pop())),
            ],
          ),
        ),
      ),
    );
  }
}
