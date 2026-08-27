import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/database/repositories/collections_repository.dart' show PaymentMethod, PaymentMethodLabel;
import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../core/utils/money.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/widgets/list_screen.dart';
import '../auth/auth_controller.dart';
import '../suppliers/suppliers_screen.dart';

final supplierPaymentsProvider = StreamProvider((ref) => ref.watch(purchasingRepositoryProvider).watchSupplierPayments());

class SupplierPaymentsScreen extends ConsumerWidget {
  const SupplierPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentsAsync = ref.watch(supplierPaymentsProvider);
    final suppliersAsync = ref.watch(suppliersProvider);

    return paymentsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load supplier payments: $e'),
      data: (payments) {
        final suppliersById = {for (final s in suppliersAsync.valueOrNull ?? <Supplier>[]) s.id: s};
        final rows = payments.map((p) {
          final supplier = suppliersById[p.supplierId];
          return RowSpec([
            Cell.text(p.voucherNo, mono: true, weight: FontWeight.w500),
            Cell.text(_fmtDate(p.date), mono: true, color: AppColors.mutedInk),
            Cell.text(supplier?.name ?? p.supplierId),
            Cell.text(PaymentMethod.values.byName(p.method).label),
            Cell.number(p.amountPaise.toIndianRupees(), weight: FontWeight.w600),
            p.unallocatedPaise > 0 ? pillCell(PillTone.warn, 'Part allocated') : pillCell(PillTone.posted, 'Posted'),
          ]);
        }).toList();

        final spec = TableSpec(
          title: 'Supplier Payments',
          subtitle: 'Outgoing payments and aging',
          devNote: 'features/purchasing · supplier_payments · accounts_payable',
          filters: const [FilterSpec('Status', 'All')],
          columns: const [
            ColumnSpec('VOUCHER'),
            ColumnSpec('DATE'),
            ColumnSpec('SUPPLIER'),
            ColumnSpec('METHOD'),
            ColumnSpec('AMOUNT', align: CellAlign.right),
            ColumnSpec('STATUS'),
          ],
          rows: rows,
          count: rows.isEmpty ? 'No payments yet' : '${rows.length} payment(s)',
          cta: 'New payment',
          onCta: () => showDialog(context: context, builder: (_) => const _NewPaymentDialog()),
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

class _NewPaymentDialog extends ConsumerStatefulWidget {
  const _NewPaymentDialog();

  @override
  ConsumerState<_NewPaymentDialog> createState() => _NewPaymentDialogState();
}

class _NewPaymentDialogState extends ConsumerState<_NewPaymentDialog> {
  Supplier? _supplier;
  final _amountCtrl = TextEditingController();
  final _referenceCtrl = TextEditingController();
  PaymentMethod _method = PaymentMethod.cash;
  List<GoodsReceipt> _openGrns = [];
  bool _loading = false;
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _amountCtrl.dispose();
    _referenceCtrl.dispose();
    super.dispose();
  }

  Future<void> _onSupplierChanged(Supplier? s) async {
    setState(() {
      _supplier = s;
      _openGrns = [];
      _loading = s != null;
    });
    if (s == null) return;
    final grns = await ref.read(purchasingRepositoryProvider).openGoodsReceiptsFor(s.id);
    if (!mounted) return;
    setState(() {
      _openGrns = grns;
      _loading = false;
    });
  }

  int get _amountPaise => rupeesToPaise(double.tryParse(_amountCtrl.text.trim()) ?? 0);

  ({List<({GoodsReceipt grn, int amountPaise})> lines, int unallocatedPaise}) get _preview =>
      ref.read(purchasingRepositoryProvider).autoAdjust(_openGrns, _amountPaise);

  @override
  Widget build(BuildContext context) {
    final suppliersAsync = ref.watch(suppliersProvider);
    final preview = _supplier != null && _amountPaise > 0 ? _preview : null;

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
              Text('New supplier payment', style: AppText.sans(size: 16, weight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text('Pays down the oldest open goods receipts first.', style: AppText.sans(size: 12, color: AppColors.mutedInk)),
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
                          onChanged: _onSupplierChanged,
                        ),
                      ),
                      const SizedBox(height: 12),
                      _label('AMOUNT PAID (₹)'),
                      const SizedBox(height: 5),
                      _textField(_amountCtrl, keyboardType: const TextInputType.numberWithOptions(decimal: true), onChanged: () => setState(() {})),
                      const SizedBox(height: 12),
                      _label('PAYMENT METHOD'),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          for (final m in PaymentMethod.values) ...[
                            _MethodChip(method: m, selected: _method == m, onTap: () => setState(() => _method = m)),
                            const SizedBox(width: 8),
                          ],
                        ],
                      ),
                      if (_method != PaymentMethod.cash) ...[
                        const SizedBox(height: 12),
                        _label(_method == PaymentMethod.cheque ? 'CHEQUE NUMBER' : 'DD NUMBER'),
                        const SizedBox(height: 5),
                        _textField(_referenceCtrl),
                      ],
                      if (_supplier != null) ...[
                        const SizedBox(height: 12),
                        if (_loading)
                          const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: LinearProgressIndicator())
                        else if (_openGrns.isEmpty)
                          Text('No open goods receipts for this supplier.', style: AppText.sans(size: 12.5, color: AppColors.mutedInk))
                        else
                          _OpenGrnsList(grns: _openGrns, preview: preview),
                      ],
                      if (preview != null && preview.unallocatedPaise > 0) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: AppColors.warnTint, borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            '${preview.unallocatedPaise.toIndianRupees(withSymbol: true)} will stay unallocated (payment exceeds what\'s owed).',
                            style: AppText.sans(size: 11.5, color: AppColors.warnText, height: 1.4),
                          ),
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
                  PrimaryButton(label: _submitting ? 'Saving…' : 'Record payment', onTap: _submitting ? null : _submit),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final supplier = _supplier;
    if (supplier == null || _amountPaise <= 0) {
      setState(() => _error = 'Pick a supplier and enter an amount greater than zero.');
      return;
    }
    final preview = _preview;
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref
          .read(purchasingRepositoryProvider)
          .recordSupplierPayment(
            date: DateTime.now(),
            supplier: supplier,
            method: _method,
            reference: _method == PaymentMethod.cash ? null : _referenceCtrl.text.trim(),
            amountPaise: _amountPaise,
            allocations: preview.lines,
            unallocatedPaise: preview.unallocatedPaise,
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

  Widget _textField(TextEditingController controller, {TextInputType? keyboardType, VoidCallback? onChanged}) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(color: AppColors.fieldFill, border: Border.all(color: AppColors.fieldBorder), borderRadius: BorderRadius.circular(7)),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: (_) => onChanged?.call(),
        style: AppText.sans(size: 13),
        decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: false),
      ),
    );
  }

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

