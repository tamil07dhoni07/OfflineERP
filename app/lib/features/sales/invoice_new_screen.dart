import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../core/database/app_database.dart';
import '../../core/database/repositories/sales_repository.dart';
import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../core/utils/money.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/widgets/cards.dart';
import '../auth/auth_controller.dart';
import '../customers/customers_screen.dart';
import '../products/products_screen.dart';

class InvoiceNewScreen extends ConsumerStatefulWidget {
  const InvoiceNewScreen({super.key});

  @override
  ConsumerState<InvoiceNewScreen> createState() => _InvoiceNewScreenState();
}

class _InvoiceNewScreenState extends ConsumerState<InvoiceNewScreen> {
  Customer? _customer;
  Warehouse? _warehouse;
  String _paymentTerms = 'Net 30';
  String _salesperson = 'Arun Patil';
  final List<DraftInvoiceLine> _lines = [];
  bool _submitting = false;
  String? _error;

  String? _editingId;
  bool _editingIdResolved = false;
  bool _hydrating = false;
  bool _hydrated = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_editingIdResolved) {
      _editingIdResolved = true;
      final id = GoRouterState.of(context).uri.queryParameters['id'];
      _editingId = (id == null || id.isEmpty) ? null : id;
    }
  }

  @override
  Widget build(BuildContext context) {
    final companyAsync = ref.watch(companyProvider);
    final customersAsync = ref.watch(customersProvider);
    final productsAsync = ref.watch(productsProvider);
    final warehousesAsync = ref.watch(warehousesProvider);

    if (!companyAsync.hasValue || !customersAsync.hasValue || !productsAsync.hasValue || !warehousesAsync.hasValue) {
      return const Center(child: CircularProgressIndicator());
    }

    final company = companyAsync.value!;
    final customers = customersAsync.value!;
    final products = productsAsync.value!.where((p) => p.active).toList();
    final warehouses = warehousesAsync.value!;

    if (_editingId != null && !_hydrated) {
      if (!_hydrating) {
        _hydrating = true;
        WidgetsBinding.instance.addPostFrameCallback((_) => _hydrate(_editingId!, customers, warehouses, products));
      }
      return const Center(child: CircularProgressIndicator());
    }

    _customer ??= customers.isEmpty ? null : customers.first;
    _warehouse ??= warehouses.isEmpty ? null : warehouses.first;

    final interState = _customer != null && _customer!.stateCode != company.stateCode;
    final sales = ref.read(salesRepositoryProvider);
    final totals = sales.computeTotals(_lines, interState: interState);
    final cogsPaise = _lines.fold<int>(0, (a, l) => a + l.qty * l.product.purchasePricePaise);
    final outstanding = ref.watch(outstandingByCustomerProvider).valueOrNull ?? {};
    final currentOutstanding = _customer == null ? 0 : (outstanding[_customer!.id] ?? 0);
    final afterInvoice = currentOutstanding + totals.totalPaise;
    final creditLimit = _customer?.creditLimitPaise ?? 0;
    final overLimit = creditLimit > 0 && afterInvoice > creditLimit;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1320),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => context.go('/invoices'),
                child: Text('← Sales Invoices', style: AppText.sans(size: 12.5, weight: FontWeight.w500, color: AppColors.accent)),
              ),
              const Spacer(),
              SecondaryButton(
                label: _submitting ? 'Saving…' : 'Save draft',
                onTap: _submitting || _lines.isEmpty ? null : () => _submit(asDraft: true, company: company),
              ),
              const SizedBox(width: 8),
              PrimaryButton(
                label: _submitting ? 'Posting…' : 'Post invoice',
                onTap: _submitting || _lines.isEmpty || _customer == null || _warehouse == null
                    ? null
                    : () => _submit(asDraft: false, company: company),
              ),
            ],
          ),
          if (_error != null) ...[
            const SizedBox(height: 8),
            Text(_error!, style: AppText.sans(size: 12.5, color: AppColors.danger)),
          ],
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 900;
              final left = _LeftColumn(
                company: company,
                customers: customers,
                products: products,
                warehouses: warehouses,
                interState: interState,
                lines: _lines,
                cogsPaise: cogsPaise,
                totals: totals,
                customer: _customer,
                warehouse: _warehouse,
                paymentTerms: _paymentTerms,
                salesperson: _salesperson,
                onCustomerChanged: (c) => setState(() => _customer = c),
                onWarehouseChanged: (w) => setState(() => _warehouse = w),
                onAddLine: _addLine,
                onRemoveLine: (i) => setState(() => _lines.removeAt(i)),
              );
              final right = _RightColumn(
                totals: totals,
                interState: interState,
                customer: _customer,
                currentOutstanding: currentOutstanding,
                afterInvoice: afterInvoice,
                overLimit: overLimit,
                warehouse: _warehouse,
              );
              if (!wide) {
                return Column(children: [left, const SizedBox(height: 12), right]);
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: left),
                  const SizedBox(width: 12),
                  SizedBox(width: 352, child: right),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _addLine(List<Product> products) async {
    if (products.isEmpty) return;
    final result = await showDialog<DraftInvoiceLine>(
      context: context,
      builder: (context) => _AddLineDialog(products: products),
    );
    if (result != null) setState(() => _lines.add(result));
  }

  Future<void> _hydrate(String id, List<Customer> customers, List<Warehouse> warehouses, List<Product> products) async {
    final sales = ref.read(salesRepositoryProvider);
    final invoice = await sales.invoiceById(id);
    if (invoice == null || invoice.status != 'draft') {
      if (mounted) {
        setState(() {
          _error = 'This invoice can no longer be edited here — only drafts can be opened for editing.';
          _hydrated = true;
        });
      }
      return;
    }
    final items = await sales.itemsFor(id);
    final productsById = {for (final p in products) p.id: p};
    final lines = [
      for (final item in items)
        if (productsById[item.productId] != null)
          DraftInvoiceLine(
            product: productsById[item.productId]!,
            qty: item.qty,
            ratePaise: item.ratePaise,
            discountPct: item.discountPct,
          ),
    ];
    Customer? matchedCustomer;
    for (final c in customers) {
      if (c.id == invoice.customerId) matchedCustomer = c;
    }
    Warehouse? matchedWarehouse;
    for (final w in warehouses) {
      if (w.id == invoice.warehouseId) matchedWarehouse = w;
    }
    if (!mounted) return;
    setState(() {
      _customer = matchedCustomer;
      _warehouse = matchedWarehouse;
      _paymentTerms = invoice.paymentTerms;
      _salesperson = invoice.salesperson;
      _lines
        ..clear()
        ..addAll(lines);
      _hydrated = true;
    });
  }

  Future<void> _submit({required bool asDraft, required Company company}) async {
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      final sales = ref.read(salesRepositoryProvider);
      final interState = _customer!.stateCode != company.stateCode;
      final actor = ref.read(authControllerProvider)?.username ?? 'unknown';
      final editingId = _editingId;
      if (editingId != null) {
        await sales.updateDraftInvoice(
          invoiceId: editingId,
          date: DateTime.now(),
          customer: _customer!,
          warehouseId: _warehouse!.id,
          placeOfSupplyState: _customer!.state,
          placeOfSupplyCode: _customer!.stateCode,
          paymentTerms: _paymentTerms,
          salesperson: _salesperson,
          lines: _lines,
          interState: interState,
          actor: actor,
          device: currentDeviceId,
        );
        if (!asDraft) {
          await sales.postExistingDraft(editingId, actor: actor, device: currentDeviceId);
        }
      } else {
        final invoiceNo = await sales.nextInvoiceNumber('26-27');
        await sales.postInvoice(
          invoiceNo: invoiceNo,
          date: DateTime.now(),
          customer: _customer!,
          warehouseId: _warehouse!.id,
          placeOfSupplyState: _customer!.state,
          placeOfSupplyCode: _customer!.stateCode,
          paymentTerms: _paymentTerms,
          salesperson: _salesperson,
          lines: _lines,
          interState: interState,
          actor: actor,
          device: currentDeviceId,
          asDraft: asDraft,
        );
      }
      if (mounted) context.go('/invoices');
    } catch (e) {
      setState(() => _error = 'Could not save invoice: $e');
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }
}

