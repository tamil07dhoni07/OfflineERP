import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/database/repositories/purchasing_repository.dart';
import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../core/utils/money.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/widgets/list_screen.dart';
import '../auth/auth_controller.dart';
import '../products/products_screen.dart';
import '../suppliers/suppliers_screen.dart';

final purchaseOrdersProvider = StreamProvider((ref) => ref.watch(purchasingRepositoryProvider).watchPurchaseOrders());

const _poStatusTone = {
  'draft': PillTone.draft,
  'approved': PillTone.posted,
  'part_received': PillTone.warn,
  'received': PillTone.paid,
  'cancelled': PillTone.late,
};
const _poStatusLabel = {
  'draft': 'Draft',
  'approved': 'Approved',
  'part_received': 'Part received',
  'received': 'Received',
  'cancelled': 'Cancelled',
};

class PurchaseOrdersScreen extends ConsumerWidget {
  const PurchaseOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posAsync = ref.watch(purchaseOrdersProvider);
    final suppliersAsync = ref.watch(suppliersProvider);

    return posAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load purchase orders: $e'),
      data: (pos) {
        final suppliersById = {for (final s in suppliersAsync.valueOrNull ?? <Supplier>[]) s.id: s};
        final rows = pos.map((po) {
          final supplier = suppliersById[po.supplierId];
          return RowSpec([
            Cell.text(po.poNo, mono: true, weight: FontWeight.w500),
            Cell.text(_fmtDate(po.date), mono: true, color: AppColors.mutedInk),
            Cell.text(supplier?.name ?? po.supplierId),
            Cell.number(po.totalPaise.toIndianRupees(), weight: FontWeight.w600),
            pillCell(_poStatusTone[po.status] ?? PillTone.draft, _poStatusLabel[po.status] ?? po.status),
          ], onTap: () => _openPoDetail(context, ref, po));
        }).toList();

        final spec = TableSpec(
          title: 'Purchase Orders',
          subtitle: 'Committed orders and their receipt progress · tap a row for details',
          devNote: 'features/purchasing · purchase_orders · goods_receipts',
          filters: const [FilterSpec('Status', 'All'), FilterSpec('Supplier', 'Any')],
          columns: const [
            ColumnSpec('PO #'),
            ColumnSpec('DATE'),
            ColumnSpec('SUPPLIER'),
            ColumnSpec('VALUE', align: CellAlign.right),
            ColumnSpec('STATUS'),
          ],
          rows: rows,
          count: '${rows.length} purchase order(s) · queried live from Drift',
          cta: 'New purchase order',
          onCta: () => showDialog(context: context, builder: (_) => const _NewPoDialog()),
        );
        return ListScreen(spec: spec);
      },
    );
  }

  void _openPoDetail(BuildContext context, WidgetRef ref, PurchaseOrder po) {
    showDialog(context: context, builder: (_) => _PoDetailDialog(po: po));
  }
}

String _fmtDate(DateTime d) {
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${d.day.toString().padLeft(2, '0')} ${months[d.month - 1]} ${d.year}';
}

