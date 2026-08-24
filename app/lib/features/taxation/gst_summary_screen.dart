import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';

class GstSummaryScreen extends StatelessWidget {
  const GstSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spec = TableSpec(
      title: 'GST Summary',
      subtitle: 'Aug 2026 · output tax, input credit and net payable',
      devNote: 'features/taxation · tax_lines · configurable per region',
      filters: const [
        FilterSpec('Period', 'Aug 2026'),
        FilterSpec('GSTIN', '27AAECN1180K1Z5'),
        FilterSpec('Type', 'Regular'),
      ],
      columns: const [
        ColumnSpec('HEAD'),
        ColumnSpec('TAXABLE VALUE', align: CellAlign.right),
        ColumnSpec('CGST', align: CellAlign.right),
        ColumnSpec('SGST', align: CellAlign.right),
        ColumnSpec('IGST', align: CellAlign.right),
        ColumnSpec('TOTAL TAX', align: CellAlign.right),
      ],
      rows: [
        RowSpec([
          Cell.text('Outward — intra-state (B2B)', weight: FontWeight.w500),
          Cell.number('42,68,300'),
          Cell.number('3,84,147'),
          Cell.number('3,84,147'),
          Cell.number('—', color: AppColors.mutedInk),
          Cell.number('7,68,294'),
        ]),
        RowSpec([
          Cell.text('Outward — inter-state (B2B)', weight: FontWeight.w500),
          Cell.number('8,89,600'),
          Cell.number('—', color: AppColors.mutedInk),
          Cell.number('—', color: AppColors.mutedInk),
          Cell.number('1,60,128'),
          Cell.number('1,60,128'),
        ]),
        RowSpec([
          Cell.text('Outward — B2C small', weight: FontWeight.w500),
          Cell.number('1,20,400'),
          Cell.number('10,836'),
          Cell.number('10,836'),
          Cell.number('—', color: AppColors.mutedInk),
          Cell.number('21,672'),
        ]),
        RowSpec([
          Cell.text('Inward — eligible ITC', weight: FontWeight.w500),
          Cell.number('31,04,700'),
          Cell.number('2,79,423'),
          Cell.number('2,79,423'),
          Cell.number('42,180'),
          Cell.number('6,01,026'),
        ]),
        RowSpec([
          Cell.text('Inward — ineligible / blocked', weight: FontWeight.w500),
          Cell.number('48,000'),
          Cell.number('4,320'),
          Cell.number('4,320'),
          Cell.number('—', color: AppColors.mutedInk),
          Cell.number('8,640'),
        ]),
        RowSpec([
          Cell.text('NET PAYABLE', weight: FontWeight.w600),
          Cell.number('—', color: AppColors.mutedInk),
          Cell.number('1,15,560', weight: FontWeight.w600),
          Cell.number('1,15,560', weight: FontWeight.w600),
          Cell.number('1,17,948', weight: FontWeight.w600),
          Cell.number('3,49,068', weight: FontWeight.w600),
        ]),
      ],
      count: 'Computed on device · GSTR-3B due 20 Sep 2026',
      cta: 'Generate GSTR-3B',
      note:
          'Tax heads, rate slabs and inclusive/exclusive behaviour come from the tax configuration table — no country logic is compiled into the modules.',
    );
    return ListScreen(spec: spec);
  }
}