class _LeftColumn extends StatelessWidget {
  const _LeftColumn({
    required this.company,
    required this.customers,
    required this.products,
    required this.warehouses,
    required this.interState,
    required this.lines,
    required this.cogsPaise,
    required this.totals,
    required this.customer,
    required this.warehouse,
    required this.paymentTerms,
    required this.salesperson,
    required this.onCustomerChanged,
    required this.onWarehouseChanged,
    required this.onAddLine,
    required this.onRemoveLine,
  });

  final Company company;
  final List<Customer> customers;
  final List<Product> products;
  final List<Warehouse> warehouses;
  final bool interState;
  final List<DraftInvoiceLine> lines;
  final int cogsPaise;
  final PostedInvoiceTotals totals;
  final Customer? customer;
  final Warehouse? warehouse;
  final String paymentTerms;
  final String salesperson;
  final ValueChanged<Customer?> onCustomerChanged;
  final ValueChanged<Warehouse?> onWarehouseChanged;
  final void Function(List<Product>) onAddLine;
  final ValueChanged<int> onRemoveLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionCard(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            spacing: 13,
            runSpacing: 13,
            children: [
              _FieldTile(label: 'INVOICE DATE', child: Text(DateFormat('d MMM yyyy').format(DateTime.now()), style: AppText.mono(size: 12.5))),
              _FieldTile(
                label: 'CUSTOMER',
                child: DropdownButton<Customer>(
                  value: customer,
                  isDense: true,
                  underline: const SizedBox.shrink(),
                  items: [for (final c in customers) DropdownMenuItem(value: c, child: Text(c.name, style: AppText.sans(size: 12.5)))],
                  onChanged: onCustomerChanged,
                ),
              ),
              _FieldTile(label: 'GSTIN', child: Text(customer?.gstin ?? '—', style: AppText.mono(size: 12.5))),
              _FieldTile(
                label: 'PLACE OF SUPPLY',
                child: Text(customer == null ? '—' : '${customer!.state} (${customer!.stateCode})', style: AppText.sans(size: 12.5)),
              ),
              _FieldTile(label: 'PAYMENT TERMS', child: Text(paymentTerms, style: AppText.sans(size: 12.5))),
              _FieldTile(
                label: 'WAREHOUSE',
                child: DropdownButton<Warehouse>(
                  value: warehouse,
                  isDense: true,
                  underline: const SizedBox.shrink(),
                  items: [for (final w in warehouses) DropdownMenuItem(value: w, child: Text(w.name, style: AppText.sans(size: 12.5)))],
                  onChanged: onWarehouseChanged,
                ),
              ),
              _FieldTile(label: 'SALESPERSON', child: Text(salesperson, style: AppText.sans(size: 12.5))),
              _FieldTile(
                label: 'TAX REGIME',
                child: Text(
                  interState ? 'Inter-state · IGST' : 'Intra-state · CGST + SGST',
                  style: AppText.sans(size: 12.5, color: AppColors.accent, weight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SectionCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              const SectionHeader(title: 'Line items', trailing: 'sales_invoice_items · stock reserved on post'),
              if (lines.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text('No lines yet — add a product below.', style: AppText.sans(size: 12.5, color: AppColors.mutedSoft)),
                )
              else
                Table(
                  columnWidths: const {0: FixedColumnWidth(28)},
                  children: [
                    TableRow(
                      decoration: const BoxDecoration(color: AppColors.fieldFill),
                      children: [
                        _th(''),
                        _th('SKU'),
                        _th('DESCRIPTION'),
                        _th('QTY', right: true),
                        _th('RATE', right: true),
                        _th('DISC %', right: true),
                        _th('GST %', right: true),
                        _th('AMOUNT', right: true),
                      ],
                    ),
                    for (var i = 0; i < lines.length; i++)
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              iconSize: 16,
                              icon: const Icon(Icons.close, color: AppColors.danger),
                              onPressed: () => onRemoveLine(i),
                            ),
                          ),
                          _td(lines[i].product.sku, mono: true),
                          _td(lines[i].product.name),
                          _td('${lines[i].qty}', right: true, mono: true),
                          _td(lines[i].ratePaise.toIndianRupees(), right: true, mono: true),
                          _td(lines[i].discountPct.toStringAsFixed(1), right: true, mono: true),
                          _td(lines[i].product.gstRate.toStringAsFixed(0), right: true, mono: true),
                          _td(lines[i].amountPaise.toIndianRupees(), right: true, mono: true, weight: FontWeight.w600),
                        ],
                      ),
                  ],
                ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.borderSoft)), color: AppColors.fieldFill),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => onAddLine(products),
                    child: Container(
                      height: 27,
                      padding: const EdgeInsets.symmetric(horizontal: 11),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.dashedBorder),
                        borderRadius: BorderRadius.circular(6),
                        color: AppColors.card,
                      ),
                      alignment: Alignment.center,
                      child: Text('+ Add line', style: AppText.sans(size: 11.5, color: AppColors.mutedInk)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SectionCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              const SectionHeader(title: 'Posting preview', trailing: 'single transaction · all-or-nothing'),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _journalRow('Dr', '1200 · Accounts Receivable', customer?.name ?? '—', totals.totalPaise, isDebit: true),
                    _journalRow('Cr', '4000 · Sales — Trading Goods', 'revenue', totals.taxableValuePaise, isDebit: false),
                    if (totals.cgstPaise > 0) _journalRow('Cr', '2210 · Output CGST', '', totals.cgstPaise, isDebit: false),
                    if (totals.sgstPaise > 0) _journalRow('Cr', '2211 · Output SGST', '', totals.sgstPaise, isDebit: false),
                    if (totals.igstPaise > 0) _journalRow('Cr', '2212 · Output IGST', '', totals.igstPaise, isDebit: false),
                    _journalRow('Dr', '5000 · Cost of Goods Sold', 'moving average', cogsPaise, isDebit: true),
                    _journalRow('Cr', '1400 · Inventory — Trading Goods', '${lines.length} movements OUT', cogsPaise, isDebit: false),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 11),
                decoration: const BoxDecoration(color: AppColors.fieldFill, border: Border(top: BorderSide(color: AppColors.border))),
                child: Text(
                  'Invoice, items, stock movement, customer balance and journal are written in one database transaction. If any step fails, nothing is committed.',
                  style: AppText.sans(size: 11.5, color: AppColors.mutedInk, height: 1.55),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _th(String label, {bool right = false}) => Container(
    height: 34,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    alignment: right ? Alignment.centerRight : Alignment.centerLeft,
    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
    child: Text(label, style: AppText.sans(size: 10.5, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
  );

  static Widget _td(String text, {bool right = false, bool mono = false, FontWeight weight = FontWeight.w400}) => Container(
    height: 40,
    padding: const EdgeInsets.symmetric(horizontal: 12),
    alignment: right ? Alignment.centerRight : Alignment.centerLeft,
    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderFaint))),
    child: Text(text, style: mono ? AppText.mono(size: 12.5, weight: weight) : AppText.sans(size: 12.5, weight: weight)),
  );

  static Widget _journalRow(String dc, String account, String particulars, int paise, {required bool isDebit}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(width: 24, child: Text(dc, style: AppText.mono(size: 12, color: AppColors.mutedInk))),
          Expanded(flex: 3, child: Text(account, style: AppText.sans(size: 12.5, weight: isDebit ? FontWeight.w400 : FontWeight.w500))),
          Expanded(flex: 2, child: Text(particulars, style: AppText.sans(size: 12, color: AppColors.mutedInk))),
          Text(paise.toIndianRupees(), style: AppText.mono(size: 12.5, weight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _FieldTile extends StatelessWidget {
  const _FieldTile({required this.label, required this.child});
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppText.sans(size: 10.5, weight: FontWeight.w600, color: AppColors.mutedSoft, letterSpacing: 0.6)),
          const SizedBox(height: 5),
          Container(
            height: 34,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(color: AppColors.fieldFill, border: Border.all(color: AppColors.fieldBorder), borderRadius: BorderRadius.circular(7)),
            alignment: Alignment.centerLeft,
            child: child,
          ),
        ],
      ),
    );
  }
}

