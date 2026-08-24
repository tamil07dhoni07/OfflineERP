import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';

class Gstr1Screen extends StatelessWidget {
  const Gstr1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final spec = TableSpec(
      title: 'GSTR-1 Filing',
      subtitle: 'Invoice-level outward supply return · validation before export',
      devNote: 'features/taxation · gstr1_export · validation ruleset',
      filters: const [FilterSpec('Period', 'Jul 2026'), FilterSpec('Section', 'B2B'), FilterSpec('Errors', 'Only')],
      columns: const [
        ColumnSpec('SECTION'),
        ColumnSpec('INVOICES', align: CellAlign.right),
        ColumnSpec('TAXABLE VALUE', align: CellAlign.right),
        ColumnSpec('TAX', align: CellAlign.right),
        ColumnSpec('VALIDATION'),
        ColumnSpec('STATUS'),
      ],
      rows: [
        RowSpec([
          Cell.text('B2B — 4A', mono: true, weight: FontWeight.w500),
          Cell.number('284'),
          Cell.number('41,90,200'),
          Cell.number('7,54,236'),
          Cell.text('Clean', color: AppColors.successText),
          pillCell(PillTone.paid, 'Ready'),
        ]),
        RowSpec([
          Cell.text('B2CS — 7', mono: true, weight: FontWeight.w500),
          Cell.number('118'),
          Cell.number('1,20,400'),
          Cell.number('21,672'),
          Cell.text('Clean', color: AppColors.successText),
          pillCell(PillTone.paid, 'Ready'),
        ]),
        RowSpec([
          Cell.text('CDNR — 9B', mono: true, weight: FontWeight.w500),
          Cell.number('11'),
          Cell.number('-92,400'),
          Cell.number('-16,632'),
          Cell.text('Clean', color: AppColors.successText),
          pillCell(PillTone.paid, 'Ready'),
        ]),
        RowSpec([
          Cell.text('HSN summary — 12', mono: true, weight: FontWeight.w500),
          Cell.number('46'),
          Cell.number('42,18,200'),
          Cell.number('7,59,276'),
          Cell.text('2 missing HSN', color: AppColors.danger),
          pillCell(PillTone.late, 'Blocked'),
        ]),
        RowSpec([
          Cell.text('Documents — 13', mono: true, weight: FontWeight.w500),
          Cell.number('6'),
          Cell.number('—', color: AppColors.mutedInk),
          Cell.number('—', color: AppColors.mutedInk),
          Cell.text('Clean', color: AppColors.successText),
          pillCell(PillTone.paid, 'Ready'),
        ]),
      ],
      count: '5 sections · export blocked until validation passes',
      cta: 'Export JSON',
    );
    return ListScreen(spec: spec);
  }
}
