import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';

class PurchaseOrdersScreen extends StatelessWidget {
  const PurchaseOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spec = TableSpec(
      title: 'Purchase Orders',
      subtitle: 'Committed orders and their receipt progress',
      devNote: 'features/purchasing · purchase_orders · goods_receipts',
      filters: const [FilterSpec('Status', 'Open'), FilterSpec('Supplier', 'Any'), FilterSpec('Warehouse', 'All')],
      columns: const [
        ColumnSpec('PO #'),
        ColumnSpec('DATE'),
        ColumnSpec('SUPPLIER'),
        ColumnSpec('WAREHOUSE'),
        ColumnSpec('ORDERED', align: CellAlign.right),
        ColumnSpec('RECEIVED', align: CellAlign.right),
        ColumnSpec('VALUE', align: CellAlign.right),
        ColumnSpec('STATUS'),
      ],
      rows: [
        RowSpec([
          Cell.text('PO/26-27/0177', mono: true, weight: FontWeight.w500),
          Cell.text('23 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Sahyadri Polymers'),
          Cell.text('Bhiwandi WH-1'),
          Cell.number('1,200'),
          Cell.number('0'),
          Cell.number('9,84,000', weight: FontWeight.w600),
          pillCell(PillTone.posted, 'Approved'),
        ]),
        RowSpec([
          Cell.text('PO/26-27/0176', mono: true, weight: FontWeight.w500),
          Cell.text('21 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Konkan Steel Co'),
          Cell.text('Bhiwandi WH-1'),
          Cell.number('340'),
          Cell.number('340'),
          Cell.number('4,12,600', weight: FontWeight.w600),
          pillCell(PillTone.paid, 'Received'),
        ]),
        RowSpec([
          Cell.text('PO/26-27/0175', mono: true, weight: FontWeight.w500),
          Cell.text('19 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Deccan Packaging'),
          Cell.text('Mumbai WH-2'),
          Cell.number('5,000'),
          Cell.number('2,500'),
          Cell.number('1,75,000', weight: FontWeight.w600),
          pillCell(PillTone.warn, 'Part received'),
        ]),
        RowSpec([
          Cell.text('PO/26-27/0174', mono: true, weight: FontWeight.w500),
          Cell.text('17 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Godavari Chemicals'),
          Cell.text('Bhiwandi WH-1'),
          Cell.number('80'),
          Cell.number('80'),
          Cell.number('2,64,000', weight: FontWeight.w600),
          pillCell(PillTone.paid, 'Received'),
        ]),
        RowSpec([
          Cell.text('PO/26-27/0173', mono: true, weight: FontWeight.w500),
          Cell.text('14 Aug 2026', mono: true, color: AppColors.mutedInk),
          Cell.text('Sahyadri Polymers'),
          Cell.text('Mumbai WH-2'),
          Cell.number('900'),
          Cell.number('0'),
          Cell.number('7,38,000', weight: FontWeight.w600),
          pillCell(PillTone.draft, 'Awaiting approval'),
        ]),
      ],
      count: '1 – 5 of 177',
      cta: 'New purchase order',
    );
    return ListScreen(spec: spec);
  }
}