class _PoDetailDialog extends ConsumerWidget {
  const _PoDetailDialog({required this.po});
  final PurchaseOrder po;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480, maxHeight: 560),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(po.poNo, style: AppText.mono(size: 16, weight: FontWeight.w600)),
                  const SizedBox(width: 10),
                  pillCellWidget(_poStatusTone[po.status] ?? PillTone.draft, _poStatusLabel[po.status] ?? po.status),
                ],
              ),
              const SizedBox(height: 4),
              Text(_fmtDate(po.date), style: AppText.sans(size: 12, color: AppColors.mutedInk)),
              const SizedBox(height: 16),
              Flexible(
                child: SingleChildScrollView(
                  child: FutureBuilder<List<PurchaseOrderItem>>(
                    future: ref.read(purchasingRepositoryProvider).itemsForPo(po.id),
                    builder: (context, snap) {
                      final items = snap.data ?? const <PurchaseOrderItem>[];
                      final productsById = {for (final p in ref.watch(productsProvider).valueOrNull ?? const <Product>[]) p.id: p};
                      if (!snap.hasData) return const Padding(padding: EdgeInsets.all(12), child: LinearProgressIndicator());
                      return Column(
                        children: [
                          for (final item in items)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      productsById[item.productId]?.name ?? item.productId,
                                      style: AppText.sans(size: 12.5),
                                    ),
                                  ),
                                  Text(
                                    '${item.receivedQty}/${item.qty}',
                                    style: AppText.mono(
                                      size: 12,
                                      color: item.receivedQty >= item.qty ? AppColors.successText : AppColors.mutedInk,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Text((item.qty * item.ratePaise).toIndianRupees(withSymbol: true), style: AppText.mono(size: 12)),
                                ],
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (po.status != 'received' && po.status != 'cancelled')
                    TextButton(
                      onPressed: () async {
                        await ref
                            .read(purchasingRepositoryProvider)
                            .cancelPurchaseOrder(
                              po.id,
                              actor: ref.read(authControllerProvider)?.username ?? 'unknown',
                              device: currentDeviceId,
                            );
                        if (context.mounted) Navigator.of(context).pop();
                      },
                      child: const Text('Cancel PO', style: TextStyle(color: AppColors.danger)),
                    )
                  else
                    const SizedBox.shrink(),
                  SecondaryButton(label: 'Close', onTap: () => Navigator.of(context).pop()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget pillCellWidget(PillTone tone, String label) {
  final cell = pillCell(tone, label);
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
    decoration: BoxDecoration(color: cell.pillBg, borderRadius: BorderRadius.circular(999)),
    child: Text(label, style: AppText.sans(size: 11, weight: FontWeight.w600, color: cell.pillFg!)),
  );
}

class _NewPoDialog extends ConsumerStatefulWidget {
  const _NewPoDialog();

  @override
  ConsumerState<_NewPoDialog> createState() => _NewPoDialogState();
}

class _NewPoDialogState extends ConsumerState<_NewPoDialog> {
  Supplier? _supplier;
  Warehouse? _warehouse;
  final List<DraftPoLine> _lines = [];
  bool _submitting = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final suppliersAsync = ref.watch(suppliersProvider);
    final productsAsync = ref.watch(productsProvider);
    final warehousesAsync = ref.watch(warehousesProvider);
    final total = _lines.fold<int>(0, (a, l) => a + l.amountPaise);

    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480, maxHeight: 620),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('New purchase order', style: AppText.sans(size: 16, weight: FontWeight.w600)),
              const SizedBox(height: 16),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _label('SUPPLIER'),
                      const SizedBox(height: 5),
                      suppliersAsync.when(
                        loading: () => const LinearProgressIndicator(),
                        error: (e, st) => Text('$e'),
                        data: (suppliers) => _dropdown<Supplier>(
                          value: _supplier,
                          items: suppliers,
                          labelOf: (s) => '${s.code} · ${s.name}',
                          onChanged: (s) => setState(() => _supplier = s),
                        ),
                      ),
                      const SizedBox(height: 12),
                      _label('WAREHOUSE'),
                      const SizedBox(height: 5),
                      warehousesAsync.when(
                        loading: () => const LinearProgressIndicator(),
                        error: (e, st) => Text('$e'),
                        data: (warehouses) => _dropdown<Warehouse>(
                          value: _warehouse,
                          items: warehouses,
                          labelOf: (w) => w.name,
                          onChanged: (w) => setState(() => _warehouse = w),
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Text('LINE ITEMS', style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
                          const Spacer(),
                          productsAsync.maybeWhen(
                            data: (products) => products.isEmpty
                                ? const SizedBox.shrink()
                                : TextButton(
                                    onPressed: () async {
                                      final line = await showDialog<DraftPoLine>(
                                        context: context,
                                        builder: (_) => _AddPoLineDialog(products: products),
                                      );
                                      if (line != null) setState(() => _lines.add(line));
                                    },
                                    child: const Text('+ Add line'),
                                  ),
                            orElse: () => const SizedBox.shrink(),
                          ),
                        ],
                      ),
                      for (var i = 0; i < _lines.length; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            children: [
                              Expanded(child: Text('${_lines[i].product.name} × ${_lines[i].qty}', style: AppText.sans(size: 12.5))),
                              Text(_lines[i].amountPaise.toIndianRupees(withSymbol: true), style: AppText.mono(size: 12)),
                              IconButton(
                                icon: const Icon(Icons.close, size: 16),
                                onPressed: () => setState(() => _lines.removeAt(i)),
                              ),
                            ],
                          ),
                        ),
                      if (_lines.isNotEmpty) ...[
                        const Divider(),
                        Row(
                          children: [
                            Text('Total', style: AppText.sans(size: 13, weight: FontWeight.w600)),
                            const Spacer(),
                            Text(total.toIndianRupees(withSymbol: true), style: AppText.mono(size: 13, weight: FontWeight.w600)),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              if (_error != null) ...[
                const SizedBox(height: 10),
                Text(_error!, style: AppText.sans(size: 12, color: AppColors.danger)),
              ],
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SecondaryButton(label: 'Cancel', onTap: _submitting ? null : () => Navigator.of(context).pop()),
                  const SizedBox(width: 8),
                  PrimaryButton(label: _submitting ? 'Creating…' : 'Create PO', onTap: _submitting ? null : _submit),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_supplier == null || _warehouse == null || _lines.isEmpty) {
      setState(() => _error = 'Pick a supplier, a warehouse, and add at least one line.');
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref
          .read(purchasingRepositoryProvider)
          .createPurchaseOrder(
            date: DateTime.now(),
            supplier: _supplier!,
            warehouseId: _warehouse!.id,
            lines: _lines,
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

  Widget _label(String text) =>
      Text(text, style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5));

  Widget _dropdown<T>({required T? value, required List<T> items, required String Function(T) labelOf, required void Function(T?) onChanged}) {
    return Container(
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
    );
  }
}

class _AddPoLineDialog extends StatefulWidget {
  const _AddPoLineDialog({required this.products});
  final List<Product> products;

  @override
  State<_AddPoLineDialog> createState() => _AddPoLineDialogState();
}

class _AddPoLineDialogState extends State<_AddPoLineDialog> {
  late Product _product = widget.products.first;
  final _qty = TextEditingController(text: '1');
  final _rate = TextEditingController();

  @override
  void initState() {
    super.initState();
    _rate.text = _product.purchasePricePaise.toRupees.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 360),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Add line', style: AppText.sans(size: 15, weight: FontWeight.w600)),
              const SizedBox(height: 14),
              Container(
                height: 38,
                padding: const EdgeInsets.symmetric(horizontal: 11),
                decoration: BoxDecoration(color: AppColors.fieldFill, border: Border.all(color: AppColors.fieldBorder), borderRadius: BorderRadius.circular(7)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<Product>(
                    isExpanded: true,
                    value: _product,
                    items: [
                      for (final p in widget.products)
                        DropdownMenuItem(value: p, child: Text('${p.sku} · ${p.name}', style: AppText.sans(size: 13))),
                    ],
                    onChanged: (p) => setState(() {
                      _product = p!;
                      _rate.text = p.purchasePricePaise.toRupees.toString();
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _numField('QTY', _qty)),
                  const SizedBox(width: 10),
                  Expanded(child: _numField('RATE (₹)', _rate)),
                ],
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SecondaryButton(label: 'Cancel', onTap: () => Navigator.of(context).pop()),
                  const SizedBox(width: 8),
                  PrimaryButton(
                    label: 'Add',
                    onTap: () {
                      final qty = int.tryParse(_qty.text.trim()) ?? 0;
                      final rate = rupeesToPaise(num.tryParse(_rate.text.trim()) ?? 0);
                      if (qty <= 0) return;
                      Navigator.of(context).pop(DraftPoLine(product: _product, qty: qty, ratePaise: rate));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _numField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.sans(size: 10.5, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.4)),
        const SizedBox(height: 5),
        Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(color: AppColors.fieldFill, border: Border.all(color: AppColors.fieldBorder), borderRadius: BorderRadius.circular(7)),
          child: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: AppText.sans(size: 13),
            decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: false),
          ),
        ),
      ],
    );
  }
}
