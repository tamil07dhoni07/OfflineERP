import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';

class GoodsReceiptScreen extends StatelessWidget {
  const GoodsReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spec = TableSpec(
      title: 'Goods Receipt',
      subtitle: 'Inbound receipts against purchase orders',
      devNote: 'features/purchasing · goods_receipts · stock_movements (IN)',
      filters: const [FilterSpec('Warehouse', 'All'), FilterSpec('Period', 'Aug 2026'), FilterSpec('PO', 'Any')],
      columns: const [
        ColumnSpec('GRN #'),
        ColumnSpec('DATE'),
        ColumnSpec('SUPPLIER'),
        ColumnSpec('AGAINST PO'),
        ColumnSpec('QTY', align: CellAlign.right),
        ColumnSpec('VALUE', align: CellAlign.right),
        ColumnSpec('QC'),
        ColumnSpec('STATUS'),
      ],
      rows: [
        RowSpec([
          Cell.text('GRN/0431', mono: true, weight: FontWeight.w500),
          Cell.text('22 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Konkan Steel Co'),
          Cell.text('PO/26-27/0176', mono: true),
          Cell.number('340'),
          Cell.number('4,12,600'),
          pillCell(PillTone.paid, 'Passed'),
          pillCell(PillTone.posted, 'Posted'),
        ]),
        RowSpec([
          Cell.text('GRN/0430', mono: true, weight: FontWeight.w500),
          Cell.text('20 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Deccan Packaging'),
          Cell.text('PO/26-27/0175', mono: true),
          Cell.number('2,500'),
          Cell.number('87,500'),
          pillCell(PillTone.warn, 'Partial hold'),
          pillCell(PillTone.posted, 'Posted'),
        ]),
        RowSpec([
          Cell.text('GRN/0429', mono: true, weight: FontWeight.w500),
          Cell.text('18 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Godavari Chemicals'),
          Cell.text('PO/26-27/0174', mono: true),
          Cell.number('80'),
          Cell.number('2,64,000'),
          pillCell(PillTone.paid, 'Passed'),
          pillCell(PillTone.posted, 'Posted'),
        ]),
      ],
      count: '1 – 3 of 431',
      cta: 'New receipt',
    );
    return ListScreen(spec: spec);
  }
}
