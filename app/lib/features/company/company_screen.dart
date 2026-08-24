import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../shared/widgets/adaptive.dart';
import '../../shared/widgets/cards.dart';

class _Row {
  const _Row(this.label, this.value, {this.mono = false});
  final String label;
  final String value;
  final bool mono;
}

class _Section {
  const _Section(this.title, this.table, this.rows);
  final String title;
  final String table;
  final List<_Row> rows;
}

class CompanyScreen extends ConsumerWidget {
  const CompanyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companyAsync = ref.watch(companyProvider);
    final warehousesAsync = ref.watch(warehousesProvider);
    final usersAsync = ref.watch(appUserCountProvider);

    if (!companyAsync.hasValue || !warehousesAsync.hasValue) {
      return const Center(child: CircularProgressIndicator());
    }
    final company = companyAsync.value!;
    final warehouses = warehousesAsync.value!;
    final userCount = usersAsync.valueOrNull ?? 0;

    final sections = [
      _Section('Company', 'companies', [
        _Row('Legal name', company.legalName),
        _Row('GSTIN', company.gstin, mono: true),
        _Row('PAN', company.pan, mono: true),
        _Row('State', '${company.state} (${company.stateCode})'),
        _Row('Base currency', '${company.baseCurrency} ₹'),
      ]),
      _Section('Branches & warehouses', 'branches · warehouses', [
        const _Row('Mumbai HQ', 'Head office · billing'),
        for (final w in warehouses) _Row(w.name, w.notes ?? 'Warehouse'),
        const _Row('Inter-branch transfers', 'Enabled'),
      ]),
      const _Section('Financial year & periods', 'financial_years · periods', [
        _Row('Current FY', '01 Apr 2026 – 31 Mar 2027', mono: true),
        _Row('Open periods', 'Aug 2026'),
        _Row('Locked up to', '31 Jul 2026', mono: true),
        _Row('Backdated entries', 'Manager approval'),
      ]),
      const _Section('Numbering sequences', 'numbering_sequences', [
        _Row('Sales invoice', 'INV/26-27/####', mono: true),
        _Row('Purchase order', 'PO/26-27/####', mono: true),
        _Row('Receipt voucher', 'RCP/####', mono: true),
        _Row('Journal voucher', 'JV/####', mono: true),
        _Row('Reset on', 'Financial year'),
      ]),
      const _Section('Tax configuration', 'tax_rates · tax_groups', [
        _Row('Regime', 'India GST · regular'),
        _Row('Slabs', '0 / 5 / 12 / 18 / 28 %', mono: true),
        _Row('Pricing', 'Tax-exclusive'),
        _Row('Reverse charge', 'Supported'),
        _Row('Rounding', 'Nearest rupee, invoice level'),
      ]),
      _Section('Users & roles', 'users · roles · permissions', [
        _Row('Active users', '$userCount seeded'),
        const _Row('Roles', 'Owner, Accountant, Sales, Store, Auditor'),
        const _Row('Session timeout', '30 minutes idle'),
        const _Row('Password policy', 'PBKDF2-SHA256, 210k iterations'),
        const _Row('Quick PIN login', 'Not yet wired'),
      ]),
    ];

    return AdaptiveGrid(
      columns: 2,
      minTileWidth: 420,
      children: [for (final s in sections) _SectionCardView(s)],
    );
  }
}

final appUserCountProvider = FutureProvider((ref) async {
  final db = ref.watch(databaseProvider);
  final rows = await db.select(db.appUsers).get();
  return rows.length;
});

class _SectionCardView extends StatelessWidget {
  const _SectionCardView(this.section);
  final _Section section;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          SectionHeader(title: section.title, trailing: section.table),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 6, 15, 13),
            child: Column(
              children: [
                for (final r in section.rows)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 9),
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderRow))),
                    child: Row(
                      children: [
                        Text(r.label, style: AppText.sans(size: 12.5, color: AppColors.mutedInk)),
                        const Spacer(),
                        Flexible(
                          child: Text(
                            r.value,
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            style: r.mono
                                ? AppText.mono(size: 12.5, weight: FontWeight.w500)
                                : AppText.sans(size: 12.5, weight: FontWeight.w500),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
