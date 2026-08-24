import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';

class TransfersScreen extends StatelessWidget {
  const TransfersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spec = TableSpec(
      title: 'Stock Transfers',
      subtitle: 'Movements between warehouses, in transit and settled',
      devNote: 'features/inventory · stock_transfers · paired OUT/IN movements',
      filters: const [FilterSpec('Status', 'All'), FilterSpec('From', 'Any'), FilterSpec('To', 'Any')],
      columns: const [
        ColumnSpec('TRANSFER'),
        ColumnSpec('DATE'),
        ColumnSpec('FROM'),
        ColumnSpec('TO'),
        ColumnSpec('LINES', align: CellAlign.right),
        ColumnSpec('QTY', align: CellAlign.right),
        ColumnSpec('VALUE', align: CellAlign.right),
        ColumnSpec('STATUS'),
      ],
      rows: [
        RowSpec([
          Cell.text('TRF/0212', mono: true, weight: FontWeight.w500),
          Cell.text('23 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Bhiwandi WH-1'),
          Cell.text('Mumbai WH-2'),
          Cell.number('4'),
          Cell.number('640'),
          Cell.number('2,18,400'),
          pillCell(PillTone.warn, 'In transit'),
        ]),
        RowSpec([
          Cell.text('TRF/0211', mono: true, weight: FontWeight.w500),
          Cell.text('20 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Mumbai WH-2'),
          Cell.text('Pune WH-3'),
          Cell.number('2'),
          Cell.number('180'),
          Cell.number('64,800'),
          pillCell(PillTone.paid, 'Received'),
        ]),
        RowSpec([
          Cell.text('TRF/0210', mono: true, weight: FontWeight.w500),
          Cell.text('16 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Bhiwandi WH-1'),
          Cell.text('Pune WH-3'),
          Cell.number('6'),
          Cell.number('1,020'),
          Cell.number('3,91,000'),
          pillCell(PillTone.paid, 'Received'),
        ]),
      ],
      count: '1 – 3 of 212',
      cta: 'New transfer',
    );
    return ListScreen(spec: spec);
  }
}
