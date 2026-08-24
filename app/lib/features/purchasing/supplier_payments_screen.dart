import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';

class SupplierPaymentsScreen extends StatelessWidget {
  const SupplierPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spec = TableSpec(
      title: 'Supplier Payments',
      subtitle: 'Outgoing payments and aging',
      devNote: 'features/purchasing · payment_vouchers · accounts_payable',
      filters: const [FilterSpec('Status', 'All'), FilterSpec('Period', 'Aug 2026')],
      columns: const [
        ColumnSpec('VOUCHER'),
        ColumnSpec('DATE'),
        ColumnSpec('SUPPLIER'),
        ColumnSpec('METHOD'),
        ColumnSpec('AMOUNT', align: CellAlign.right),
        ColumnSpec('OPEN BALANCE', align: CellAlign.right),
        ColumnSpec('STATUS'),
      ],
      rows: [
        RowSpec([
          Cell.text('PMT/0611', mono: true, weight: FontWeight.w500),
          Cell.text('23 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Konkan Steel Co'),
          Cell.text('NEFT'),
          Cell.number('4,12,600'),
          Cell.number('0', color: AppColors.mutedInk),
          pillCell(PillTone.posted, 'Posted'),
        ]),
        RowSpec([
          Cell.text('PMT/0610', mono: true, weight: FontWeight.w500),
          Cell.text('21 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Deccan Packaging'),
          Cell.text('RTGS'),
          Cell.number('50,000'),
          Cell.number('37,500', color: AppColors.danger),
          pillCell(PillTone.posted, 'Posted'),
        ]),
        RowSpec([
          Cell.text('PMT/0609', mono: true, weight: FontWeight.w500),
          Cell.text('18 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Sahyadri Polymers'),
          Cell.text('Cheque'),
          Cell.number('3,00,000'),
          Cell.number('6,84,000', color: AppColors.danger),
          pillCell(PillTone.warn, 'Uncleared'),
        ]),
      ],
      count: '1 – 3 of 611',
      cta: 'New payment',
    );
    return ListScreen(spec: spec);
  }
}
