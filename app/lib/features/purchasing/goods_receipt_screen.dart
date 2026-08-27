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
import 'purchase_orders_screen.dart';

final goodsReceiptsProvider = StreamProvider((ref) => ref.watch(purchasingRepositoryProvider).watchGoodsReceipts());
final openPurchaseOrdersProvider = FutureProvider((ref) => ref.watch(purchasingRepositoryProvider).openPurchaseOrders());

class GoodsReceiptScreen extends ConsumerWidget {
  const GoodsReceiptScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grnsAsync = ref.watch(goodsReceiptsProvider);
    final suppliersAsync = ref.watch(suppliersProvider);
    final posAsync = ref.watch(purchaseOrdersProvider);

    return grnsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load goods receipts: $e'),
      data: (grns) {
        final suppliersById = {for (final s in suppliersAsync.valueOrNull ?? <Supplier>[]) s.id: s};
        final posById = {for (final p in posAsync.valueOrNull ?? <PurchaseOrder>[]) p.id: p};
        final rows = grns.map((grn) {
          final supplier = suppliersById[grn.supplierId];
          final po = posById[grn.poId];
          return RowSpec([
            Cell.text(grn.grnNo, mono: true, weight: FontWeight.w500),
            Cell.text(_fmtDate(grn.date), mono: true, color: AppColors.mutedInk),
            Cell.text(supplier?.name ?? grn.supplierId),
            Cell.text(po?.poNo ?? grn.poId, mono: true),
            Cell.number(grn.totalPaise.toIndianRupees()),
            grn.balancePaise > 0 ? pillCell(PillTone.warn, 'Payable due') : pillCell(PillTone.paid, 'Settled'),
          ]);
        }).toList();

        final spec = TableSpec(
          title: 'Goods Receipt',
          subtitle: 'Inbound receipts against purchase orders',
          devNote: 'features/purchasing · goods_receipts · stock_movements (IN)',
          filters: const [FilterSpec('Warehouse', 'All'), FilterSpec('PO', 'Any')],
          columns: const [
            ColumnSpec('GRN #'),
            ColumnSpec('DATE'),
            ColumnSpec('SUPPLIER'),
            ColumnSpec('AGAINST PO'),
            ColumnSpec('VALUE', align: CellAlign.right),
            ColumnSpec('STATUS'),
          ],
          rows: rows,
          count: '${rows.length} receipt(s) · queried live from Drift',
          cta: 'New receipt',
          onCta: () => showDialog(context: context, builder: (_) => const _NewGrnDialog()),
        );
        return ListScreen(spec: spec);
      },
    );
  }
}

String _fmtDate(DateTime d) {
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${d.day.toString().padLeft(2, '0')} ${months[d.month - 1]} ${d.year}';
}

class _NewGrnDialog extends ConsumerStatefulWidget {
  const _NewGrnDialog();

  @override
  ConsumerState<_NewGrnDialog> createState() => _NewGrnDialogState();
}

