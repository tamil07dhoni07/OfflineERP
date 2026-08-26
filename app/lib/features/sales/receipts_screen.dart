import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/database/repositories/collections_repository.dart';
import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../core/utils/money.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/widgets/list_screen.dart';
import '../auth/auth_controller.dart';
import '../customers/customers_screen.dart';

final receiptsProvider = StreamProvider((ref) => ref.watch(collectionsRepositoryProvider).watchReceipts());

/// The Collections module: outstanding tracking + recording a payment
/// against one or more open invoices. `SalesInvoices.balancePaise` and
/// `.status` are updated live by [CollectionsRepository.recordCollection],
/// so every screen reading invoice balances (Customers, Dashboard, the
/// invoice list itself) reflects a collection the moment it posts.
class ReceiptsScreen extends ConsumerWidget {
  const ReceiptsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final receiptsAsync = ref.watch(receiptsProvider);
    final customersAsync = ref.watch(customersProvider);

    return receiptsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load receipts: $e'),
      data: (receipts) {
        final customersById = {for (final c in customersAsync.valueOrNull ?? <Customer>[]) c.id: c};
        final rows = receipts.map((r) {
          final customer = customersById[r.customerId];
          final unallocated = r.unallocatedPaise;
          return RowSpec([
            Cell.text(r.voucherNo, mono: true, weight: FontWeight.w500),
            Cell.text(_fmtDate(r.date), mono: true, color: AppColors.mutedInk),
            Cell.text(customer?.name ?? r.customerId),
            Cell.text(PaymentMethod.values.byName(r.method).label),
            Cell.text(r.reference ?? '—', mono: true, color: AppColors.mutedInk),
            Cell.number((r.amountPaise - unallocated).toIndianRupees()),
            Cell.number(unallocated.toIndianRupees(), color: unallocated > 0 ? AppColors.warnText : AppColors.mutedInk),
            unallocated > 0 ? pillCell(PillTone.warn, 'Part allocated') : pillCell(PillTone.posted, 'Posted'),
          ]);
        }).toList();

        final spec = TableSpec(
          title: 'Customer Receipts',
          subtitle: 'Money in, with allocation against open invoices',
          devNote: 'features/sales · receipts · receipt_allocations',
          filters: const [FilterSpec('Method', 'All'), FilterSpec('Period', 'All time')],
          columns: const [
            ColumnSpec('VOUCHER'),
            ColumnSpec('DATE'),
            ColumnSpec('CUSTOMER'),
            ColumnSpec('METHOD'),
            ColumnSpec('REFERENCE'),
            ColumnSpec('ALLOCATED', align: CellAlign.right),
            ColumnSpec('UNALLOCATED', align: CellAlign.right),
            ColumnSpec('STATUS'),
          ],
          rows: rows,
          count: rows.isEmpty ? 'No receipts yet' : '${rows.length} receipt(s)',
          cta: 'Record receipt',
          onCta: () => showDialog(context: context, builder: (_) => const _RecordCollectionDialog()),
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

class _RecordCollectionDialog extends ConsumerStatefulWidget {
  const _RecordCollectionDialog();

  @override
  ConsumerState<_RecordCollectionDialog> createState() => _RecordCollectionDialogState();
}

class _RecordCollectionDialogState extends ConsumerState<_RecordCollectionDialog> {
  Customer? _customer;
  final _amountCtrl = TextEditingController();
  final _referenceCtrl = TextEditingController();
  PaymentMethod _method = PaymentMethod.cash;
  bool _autoAdjust = true;
  final Set<String> _manualSelection = {};
  List<SalesInvoice> _openInvoices = [];
  bool _loadingInvoices = false;
  bool _submitting = false;
  String? _error;

  @override
  void dispose() {
    _amountCtrl.dispose();
    _referenceCtrl.dispose();
    super.dispose();
  }

  Future<void> _onCustomerChanged(Customer? c) async {
    setState(() {
      _customer = c;
      _openInvoices = [];
      _manualSelection.clear();
      _loadingInvoices = c != null;
    });
    if (c == null) return;
    final invoices = await ref.read(collectionsRepositoryProvider).openInvoicesFor(c.id);
    if (!mounted) return;
    setState(() {
      _openInvoices = invoices;
      _manualSelection.addAll(invoices.map((i) => i.id));
      _loadingInvoices = false;
    });
  }

  int get _amountPaise => rupeesToPaise(double.tryParse(_amountCtrl.text.trim()) ?? 0);

  ({List<AllocationLine> lines, int unallocatedPaise}) get _preview {
    final eligible = _autoAdjust ? _openInvoices : _openInvoices.where((i) => _manualSelection.contains(i.id)).toList();
    return ref.read(collectionsRepositoryProvider).autoAdjust(eligible, _amountPaise);
  }

  Future<void> _submit() async {
    final customer = _customer;
    if (customer == null || _amountPaise <= 0) {
      setState(() => _error = 'Pick a customer and enter an amount greater than zero.');
      return;
    }
    final preview = _preview;
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      final user = ref.read(authControllerProvider);
      await ref
          .read(collectionsRepositoryProvider)
          .recordCollection(
            date: DateTime.now(),
            customer: customer,
            method: _method,
            reference: _method == PaymentMethod.cash ? null : _referenceCtrl.text.trim(),
            amountPaise: _amountPaise,
            allocations: preview.lines,
            unallocatedPaise: preview.unallocatedPaise,
            actor: user?.username ?? 'unknown',
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

  @override
  Widget build(BuildContext context) {
    final customersAsync = ref.watch(customersProvider);
    final preview = _customer != null && _amountPaise > 0 ? _preview : null;

    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480, maxHeight: 640),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Record receipt', style: AppText.sans(size: 16, weight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(
                'Collect an amount from a customer and settle it against open invoices.',
                style: AppText.sans(size: 12, color: AppColors.mutedInk),
              ),
              const SizedBox(height: 16),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FieldLabel('CUSTOMER'),
                      const SizedBox(height: 5),
                      customersAsync.when(
                        loading: () => const LinearProgressIndicator(),
                        error: (e, st) => Text('$e'),
                        data: (customers) => _Dropdown<Customer>(
                          value: _customer,
                          items: customers,
                          labelOf: (c) => '${c.code} · ${c.name}',
                          onChanged: _onCustomerChanged,
                          hint: 'Select customer',
                        ),
                      ),
                      const SizedBox(height: 12),
                      _FieldLabel('AMOUNT COLLECTED (₹)'),
                      const SizedBox(height: 5),
                      _TextField(controller: _amountCtrl, keyboardType: const TextInputType.numberWithOptions(decimal: true), onChanged: () => setState(() {})),
                      const SizedBox(height: 12),
                      _FieldLabel('PAYMENT METHOD'),
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
                        _FieldLabel(_method == PaymentMethod.cheque ? 'CHEQUE NUMBER' : 'DD NUMBER'),
                        const SizedBox(height: 5),
                        _TextField(controller: _referenceCtrl),
                      ],
                      const SizedBox(height: 14),
                      Row(
                        children: [
                          Switch(
                            value: _autoAdjust,
                            activeTrackColor: AppColors.accent,
                            onChanged: (v) => setState(() => _autoAdjust = v),
                          ),
                          Expanded(
                            child: Text(
                              _autoAdjust
                                  ? 'Auto-adjust: settles the oldest open invoices first'
                                  : 'Manual: only the invoices you check below are settled',
                              style: AppText.sans(size: 12, color: AppColors.mutedInk),
                            ),
                          ),
                        ],
                      ),
                      if (_customer != null) ...[
                        const SizedBox(height: 8),
                        if (_loadingInvoices)
                          const Padding(padding: EdgeInsets.symmetric(vertical: 12), child: LinearProgressIndicator())
                        else if (_openInvoices.isEmpty)
                          Text('No open invoices for this customer.', style: AppText.sans(size: 12.5, color: AppColors.mutedInk))
                        else
                          _OpenInvoicesList(
                            invoices: _openInvoices,
                            autoAdjust: _autoAdjust,
                            selection: _manualSelection,
                            preview: preview,
                            onToggle: (id) => setState(
                              () => _manualSelection.contains(id) ? _manualSelection.remove(id) : _manualSelection.add(id),
                            ),
                          ),
                      ],
                      if (preview != null && preview.unallocatedPaise > 0) ...[
                        const SizedBox(height: 10),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(color: AppColors.warnTint, borderRadius: BorderRadius.circular(8)),
                          child: Text(
                            '${preview.unallocatedPaise.toIndianRupees(withSymbol: true)} will stay unallocated on this receipt (payment exceeds the selected invoices\' balance).',
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
                  PrimaryButton(label: _submitting ? 'Saving…' : 'Record receipt', onTap: _submitting ? null : _submit),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OpenInvoicesList extends StatelessWidget {
  const _OpenInvoicesList({
    required this.invoices,
    required this.autoAdjust,
    required this.selection,
    required this.preview,
    required this.onToggle,
  });

  final List<SalesInvoice> invoices;
  final bool autoAdjust;
  final Set<String> selection;
  final ({List<AllocationLine> lines, int unallocatedPaise})? preview;
  final void Function(String invoiceId) onToggle;

  @override
  Widget build(BuildContext context) {
    final allocatedByInvoice = {for (final l in preview?.lines ?? const <AllocationLine>[]) l.invoice.id: l.amountPaise};
    return Container(
      decoration: BoxDecoration(border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          for (final invoice in invoices)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderFaint))),
              child: Row(
                children: [
                  if (!autoAdjust)
                    Checkbox(
                      value: selection.contains(invoice.id),
                      activeColor: AppColors.accent,
                      onChanged: (_) => onToggle(invoice.id),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(invoice.invoiceNo, style: AppText.mono(size: 12, weight: FontWeight.w500)),
                        Text(_fmtDate(invoice.date), style: AppText.sans(size: 10.5, color: AppColors.mutedFaint)),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(invoice.balancePaise.toIndianRupees(withSymbol: true), style: AppText.mono(size: 12)),
                      if (allocatedByInvoice[invoice.id] != null)
                        Text(
                          '→ ${allocatedByInvoice[invoice.id]!.toIndianRupees(withSymbol: true)}',
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
        child: Text(
          method.label,
          style: AppText.sans(size: 12.5, weight: FontWeight.w600, color: selected ? AppColors.white : AppColors.ink),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5));
  }
}

class _TextField extends StatelessWidget {
  const _TextField({required this.controller, this.keyboardType, this.onChanged});
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final VoidCallback? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        border: Border.all(color: AppColors.fieldBorder),
        borderRadius: BorderRadius.circular(7),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        onChanged: (_) => onChanged?.call(),
        style: AppText.sans(size: 13),
        decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: false),
      ),
    );
  }
}

class _Dropdown<T> extends StatelessWidget {
  const _Dropdown({required this.value, required this.items, required this.labelOf, required this.onChanged, required this.hint});
  final T? value;
  final List<T> items;
  final String Function(T) labelOf;
  final void Function(T?) onChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        border: Border.all(color: AppColors.fieldBorder),
        borderRadius: BorderRadius.circular(7),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          isExpanded: true,
          value: value,
          hint: Text(hint, style: AppText.sans(size: 13, color: AppColors.mutedFaint)),
          items: [for (final item in items) DropdownMenuItem(value: item, child: Text(labelOf(item), style: AppText.sans(size: 13)))],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