class _OpenGrnsList extends StatelessWidget {
  const _OpenGrnsList({required this.grns, required this.preview});
  final List<GoodsReceipt> grns;
  final ({List<({GoodsReceipt grn, int amountPaise})> lines, int unallocatedPaise})? preview;

  @override
  Widget build(BuildContext context) {
    final allocatedByGrn = {for (final l in preview?.lines ?? const []) l.grn.id: l.amountPaise};
    return Container(
      decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          for (final grn in grns)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderFaint))),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(grn.grnNo, style: AppText.mono(size: 12, weight: FontWeight.w500)),
                        Text(_fmtDate(grn.date), style: AppText.sans(size: 10.5, color: AppColors.mutedFaint)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(grn.balancePaise.toIndianRupees(withSymbol: true), style: AppText.mono(size: 12)),
                      if (allocatedByGrn[grn.id] != null)
                        Text(
                          '→ ${allocatedByGrn[grn.id]!.toIndianRupees(withSymbol: true)}',
                          style: AppText.mono(size: 11, color: AppColors.successText, weight: FontWeight.w600),
                        ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _MethodChip extends StatelessWidget {
  const _MethodChip({required this.method, required this.selected, required this.onTap});
  final PaymentMethod method;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : AppColors.fieldFill,
          border: Border.all(color: selected ? AppColors.accent : AppColors.controlBorder),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Text(method.label, style: AppText.sans(size: 12.5, weight: FontWeight.w600, color: selected ? AppColors.white : AppColors.ink)),
      ),
    );
  }
}
