import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';

class QuotationsScreen extends StatelessWidget {
  const QuotationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spec = TableSpec(
      title: 'Quotations',
      subtitle: 'Open quotes and their conversion state',
      devNote: 'features/sales · quotations · convert → sales_orders',
      filters: const [FilterSpec('Status', 'Open'), FilterSpec('Period', 'Last 60 days'), FilterSpec('Owner', 'Anyone')],
      columns: const [
        ColumnSpec('QUOTE #'),
        ColumnSpec('DATE'),
        ColumnSpec('CUSTOMER'),
        ColumnSpec('VALID TILL'),
        ColumnSpec('AMOUNT', align: CellAlign.right),
        ColumnSpec('CONVERTED'),
        ColumnSpec('STATUS'),
      ],
      rows: [
        RowSpec([
          Cell.text('QTN/0188', mono: true, weight: FontWeight.w500),
          Cell.text('22 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Meghdoot Wholesale'),
          Cell.text('05 Sep 2026', mono: true, color: AppColors.mutedInk),
          Cell.number('8,40,000'),
          Cell.text('—', color: AppColors.mutedInk),
          pillCell(PillTone.posted, 'Sent'),
        ]),
        RowSpec([
          Cell.text('QTN/0187', mono: true, weight: FontWeight.w500),
          Cell.text('20 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Nandan Traders'),
          Cell.text('03 Sep 2026', mono: true, color: AppColors.mutedInk),
          Cell.number('1,26,500'),
          Cell.text('SO/0341', mono: true),
          pillCell(PillTone.paid, 'Won'),
        ]),
        RowSpec([
          Cell.text('QTN/0186', mono: true, weight: FontWeight.w500),
          Cell.text('18 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Kaveri Retail LLP'),
          Cell.text('01 Sep 2026', mono: true, color: AppColors.mutedInk),
          Cell.number('2,48,500'),
          Cell.text('SO/0339', mono: true),
          pillCell(PillTone.paid, 'Won'),
        ]),
        RowSpec([
          Cell.text('QTN/0185', mono: true, weight: FontWeight.w500),
          Cell.text('15 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Chandrika Enterprises'),
          Cell.text('29 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.number('74,200'),
          Cell.text('—', color: AppColors.mutedInk),
          pillCell(PillTone.draft, 'Draft'),
        ]),
        RowSpec([
          Cell.text('QTN/0184', mono: true, weight: FontWeight.w500),
          Cell.text('12 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Ratnagiri Agencies'),
          Cell.text('26 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.number('3,15,000'),
          Cell.text('—', color: AppColors.mutedInk),
          pillCell(PillTone.late, 'Lost'),
        ]),
      ],
      count: '1 – 5 of 42',
      cta: 'New quotation',
    );
    return ListScreen(spec: spec);
  }
}
