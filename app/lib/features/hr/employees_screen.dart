import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/list_screen.dart';

class EmployeesScreen extends StatelessWidget {
  const EmployeesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final spec = TableSpec(
      title: 'Employees',
      subtitle: 'Active roster with designation, department and salary structure',
      devNote: 'features/hr · employees · salary_structures',
      filters: const [FilterSpec('Department', 'All'), FilterSpec('Status', 'Active'), FilterSpec('Branch', 'Mumbai HQ')],
      columns: const [
        ColumnSpec('CODE'),
        ColumnSpec('NAME'),
        ColumnSpec('DESIGNATION'),
        ColumnSpec('DEPARTMENT'),
        ColumnSpec('JOINED'),
        ColumnSpec('CTC / MONTH', align: CellAlign.right),
        ColumnSpec('LEAVE BAL', align: CellAlign.right),
        ColumnSpec('STATUS'),
      ],
      rows: [
        RowSpec([
          Cell.text('E-014', mono: true, weight: FontWeight.w500),
          Cell.text('Rohit Deshmukh'),
          Cell.text('Accounts Manager', color: AppColors.mutedInk),
          Cell.text('Finance', color: AppColors.mutedInk),
          Cell.text('11 Apr 2021', mono: true, color: AppColors.mutedInk),
          Cell.number('92,000'),
          Cell.number('11.5'),
          pillCell(PillTone.paid, 'Active'),
        ]),
        RowSpec([
          Cell.text('E-021', mono: true, weight: FontWeight.w500),
          Cell.text('Sneha Iyer'),
          Cell.text('Warehouse Supervisor', color: AppColors.mutedInk),
          Cell.text('Operations', color: AppColors.mutedInk),
          Cell.text('02 Aug 2022', mono: true, color: AppColors.mutedInk),
          Cell.number('64,000'),
          Cell.number('6.0'),
          pillCell(PillTone.paid, 'Active'),
        ]),
        RowSpec([
          Cell.text('E-029', mono: true, weight: FontWeight.w500),
          Cell.text('Arun Patil'),
          Cell.text('Sales Executive', color: AppColors.mutedInk),
          Cell.text('Sales', color: AppColors.mutedInk),
          Cell.text('19 Jan 2024', mono: true, color: AppColors.mutedInk),
          Cell.number('48,500'),
          Cell.number('3.5'),
          pillCell(PillTone.paid, 'Active'),
        ]),
        RowSpec([
          Cell.text('E-033', mono: true, weight: FontWeight.w500),
          Cell.text('Meera Shetty'),
          Cell.text('Billing Clerk', color: AppColors.mutedInk),
          Cell.text('Finance', color: AppColors.mutedInk),
          Cell.text('05 Jun 2025', mono: true, color: AppColors.mutedInk),
          Cell.number('34,000'),
          Cell.number('8.0'),
          pillCell(PillTone.warn, 'On leave'),
        ]),
        RowSpec([
          Cell.text('E-036', mono: true, weight: FontWeight.w500),
          Cell.text('Imran Sheikh'),
          Cell.text('Store Keeper', color: AppColors.mutedInk),
          Cell.text('Operations', color: AppColors.mutedInk),
          Cell.text('14 Feb 2026', mono: true, color: AppColors.mutedInk),
          Cell.number('28,000'),
          Cell.number('2.0'),
          pillCell(PillTone.paid, 'Active'),
        ]),
      ],
      count: '1 – 5 of 48',
      cta: 'New employee',
    );
    return ListScreen(spec: spec);
  }
}
