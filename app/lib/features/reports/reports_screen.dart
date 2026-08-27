import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../shared/widgets/adaptive.dart';
import '../../shared/widgets/cards.dart';

class _Report {
  const _Report(this.name, this.description, {this.route});
  final String name;
  final String description;

  /// Where this report actually lives right now. Only reports backed by a
  /// real live screen get one — the rest are catalog entries describing
  /// what the reporting framework would eventually cover, same as the
  /// original design; clicking them does nothing rather than pretending.
  final String? route;
}

class _ReportGroup {
  const _ReportGroup(this.label, this.items);
  final String label;
  final List<_Report> items;
}

const _groups = [
  _ReportGroup('SALES & RECEIVABLES', [
    _Report('Sales register', 'Invoice-level with tax split and margin', route: '/invoices'),
    _Report('Customer aging', '0–30 / 31–60 / 61–90 / 90+ buckets', route: '/customers'),
    _Report('Customer statement', 'Printable account statement per customer', route: '/customers'),
    _Report('Item-wise sales', 'Quantity and value by SKU, category or brand'),
  ]),
  _ReportGroup('PURCHASING & PAYABLES', [
    _Report('Purchase register', 'PO to invoice with receipt variance', route: '/po'),
    _Report('Supplier aging', 'Open payables by due bucket', route: '/suppliers'),
    _Report('Pending receipts', 'Ordered vs received quantities', route: '/grn'),
    _Report('Price variance', 'PO rate against invoice rate'),
  ]),
  _ReportGroup('INVENTORY', [
    _Report('Stock summary', 'On hand, reserved and available by warehouse', route: '/stock'),
    _Report('Stock movement', 'Full in/out ledger per SKU', route: '/stock'),
    _Report('Valuation report', 'Moving average and closing value', route: '/stock'),
    _Report('Batch & expiry', 'Ageing batches and near-expiry stock'),
  ]),
  _ReportGroup('FINANCE & TAX', [
    _Report('Trial balance', 'Any date, any level of the account tree', route: '/tb'),
    _Report('Profit & loss', 'Period comparison with variance'),
    _Report('Balance sheet', 'As at date, schedule-wise'),
    _Report('Cash & bank book', 'Daily balances and reconciliation', route: '/ledger'),
    _Report('GSTR-1 / 3B', 'Return-ready summaries and JSON export', route: '/gstr1'),
    _Report('HSN summary', 'Rate-wise outward supply by HSN'),
    _Report('TDS summary', 'Deductions by section and deductee'),
    _Report('Expense analysis', 'Category-wise with approval trail'),
  ]),
  _ReportGroup('PEOPLE', [
    _Report('Attendance register', 'Daily and monthly muster', route: '/attendance'),
    _Report('Payroll register', 'Gross to net with statutory heads', route: '/payroll'),
    _Report('Leave balance', 'Accrued, used and encashable', route: '/leave'),
    _Report('Salary slip', 'Printable per employee per period'),
  ]),
];

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1320),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Reports', style: AppText.sans(size: 19, weight: FontWeight.w600, letterSpacing: -0.4)),
                    const SizedBox(height: 4),
                    Text(
                      'Reports with a live screen behind them open it directly; the rest are the catalog this framework will grow into.',
                      style: AppText.sans(size: 12.5, color: AppColors.mutedInk),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(color: AppColors.devNoteTint, borderRadius: BorderRadius.circular(6)),
                child: Text(
                  'features/reports · ReportDefinition · PDF · XLSX',
                  style: AppText.mono(size: 10.5, color: AppColors.mutedFainter),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          for (final g in _groups)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(g.label, style: AppText.mono(size: 10.5, color: AppColors.mutedFainter, letterSpacing: 1.2)),
                  const SizedBox(height: 9),
                  AdaptiveGrid(
                    columns: 4,
                    minTileWidth: 230,
                    children: [for (final r in g.items) _ReportTile(r)],
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ReportTile extends StatefulWidget {
  const _ReportTile(this.report);
  final _Report report;

  @override
  State<_ReportTile> createState() => _ReportTileState();
}

class _ReportTileState extends State<_ReportTile> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final live = widget.report.route != null;
    return MouseRegion(
      cursor: live ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: live ? () => context.go(widget.report.route!) : null,
        child: SectionCard(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
          child: Container(
            decoration: BoxDecoration(border: Border.all(color: _hover && live ? AppColors.accent : Colors.transparent)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(widget.report.name, style: AppText.sans(size: 12.5, weight: FontWeight.w600))),
                    if (live) const Icon(Icons.arrow_outward, size: 13, color: AppColors.accent),
                  ],
                ),
                const SizedBox(height: 6),
                Text(widget.report.description, style: AppText.sans(size: 11.5, color: AppColors.mutedSoft, height: 1.5)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