class _RightColumn extends StatelessWidget {
  const _RightColumn({
    required this.totals,
    required this.interState,
    required this.customer,
    required this.currentOutstanding,
    required this.afterInvoice,
    required this.overLimit,
    required this.warehouse,
  });

  final PostedInvoiceTotals totals;
  final bool interState;
  final Customer? customer;
  final int currentOutstanding;
  final int afterInvoice;
  final bool overLimit;
  final Warehouse? warehouse;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Totals', style: AppText.sans(size: 13, weight: FontWeight.w600)),
              const SizedBox(height: 10),
              _totalRow('Taxable value', totals.taxableValuePaise),
              if (interState)
                _totalRow('IGST', totals.igstPaise)
              else ...[
                _totalRow('CGST', totals.cgstPaise),
                _totalRow('SGST', totals.sgstPaise),
              ],
              Container(height: 1, color: AppColors.borderSoft, margin: const EdgeInsets.symmetric(vertical: 6)),
              _totalRow('Invoice total', totals.totalPaise, big: true),
              const SizedBox(height: 10),
              Text(
                interState
                    ? 'Place of supply differs from the company state, so a single IGST head applies.'
                    : 'Place of supply matches the company state, so tax splits into CGST and SGST at half the slab rate each.',
                style: AppText.sans(size: 11.5, color: AppColors.mutedSoft, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Customer', style: AppText.sans(size: 13, weight: FontWeight.w600)),
              const SizedBox(height: 9),
              Text(customer?.name ?? '—', style: AppText.sans(size: 13, weight: FontWeight.w600, letterSpacing: -0.2)),
              const SizedBox(height: 9),
              _metaRow('Credit limit', (customer?.creditLimitPaise ?? 0).toIndianRupees(withSymbol: true)),
              _metaRow('Outstanding', currentOutstanding.toIndianRupees(withSymbol: true)),
              _metaRow('After this invoice', afterInvoice.toIndianRupees(withSymbol: true), color: overLimit ? AppColors.danger : AppColors.warnText),
              if (overLimit) ...[
                const SizedBox(height: 9),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
                  decoration: BoxDecoration(color: AppColors.dangerTint, borderRadius: BorderRadius.circular(7)),
                  child: Text(
                    'This invoice exceeds the customer\'s credit limit.',
                    style: AppText.sans(size: 11.5, color: AppColors.danger, height: 1.5),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 12),
        SectionCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Fulfilment', style: AppText.sans(size: 13, weight: FontWeight.w600)),
              const SizedBox(height: 9),
              _metaRow('Warehouse', warehouse?.name ?? '—'),
              const _MetaRowStatic('Stock check', 'checked on post', AppColors.mutedFaint),
              const _MetaRowStatic('Print template', 'GST Tax Invoice A4', AppColors.mutedFaint),
            ],
          ),
        ),
      ],
    );
  }

  static Widget _totalRow(String label, int paise, {bool big = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(label, style: AppText.sans(size: big ? 15 : 12.5, weight: big ? FontWeight.w600 : FontWeight.w400, color: big ? AppColors.ink : AppColors.mutedInk)),
          const Spacer(),
          Text(paise.toIndianRupees(withSymbol: big), style: AppText.mono(size: big ? 15 : 12.5, weight: big ? FontWeight.w600 : FontWeight.w400)),
        ],
      ),
    );
  }

  static Widget _metaRow(String label, String value, {Color color = AppColors.ink}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(label, style: AppText.sans(size: 12, color: AppColors.mutedSoft)),
          const Spacer(),
          Text(value, style: AppText.mono(size: 12, color: color)),
        ],
      ),
    );
  }
}

