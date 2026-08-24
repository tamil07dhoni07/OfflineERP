import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';

class ReceiptsScreen extends StatelessWidget {
  const ReceiptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spec = TableSpec(
      title: 'Customer Receipts',
      subtitle: 'Money in, with allocation against open invoices',
      devNote: 'features/sales · receipt_vouchers · allocations',
      filters: const [FilterSpec('Method', 'All'), FilterSpec('Period', 'Aug 2026'), FilterSpec('Bank', 'All accounts')],
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
      rows: [
        RowSpec([
          Cell.text('RCP/0902', mono: true, weight: FontWeight.w500),
          Cell.text('24 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Bhagyashree Stores'),
          Cell.text('UPI'),
          Cell.text('4471998210', mono: true, color: AppColors.mutedInk),
          Cell.number('1,03,132'),
          Cell.number('0', color: AppColors.mutedInk),
          pillCell(PillTone.posted, 'Posted'),
        ]),
        RowSpec([
          Cell.text('RCP/0901', mono: true, weight: FontWeight.w500),
          Cell.text('23 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Nandan Traders'),
          Cell.text('NEFT'),
          Cell.text('HDFC0004471', mono: true, color: AppColors.mutedInk),
          Cell.number('1,50,000'),
          Cell.number('0', color: AppColors.mutedInk),
          pillCell(PillTone.posted, 'Posted'),
        ]),
        RowSpec([
          Cell.text('RCP/0900', mono: true, weight: FontWeight.w500),
          Cell.text('22 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Meghdoot Wholesale'),
          Cell.text('Cheque'),
          Cell.text('882104', mono: true, color: AppColors.mutedInk),
          Cell.number('2,00,000'),
          Cell.number('0', color: AppColors.mutedInk),
          pillCell(PillTone.warn, 'Uncleared'),
        ]),
        RowSpec([
          Cell.text('RCP/0899', mono: true, weight: FontWeight.w500),
          Cell.text('21 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Kaveri Retail LLP'),
          Cell.text('Cash'),
          Cell.text('—', color: AppColors.mutedInk),
          Cell.number('90,000'),
          Cell.number('20,920'),
          pillCell(PillTone.posted, 'Posted'),
        ]),
      ],
      count: '1 – 4 of 318',
      cta: 'Record receipt',
    );
    return ListScreen(spec: spec);
  }
}