class _NewGrnDialogState extends ConsumerState<_NewGrnDialog> {
  PurchaseOrder? _po;
  List<PurchaseOrderItem> _items = [];
  final Map<String, TextEditingController> _receiveCtrls = {};
  bool _loadingItems = false;
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    for (final c in _receiveCtrls.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _onPoChanged(PurchaseOrder? po) async {
    setState(() {
      _po = po;
      _items = [];
      _receiveCtrls.clear();
      _loadingItems = po != null;
    });
    if (po == null) return;
    final items = await ref.read(purchasingRepositoryProvider).itemsForPo(po.id);
    if (!mounted) return;
    setState(() {
      _items = items.where((i) => i.receivedQty < i.qty).toList();
      for (final item in _items) {
        _receiveCtrls[item.id] = TextEditingController(text: (item.qty - item.receivedQty).toString());
      }
      _loadingItems = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final openPosAsync = ref.watch(openPurchaseOrdersProvider);
    final suppliersById = {for (final s in ref.watch(suppliersProvider).valueOrNull ?? <Supplier>[]) s.id: s};
    final productsById = {for (final p in ref.watch(productsProvider).valueOrNull ?? <Product>[]) p.id: p};

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
              Text('New goods receipt', style: AppText.sans(size: 16, weight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text('Receive stock against an open purchase order.', style: AppText.sans(size: 12, color: AppColors.mutedInk)),
              const SizedBox(height: 16),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('PURCHASE ORDER', style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
                      const SizedBox(height: 5),
                      openPosAsync.when(
                        loading: () => const LinearProgressIndicator(),
                        error: (e, st) => Text('$e'),
                        data: (pos) {
                          if (pos.isEmpty) return Text('No open purchase orders.', style: AppText.sans(size: 12.5, color: AppColors.mutedInk));
                          return Container(
                            height: 38,
                            padding: const EdgeInsets.symmetric(horizontal: 11),
                            decoration: BoxDecoration(color: AppColors.fieldFill, border: Border.all(color: AppColors.fieldBorder), borderRadius: BorderRadius.circular(7)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<PurchaseOrder>(
                                isExpanded: true,
                                value: _po,
                                hint: Text('Select PO', style: AppText.sans(size: 13, color: AppColors.mutedFaint)),
                                items: [
                                  for (final po in pos)
                                    DropdownMenuItem(
                                      value: po,
                                      child: Text('${po.poNo} · ${suppliersById[po.supplierId]?.name ?? po.supplierId}', style: AppText.sans(size: 13)),
                                    ),
                                ],
                                onChanged: _onPoChanged,
                              ),
                            ),
                          );
                        },
                      ),
                      if (_po != null) ...[
                        const SizedBox(height: 12),
                        if (_loadingItems)
                          const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: LinearProgressIndicator())
                        else if (_items.isEmpty)
                          Text('Everything on this PO has already been received.', style: AppText.sans(size: 12.5, color: AppColors.mutedInk))
                        else ...[
                          Text('RECEIVE NOW', style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
                          const SizedBox(height: 6),
                          for (final item in _items)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${productsById[item.productId]?.name ?? item.productId} (remaining ${item.qty - item.receivedQty})',
                                      style: AppText.sans(size: 12.5),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 70,
                                    child: TextField(
                                      controller: _receiveCtrls[item.id],
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.right,
                                      style: AppText.mono(size: 12.5),
                                      decoration: const InputDecoration(isDense: true, border: OutlineInputBorder()),
                                      onChanged: (_) => setState(() {}),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                        ],
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
                  PrimaryButton(label: _submitting ? 'Posting…' : 'Post receipt', onTap: _submitting ? null : () => _submit(productsById)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit(Map<String, Product> productsById) async {
    final po = _po;
    if (po == null || _items.isEmpty) {
      setState(() => _error = 'Pick a purchase order with items remaining to receive.');
      return;
    }
    final lines = <ReceiveLine>[];
    for (final item in _items) {
      final qty = int.tryParse(_receiveCtrls[item.id]!.text.trim()) ?? 0;
      final remaining = item.qty - item.receivedQty;
      if (qty > remaining) {
        setState(() => _error = 'Cannot receive more than the remaining quantity for ${productsById[item.productId]?.name ?? item.productId}.');
        return;
      }
      if (qty > 0) {
        lines.add(ReceiveLine(poItem: item, product: productsById[item.productId]!, qty: qty));
      }
    }
    if (lines.isEmpty) {
      setState(() => _error = 'Enter a quantity to receive on at least one line.');
      return;
    }

    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      final suppliersById = {for (final s in ref.read(suppliersProvider).valueOrNull ?? <Supplier>[]) s.id: s};
      final supplier = suppliersById[po.supplierId]!;
      await ref
          .read(purchasingRepositoryProvider)
          .postGoodsReceipt(
            date: DateTime.now(),
            po: po,
            supplier: supplier,
            lines: lines,
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
}
