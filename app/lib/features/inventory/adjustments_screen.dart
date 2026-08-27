import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../core/utils/money.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/widgets/list_screen.dart';
import '../auth/auth_controller.dart';
import '../products/products_screen.dart';
import 'transfers_screen.dart' show warehousesListProvider;

final adjustmentsProvider = StreamProvider((ref) => ref.watch(inventoryRepositoryProvider).watchAdjustments());

class AdjustmentsScreen extends ConsumerWidget {
  const AdjustmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final adjustmentsAsync = ref.watch(adjustmentsProvider);
    final productsAsync = ref.watch(productsProvider);
    final warehousesAsync = ref.watch(warehousesListProvider);

    return adjustmentsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load adjustments: $e'),
      data: (adjustments) {
        final productsById = {for (final p in productsAsync.valueOrNull ?? <Product>[]) p.id: p};
        final whById = {for (final w in warehousesAsync.valueOrNull ?? <Warehouse>[]) w.id: w};
        final rows = adjustments.map((a) {
          final product = productsById[a.productId];
          return RowSpec([
            Cell.text(a.adjustmentNo, mono: true, weight: FontWeight.w500),
            Cell.text(_fmtDate(a.date), mono: true, color: AppColors.mutedInk),
            Cell.text(product?.sku ?? a.productId, mono: true),
            Cell.text(whById[a.warehouseId]?.name ?? a.warehouseId),
            Cell.text(a.status == 'reversed' ? '${a.reason} (reversed)' : a.reason),
            Cell.number('${a.deltaQty > 0 ? '+' : ''}${a.deltaQty}', color: a.deltaQty > 0 ? AppColors.successText : AppColors.danger),
            Cell.number(
              '${a.valueImpactPaise > 0 ? '+' : ''}${a.valueImpactPaise.toIndianRupees()}',
              color: a.valueImpactPaise > 0 ? AppColors.successText : AppColors.danger,
            ),
            Cell.text(a.approvedBy, color: AppColors.mutedInk),
          ], onTap: () => _openDetail(context, ref, a));
        }).toList();

        final spec = TableSpec(
          title: 'Stock Adjustments',
          subtitle: 'Every quantity correction, with reason and approver · tap a row for details',
          devNote: 'features/inventory · stock_adjustments · audit_logs',
          filters: const [FilterSpec('Reason', 'All'), FilterSpec('Warehouse', 'All')],
          columns: const [
            ColumnSpec('REF'),
            ColumnSpec('DATE'),
            ColumnSpec('SKU'),
            ColumnSpec('WAREHOUSE'),
            ColumnSpec('REASON'),
            ColumnSpec('DELTA', align: CellAlign.right),
            ColumnSpec('VALUE IMPACT', align: CellAlign.right),
            ColumnSpec('APPROVED BY'),
          ],
          rows: rows,
          count: '${rows.length} adjustment(s) · queried live from Drift',
          cta: 'New adjustment',
          onCta: () => showDialog(context: context, builder: (_) => const _NewAdjustmentDialog()),
        );
        return ListScreen(spec: spec);
      },
    );
  }

  void _openDetail(BuildContext context, WidgetRef ref, StockAdjustment a) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.card,
        title: Text(a.adjustmentNo),
        content: Text('${a.reason}\nApproved by ${a.approvedBy}\n${a.deltaQty > 0 ? '+' : ''}${a.deltaQty} units'),
        actions: [
          if (a.status != 'reversed')
            TextButton(
              onPressed: () async {
                await ref
                    .read(inventoryRepositoryProvider)
                    .reverseAdjustment(a.id, actor: ref.read(authControllerProvider)?.username ?? 'unknown', device: currentDeviceId);
                if (context.mounted) Navigator.of(context).pop();
              },
              child: const Text('Reverse', style: TextStyle(color: AppColors.danger)),
            ),
          TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('Close')),
        ],
      ),
    );
  }
}

String _fmtDate(DateTime d) {
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${d.day.toString().padLeft(2, '0')} ${months[d.month - 1]} ${d.year}';
}

