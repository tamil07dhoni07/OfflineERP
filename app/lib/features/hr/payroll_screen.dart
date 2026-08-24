import 'package:flutter/material.dart';

import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';

class PayrollScreen extends StatelessWidget {
  const PayrollScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spec = TableSpec(
      title: 'Payroll Runs',
      subtitle: 'Monthly cycles, statutory deductions and posting state',
      devNote: 'features/payroll · payroll_runs · posts to journal on approval',
      filters: const [FilterSpec('Year', 'FY 2026-27'), FilterSpec('Status', 'All'), FilterSpec('Branch', 'All')],
      columns: const [
        ColumnSpec('PERIOD'),
        ColumnSpec('HEADCOUNT', align: CellAlign.right),
        ColumnSpec('GROSS', align: CellAlign.right),
        ColumnSpec('PF', align: CellAlign.right),
        ColumnSpec('ESI', align: CellAlign.right),
        ColumnSpec('TDS', align: CellAlign.right),
        ColumnSpec('NET PAYABLE', align: CellAlign.right),
        ColumnSpec('STATUS'),
      ],
      rows: [
        RowSpec([
          Cell.text('Aug 2026', weight: FontWeight.w500),
          Cell.number('48'),
          Cell.number('24,86,000'),
          Cell.number('1,49,160'),
          Cell.number('38,420'),
          Cell.number('1,92,400'),
          Cell.number('21,06,020', weight: FontWeight.w600),
          pillCell(PillTone.draft, 'Draft'),
        ]),
        RowSpec([
          Cell.text('Jul 2026', weight: FontWeight.w500),
          Cell.number('47'),
          Cell.number('24,12,000'),
          Cell.number('1,44,720'),
          Cell.number('37,180'),
          Cell.number('1,86,900'),
          Cell.number('20,43,200', weight: FontWeight.w600),
          pillCell(PillTone.posted, 'Posted'),
        ]),
        RowSpec([
          Cell.text('Jun 2026', weight: FontWeight.w500),
          Cell.number('47'),
          Cell.number('24,12,000'),
          Cell.number('1,44,720'),
          Cell.number('37,180'),
          Cell.number('1,86,900'),
          Cell.number('20,43,200', weight: FontWeight.w600),
          pillCell(PillTone.paid, 'Paid'),
        ]),
        RowSpec([
          Cell.text('May 2026', weight: FontWeight.w500),
          Cell.number('46'),
          Cell.number('23,48,000'),
          Cell.number('1,40,880'),
          Cell.number('36,050'),
          Cell.number('1,80,600'),
          Cell.number('19,90,470', weight: FontWeight.w600),
          pillCell(PillTone.paid, 'Paid'),
        ]),
      ],
      count: '1 – 4 of 17',
      cta: 'New payroll run',
    );
    return ListScreen(spec: spec);
  }
}
