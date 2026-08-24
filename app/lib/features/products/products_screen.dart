import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/money.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';
import '../../shared/widgets/quick_add_dialog.dart';

final productsProvider = StreamProvider((ref) => ref.watch(masterDataRepositoryProvider).watchProducts());

class ProductsScreen extends ConsumerWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(productsProvider);
    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load products: $e'),
      data: (products) {
        final rows = products.map((p) {
          final margin = p.sellingPricePaise == 0
              ? 0.0
              : (p.sellingPricePaise - p.purchasePricePaise) / p.sellingPricePaise * 100;
          final marginColor = margin >= 18
              ? AppColors.successText
              : margin >= 12
              ? AppColors.warnText
              : AppColors.danger;
          return RowSpec([
            Cell.text(p.sku, mono: true, weight: FontWeight.w500),
            Cell.text(p.name),
            Cell.text(p.category, color: AppColors.mutedInk),
            Cell.text(p.uom, mono: true, color: AppColors.mutedInk),
            Cell.text(p.hsn, mono: true, color: AppColors.mutedInk),
            Cell.number(p.purchasePricePaise.toIndianRupees()),
            Cell.number(p.sellingPricePaise.toIndianRupees()),
            Cell.number('${p.gstRate.toStringAsFixed(0)}%'),
            Cell.number('${margin.toStringAsFixed(1)}%', color: marginColor),
            pillCell(p.active ? PillTone.paid : PillTone.draft, p.active ? 'Active' : 'Discontinued'),
          ]);
        }).toList();

        final spec = TableSpec(
          title: 'Products',
          subtitle: 'Catalogue with pricing, tax class and reorder policy',
          devNote: 'features/products · products · variants · barcodes',
          filters: const [FilterSpec('Category', 'All'), FilterSpec('Brand', 'All'), FilterSpec('Tax', '18%')],
          columns: const [
            ColumnSpec('SKU'),
            ColumnSpec('PRODUCT'),
            ColumnSpec('CATEGORY'),
            ColumnSpec('UOM'),
            ColumnSpec('HSN'),
            ColumnSpec('PURCHASE', align: CellAlign.right),
            ColumnSpec('SELLING', align: CellAlign.right),
            ColumnSpec('GST', align: CellAlign.right),
            ColumnSpec('MARGIN', align: CellAlign.right),
            ColumnSpec('STATUS'),
          ],
          rows: rows,
          count: '${rows.length} products · queried live from Drift',
          cta: 'New product',
          onCta: () => _newProduct(context, ref),
        );
        return ListScreen(spec: spec);
      },
    );
  }

  void _newProduct(BuildContext context, WidgetRef ref) {
    final sku = QuickField('SKU');
    final name = QuickField('NAME');
    final category = QuickField('CATEGORY', initial: 'General');
    final uom = QuickField('UOM', initial: 'PCS');
    final hsn = QuickField('HSN');
    final purchase = QuickField('PURCHASE PRICE (₹)', initial: '0', keyboardType: TextInputType.number);
    final selling = QuickField('SELLING PRICE (₹)', initial: '0', keyboardType: TextInputType.number);
    final gst = QuickField('GST %', initial: '18', keyboardType: TextInputType.number);
    final reorder = QuickField('REORDER LEVEL', initial: '0', keyboardType: TextInputType.number);

    showQuickAddDialog(
      context: context,
      title: 'New product',
      fields: [sku, name, category, uom, hsn, purchase, selling, gst, reorder],
      onSubmit: () async {
        if (sku.controller.text.trim().isEmpty || name.controller.text.trim().isEmpty) {
          throw 'SKU and name are required';
        }
        await ref
            .read(masterDataRepositoryProvider)
            .createProduct(
              sku: sku.controller.text.trim(),
              name: name.controller.text.trim(),
              category: category.controller.text.trim(),
              uom: uom.controller.text.trim(),
              hsn: hsn.controller.text.trim(),
              purchasePricePaise: rupeesToPaise(num.tryParse(purchase.controller.text.trim()) ?? 0),
              sellingPricePaise: rupeesToPaise(num.tryParse(selling.controller.text.trim()) ?? 0),
              gstRate: double.tryParse(gst.controller.text.trim()) ?? 18,
              reorderLevel: int.tryParse(reorder.controller.text.trim()) ?? 0,
            );
      },
    );
  }
}