class _NewAdjustmentDialog extends ConsumerStatefulWidget {
  const _NewAdjustmentDialog();

  @override
  ConsumerState<_NewAdjustmentDialog> createState() => _NewAdjustmentDialogState();
}

class _NewAdjustmentDialogState extends ConsumerState<_NewAdjustmentDialog> {
  Product? _product;
  Warehouse? _warehouse;
  final _deltaCtrl = TextEditingController();
  final _reasonCtrl = TextEditingController();
  final _approvedByCtrl = TextEditingController();
  bool _submitting = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(productsProvider);
    final warehousesAsync = ref.watch(warehousesListProvider);

    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('New stock adjustment', style: AppText.sans(size: 16, weight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text('Positive quantity for found stock, negative for write-offs.', style: AppText.sans(size: 12, color: AppColors.mutedInk)),
              const SizedBox(height: 16),
              productsAsync.when(
                loading: () => const LinearProgressIndicator(),
                error: (e, st) => Text('$e'),
                data: (products) => _dropdownField<Product>('PRODUCT', _product, products, (p) => '${p.sku} · ${p.name}', (p) => setState(() => _product = p)),
              ),
              const SizedBox(height: 12),
              warehousesAsync.when(
                loading: () => const LinearProgressIndicator(),
                error: (e, st) => Text('$e'),
                data: (warehouses) => _dropdownField<Warehouse>('WAREHOUSE', _warehouse, warehouses, (w) => w.name, (w) => setState(() => _warehouse = w)),
              ),
              const SizedBox(height: 12),
              _textField('QUANTITY CHANGE (+/-)', _deltaCtrl, keyboardType: const TextInputType.numberWithOptions(signed: true)),
              const SizedBox(height: 12),
              _textField('REASON', _reasonCtrl),
              const SizedBox(height: 12),
              _textField('APPROVED BY', _approvedByCtrl),
              if (_error != null) ...[
                const SizedBox(height: 10),
                Text(_error!, style: AppText.sans(size: 12, color: AppColors.danger)),
              ],
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SecondaryButton(label: 'Cancel', onTap: _submitting ? null : () => Navigator.of(context).pop()),
                  const SizedBox(width: 8),
                  PrimaryButton(label: _submitting ? 'Posting…' : 'Post adjustment', onTap: _submitting ? null : _submit),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final delta = int.tryParse(_deltaCtrl.text.trim().replaceAll('+', '')) ?? 0;
    if (_product == null || _warehouse == null || delta == 0 || _reasonCtrl.text.trim().isEmpty || _approvedByCtrl.text.trim().isEmpty) {
      setState(() => _error = 'Fill in product, warehouse, a non-zero quantity change, reason and approver.');
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref
          .read(inventoryRepositoryProvider)
          .createAdjustment(
            date: DateTime.now(),
            product: _product!,
            warehouse: _warehouse!,
            deltaQty: delta,
            reason: _reasonCtrl.text.trim(),
            approvedBy: _approvedByCtrl.text.trim(),
            actor: ref.read(authControllerProvider)?.username ?? 'unknown',
            device: currentDeviceId,
          );
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _error = '$e';
        _submitting = false;
      });
    }
  }

  Widget _dropdownField<T>(String label, T? value, List<T> items, String Function(T) labelOf, void Function(T?) onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
        const SizedBox(height: 5),
        Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 11),
          decoration: BoxDecoration(color: AppColors.fieldFill, border: Border.all(color: AppColors.fieldBorder), borderRadius: BorderRadius.circular(7)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              isExpanded: true,
              value: value,
              hint: Text('Select', style: AppText.sans(size: 13, color: AppColors.mutedFaint)),
              items: [for (final item in items) DropdownMenuItem(value: item, child: Text(labelOf(item), style: AppText.sans(size: 13)))],
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }

  Widget _textField(String label, TextEditingController controller, {TextInputType? keyboardType}) {
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
            keyboardType: keyboardType,
            style: AppText.sans(size: 13),
            decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: false),
          ),
        ),
      ],
    );
  }
}