class _MetaRowStatic extends StatelessWidget {
  const _MetaRowStatic(this.label, this.value, this.color);
  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(label, style: AppText.sans(size: 12, color: AppColors.mutedSoft)),
          const Spacer(),
          Text(value, style: AppText.mono(size: 12, color: color)),
        ],
      ),
    );
  }
}

class _AddLineDialog extends StatefulWidget {
  const _AddLineDialog({required this.products});
  final List<Product> products;

  @override
  State<_AddLineDialog> createState() => _AddLineDialogState();
}

class _AddLineDialogState extends State<_AddLineDialog> {
  late Product _product = widget.products.first;
  final _qty = TextEditingController(text: '1');
  final _rate = TextEditingController();
  final _discount = TextEditingController(text: '0');

  @override
  void initState() {
    super.initState();
    _rate.text = (_product.sellingPricePaise / 100).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
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
              Text('Add line', style: AppText.sans(size: 16, weight: FontWeight.w600)),
              const SizedBox(height: 16),
              DropdownButton<Product>(
                isExpanded: true,
                value: _product,
                items: [
                  for (final p in widget.products)
                    DropdownMenuItem(value: p, child: Text('${p.sku} · ${p.name}', style: AppText.sans(size: 13))),
                ],
                onChanged: (p) => setState(() {
                  _product = p!;
                  _rate.text = (_product.sellingPricePaise / 100).toStringAsFixed(2);
                }),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(child: _numField('QTY', _qty)),
                  const SizedBox(width: 10),
                  Expanded(child: _numField('RATE (₹)', _rate)),
                  const SizedBox(width: 10),
                  Expanded(child: _numField('DISC %', _discount)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SecondaryButton(label: 'Cancel', onTap: () => Navigator.of(context).pop()),
                  const SizedBox(width: 8),
                  PrimaryButton(
                    label: 'Add',
                    onTap: () {
                      final qty = int.tryParse(_qty.text) ?? 0;
                      if (qty <= 0) return;
                      Navigator.of(context).pop(
                        DraftInvoiceLine(
                          product: _product,
                          qty: qty,
                          ratePaise: rupeesToPaise(num.tryParse(_rate.text) ?? 0),
                          discountPct: double.tryParse(_discount.text) ?? 0,
                        ),
                      );
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

  Widget _numField(String label, TextEditingController c) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.sans(size: 10.5, weight: FontWeight.w600, color: AppColors.mutedInk)),
        const SizedBox(height: 5),
        Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 9),
          decoration: BoxDecoration(color: AppColors.fieldFill, border: Border.all(color: AppColors.fieldBorder), borderRadius: BorderRadius.circular(6)),
          child: TextField(
            controller: c,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            style: AppText.mono(size: 12.5),
            decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: false),
          ),
        ),
      ],
    );
  }
}
