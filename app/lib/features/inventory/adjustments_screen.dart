import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';

class AdjustmentsScreen extends StatelessWidget {
  const AdjustmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spec = TableSpec(
      title: 'Stock Adjustments',
      subtitle: 'Every quantity correction, with reason and approver',
      devNote: 'features/inventory · stock_adjustments · audit_logs',
      filters: const [FilterSpec('Reason', 'All'), FilterSpec('Warehouse', 'All'), FilterSpec('Period', 'Aug 2026')],
      columns: const [
        ColumnSpec('REF'),
        ColumnSpec('DATE'),
        ColumnSpec('SKU'),
        ColumnSpec('WAREHOUSE'),
        ColumnSpec('REASON'),
        ColumnSpec('DELTA', align: CellAlign.right),
        ColumnSpec('VALUE IMPACT', align: CellAlign.right),
        ColumnSpec('APPROVED BY'),
      ],
      rows: [
        RowSpec([
          Cell.text('ADJ/0087', mono: true, weight: FontWeight.w500),
          Cell.text('22 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('PKG-0902', mono: true),
          Cell.text('Mumbai WH-2'),
          Cell.text('Damage in handling'),
          Cell.number('-24', color: AppColors.danger),
          Cell.number('-840', color: AppColors.danger),
          Cell.text('R. Deshmukh', color: AppColors.mutedInk),
        ]),
        RowSpec([
          Cell.text('ADJ/0086', mono: true, weight: FontWeight.w500),
          Cell.text('19 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('PLY-3410', mono: true),
          Cell.text('Bhiwandi WH-1'),
          Cell.text('Cycle count variance'),
          Cell.number('+6', color: AppColors.successText),
          Cell.number('+4,920', color: AppColors.successText),
          Cell.text('S. Iyer', color: AppColors.mutedInk),
        ]),
        RowSpec([
          Cell.text('ADJ/0085', mono: true, weight: FontWeight.w500),
          Cell.text('15 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('CHM-7741', mono: true),
          Cell.text('Bhiwandi WH-1'),
          Cell.text('Expiry write-off'),
          Cell.number('-4', color: AppColors.danger),
          Cell.number('-13,200', color: AppColors.danger),
          Cell.text('S. Iyer', color: AppColors.mutedInk),
        ]),
      ],
      count: '1 – 3 of 87',
      cta: 'New adjustment',
    );
    return ListScreen(spec: spec);
  }
}
