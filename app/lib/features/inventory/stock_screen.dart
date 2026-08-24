import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/money.dart';
import '../../shared/models/table_spec.dart';
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
          ]);
        }).toList();

        final spec = TableSpec(
          title: 'Stock on Hand',
          subtitle: 'Live quantities across warehouses, valued at moving average',
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
              'On-hand is never a mutable counter — it\'s the live sum of every stock movement. Reserved counts quantity on draft (unposted) invoices.',
        );
        return ListScreen(spec: spec);
      },
    );
  }
}
