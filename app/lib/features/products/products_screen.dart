import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
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
          ], onTap: () => _openForm(context, ref, existing: p));
        }).toList();

        final spec = TableSpec(
          title: 'Products',
          subtitle: 'Catalogue with pricing, tax class and reorder policy · tap a row to edit',
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
          onCta: () => _openForm(context, ref),
        );
        return ListScreen(spec: spec);
      },
    );
  }

  void _openForm(BuildContext context, WidgetRef ref, {Product? existing}) {
    final isEdit = existing != null;
    final sku = QuickField('SKU', initial: existing?.sku ?? '');
    final name = QuickField('NAME', initial: existing?.name ?? '');
    final category = QuickField('CATEGORY', initial: existing?.category ?? 'General');
    final uom = QuickField('UOM', initial: existing?.uom ?? 'PCS');
    final hsn = QuickField('HSN', initial: existing?.hsn ?? '');
    final purchase = QuickField(
      'PURCHASE PRICE (₹)',
      initial: existing == null ? '0' : existing.purchasePricePaise.toRupees.toString(),
      keyboardType: TextInputType.number,
    );
    final selling = QuickField(
      'SELLING PRICE (₹)',
      initial: existing == null ? '0' : existing.sellingPricePaise.toRupees.toString(),
      keyboardType: TextInputType.number,
    );
    final gst = QuickField('GST %', initial: existing?.gstRate.toStringAsFixed(0) ?? '18', keyboardType: TextInputType.number);
    final reorder = QuickField(
      'REORDER LEVEL',
      initial: existing?.reorderLevel.toString() ?? '0',
      keyboardType: TextInputType.number,
    );

    showRecordFormDialog(
      context: context,
      title: isEdit ? 'Edit product' : 'New product',
      submitLabel: isEdit ? 'Save' : 'Create',
      fields: [sku, name, category, uom, hsn, purchase, selling, gst, reorder],
      onSubmit: () async {
        if (sku.controller.text.trim().isEmpty || name.controller.text.trim().isEmpty) {
          throw 'SKU and name are required';
        }
        final repo = ref.read(masterDataRepositoryProvider);
        final args = (
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
        if (isEdit) {
          await repo.updateProduct(
            existing.id,
            sku: args.sku,
            name: args.name,
            category: args.category,
            uom: args.uom,
            hsn: args.hsn,
            purchasePricePaise: args.purchasePricePaise,
            sellingPricePaise: args.sellingPricePaise,
            gstRate: args.gstRate,
            reorderLevel: args.reorderLevel,
          );
        } else {
          await repo.createProduct(
            sku: args.sku,
            name: args.name,
            category: args.category,
            uom: args.uom,
            hsn: args.hsn,
            purchasePricePaise: args.purchasePricePaise,
            sellingPricePaise: args.sellingPricePaise,
            gstRate: args.gstRate,
            reorderLevel: args.reorderLevel,
          );
        }
      },
      onDelete: isEdit ? () => ref.read(masterDataRepositoryProvider).deleteProduct(existing.id) : null,
      deleteConfirmMessage: 'This removes ${existing?.name ?? 'the product'} from lists.',
    );
  }
}
