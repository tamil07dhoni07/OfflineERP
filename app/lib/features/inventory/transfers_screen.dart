import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/widgets/list_screen.dart';
import '../auth/auth_controller.dart';
import '../products/products_screen.dart';

final transfersProvider = StreamProvider((ref) => ref.watch(inventoryRepositoryProvider).watchTransfers());
final warehousesListProvider = FutureProvider((ref) => ref.watch(masterDataRepositoryProvider).allWarehouses());

class TransfersScreen extends ConsumerWidget {
  const TransfersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transfersAsync = ref.watch(transfersProvider);
    final warehousesAsync = ref.watch(warehousesListProvider);

    return transfersAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load transfers: $e'),
      data: (transfers) {
        final whById = {for (final w in warehousesAsync.valueOrNull ?? <Warehouse>[]) w.id: w};
        final rows = transfers
            .map(
              (t) => RowSpec(
                [
                  Cell.text(t.transferNo, mono: true, weight: FontWeight.w500),
                  Cell.text(_fmtDate(t.date), mono: true, color: AppColors.mutedInk),
                  Cell.text(whById[t.fromWarehouseId]?.name ?? t.fromWarehouseId),
                  Cell.text(whById[t.toWarehouseId]?.name ?? t.toWarehouseId),
                  t.status == 'reversed' ? pillCell(PillTone.late, 'Reversed') : pillCell(PillTone.paid, 'Completed'),
                ],
                onTap: () => showDialog(context: context, builder: (_) => _TransferDetailDialog(transfer: t)),
                onEdit: () => showDialog(context: context, builder: (_) => _TransferDetailDialog(transfer: t)),
                onDelete: t.status == 'reversed'
                    ? null
                    : () => ref.read(inventoryRepositoryProvider).reverseTransfer(
                        t.id,
                        actor: ref.read(authControllerProvider)?.username ?? 'unknown',
                        device: currentDeviceId,
                      ),
                deleteTooltip: 'Reverse',
                deleteConfirmTitle: 'Reverse this transfer?',
                deleteConfirmMessage: 'Posts equal and opposite movements for ${t.transferNo} — stock moves back to ${whById[t.fromWarehouseId]?.name ?? t.fromWarehouseId}.',
              ),
            )
            .toList();

        final spec = TableSpec(
          title: 'Stock Transfers',
          subtitle: 'Movements between warehouses · tap a row for details',
          devNote: 'features/inventory · stock_transfers · paired OUT/IN movements',
          filters: const [FilterSpec('Status', 'All'), FilterSpec('From', 'Any'), FilterSpec('To', 'Any')],
          columns: const [
            ColumnSpec('TRANSFER'),
            ColumnSpec('DATE'),
            ColumnSpec('FROM'),
            ColumnSpec('TO'),
            ColumnSpec('STATUS'),
          ],
          rows: rows,
          count: '${rows.length} transfer(s) · queried live from Drift',
          cta: 'New transfer',
          onCta: () => showDialog(context: context, builder: (_) => const _NewTransferDialog()),
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

class _TransferDetailDialog extends ConsumerWidget {
  const _TransferDetailDialog({required this.transfer});
  final StockTransfer transfer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productsById = {for (final p in ref.watch(productsProvider).valueOrNull ?? <Product>[]) p.id: p};
    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420, maxHeight: 500),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transfer.transferNo, style: AppText.mono(size: 16, weight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(_fmtDate(transfer.date), style: AppText.sans(size: 12, color: AppColors.mutedInk)),
              const SizedBox(height: 16),
              Flexible(
                child: SingleChildScrollView(
                  child: FutureBuilder<List<StockTransferItem>>(
                    future: ref.read(inventoryRepositoryProvider).itemsForTransfer(transfer.id),
                    builder: (context, snap) {
                      if (!snap.hasData) return const Padding(padding: EdgeInsets.all(12), child: LinearProgressIndicator());
                      return Column(
                        children: [
                          for (final item in snap.data!)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Row(
                                children: [
                                  Expanded(child: Text(productsById[item.productId]?.name ?? item.productId, style: AppText.sans(size: 12.5))),
                                  Text('${item.qty}', style: AppText.mono(size: 12.5)),
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
                  if (transfer.status != 'reversed')
                    TextButton(
                      onPressed: () async {
                        await ref
                            .read(inventoryRepositoryProvider)
                            .reverseTransfer(transfer.id, actor: ref.read(authControllerProvider)?.username ?? 'unknown', device: currentDeviceId);
                        if (context.mounted) Navigator.of(context).pop();
                      },
                      child: const Text('Reverse transfer', style: TextStyle(color: AppColors.danger)),
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

class _NewTransferDialog extends ConsumerStatefulWidget {
  const _NewTransferDialog();

  @override
  ConsumerState<_NewTransferDialog> createState() => _NewTransferDialogState();
}

class _NewTransferDialogState extends ConsumerState<_NewTransferDialog> {
  Warehouse? _from;
  Warehouse? _to;
  final List<({Product product, int qty})> _lines = [];
  bool _submitting = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    final warehousesAsync = ref.watch(warehousesListProvider);
    final productsAsync = ref.watch(productsProvider);

    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 440, maxHeight: 600),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('New stock transfer', style: AppText.sans(size: 16, weight: FontWeight.w600)),
              const SizedBox(height: 16),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      warehousesAsync.when(
                        loading: () => const LinearProgressIndicator(),
                        error: (e, st) => Text('$e'),
                        data: (warehouses) => Row(
                          children: [
                            Expanded(
                              child: _labeledDropdown('FROM', _from, warehouses, (w) => w.name, (w) => setState(() => _from = w)),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _labeledDropdown('TO', _to, warehouses, (w) => w.name, (w) => setState(() => _to = w)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Text('LINE ITEMS', style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
                          const Spacer(),
                          productsAsync.maybeWhen(
                            data: (products) => TextButton(
                              onPressed: products.isEmpty
                                  ? null
                                  : () async {
                                      final line = await showDialog<({Product product, int qty})>(
                                        context: context,
                                        builder: (_) => _AddTransferLineDialog(products: products),
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
                              IconButton(icon: const Icon(Icons.close, size: 16), onPressed: () => setState(() => _lines.removeAt(i))),
                            ],
                          ),
                        ),
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
                  PrimaryButton(label: _submitting ? 'Transferring…' : 'Transfer stock', onTap: _submitting ? null : _submit),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_from == null || _to == null || _lines.isEmpty) {
      setState(() => _error = 'Pick both warehouses and add at least one line.');
      return;
    }
    if (_from!.id == _to!.id) {
      setState(() => _error = 'Source and destination must be different.');
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref
          .read(inventoryRepositoryProvider)
          .createTransfer(
            date: DateTime.now(),
            from: _from!,
            to: _to!,
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

  Widget _labeledDropdown<T>(String label, T? value, List<T> items, String Function(T) labelOf, void Function(T?) onChanged) {
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
}

class _AddTransferLineDialog extends StatefulWidget {
  const _AddTransferLineDialog({required this.products});
  final List<Product> products;

  @override
  State<_AddTransferLineDialog> createState() => _AddTransferLineDialogState();
}

class _AddTransferLineDialogState extends State<_AddTransferLineDialog> {
  late Product _product = widget.products.first;
  final _qty = TextEditingController(text: '1');

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 340),
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
                    items: [for (final p in widget.products) DropdownMenuItem(value: p, child: Text('${p.sku} · ${p.name}', style: AppText.sans(size: 13)))],
                    onChanged: (p) => setState(() => _product = p!),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(color: AppColors.fieldFill, border: Border.all(color: AppColors.fieldBorder), borderRadius: BorderRadius.circular(7)),
                child: TextField(
                  controller: _qty,
                  keyboardType: TextInputType.number,
                  style: AppText.sans(size: 13),
                  decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: false, hintText: 'Quantity'),
                ),
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
                      if (qty <= 0) return;
                      Navigator.of(context).pop((product: _product, qty: qty));
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
}
