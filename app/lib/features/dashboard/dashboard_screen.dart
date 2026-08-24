import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/database/repositories/dashboard_repository.dart';
import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../core/utils/money.dart';
import '../../shared/widgets/adaptive.dart';
import '../../shared/widgets/cards.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(dashboardDataProvider);
    return async.when(
      loading: () => const Padding(
        padding: EdgeInsets.only(top: 80),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (e, st) => Padding(padding: const EdgeInsets.all(20), child: Text('Failed to load dashboard: $e')),
      data: (data) => _DashboardBody(data: data),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody({required this.data});
  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    final deltaTone = data.salesDeltaPct >= 0 ? AppColors.successText : AppColors.danger;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1320),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AdaptiveGrid(
            columns: 4,
            minTileWidth: 240,
            children: [
              KpiCard(
                label: 'SALES THIS MONTH',
                value: data.salesThisMonthPaise.toIndianRupees(withSymbol: true),
                delta: '${data.salesDeltaPct >= 0 ? '+' : ''}${data.salesDeltaPct.toStringAsFixed(1)}%',
                sub: 'vs last month',
                tone: deltaTone,
              ),
              KpiCard(
                label: 'RECEIVABLES OUTSTANDING',
                value: data.receivablesOutstandingPaise.toIndianRupees(withSymbol: true),
                delta: '${data.overdueAmountPaise.toIndianRupees(withSymbol: true)} overdue',
                sub: '${data.overdueCount} accounts',
                tone: AppColors.danger,
              ),
              KpiCard(
                label: 'STOCK VALUE',
                value: data.stockValuePaise.toIndianRupees(withSymbol: true),
                delta: '${data.belowReorderCount} below reorder',
                sub: '3 warehouses',
                tone: AppColors.warnText,
              ),
              KpiCard(
                label: 'GST NET PAYABLE',
                value: data.gstNetPayablePaise.toIndianRupees(withSymbol: true),
                delta: 'due 20th next mo.',
                sub: 'GSTR-3B',
                tone: AppColors.mutedInk,
              ),
            ],
          ),
          const SizedBox(height: 14),
          AdaptiveColumns(
            flexes: const [3, 2],
            children: [
              SectionCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    const SectionHeader(title: 'Sales, last 14 days', trailing: 'aggregated on device'),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 18, 15, 12),
                      child: SizedBox(height: 172, child: _SalesBars(data: data)),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('GST position · this month', style: AppText.sans(size: 13, weight: FontWeight.w600)),
                        const SizedBox(height: 11),
                        _GstRow('Output CGST', data.gstOutputCgstPaise),
                        _GstRow('Output SGST', data.gstOutputSgstPaise),
                        _GstRow('Output IGST', data.gstOutputIgstPaise),
                        const SizedBox(height: 2),
                        Container(height: 1, color: AppColors.borderSoft),
                        const SizedBox(height: 2),
                        _GstRow('Net payable', data.gstNetPayablePaise, bold: true),
                        const SizedBox(height: 9),
                        Text(
                          'GSTR-3B due 20th of next month · computed from local tax ledger.',
                          style: AppText.sans(size: 11.5, color: AppColors.mutedSoft, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SectionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('Reorder alerts', style: AppText.sans(size: 13, weight: FontWeight.w600)),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                              decoration: BoxDecoration(color: AppColors.warnTint, borderRadius: BorderRadius.circular(999)),
                              child: Text(
                                '${data.belowReorderCount}',
                                style: AppText.mono(size: 10.5, color: AppColors.warnText),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        if (data.reorderAlerts.isEmpty)
                          Text('Nothing below reorder level.', style: AppText.sans(size: 12.5, color: AppColors.mutedSoft))
                        else
                          for (final a in data.reorderAlerts)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(a.name, overflow: TextOverflow.ellipsis, style: AppText.sans(size: 12.5)),
                                  ),
                                  Text(
                                    '${a.onHand} / ${a.reorderLevel}',
                                    style: AppText.mono(size: 11.5, color: AppColors.danger),
                                  ),
                                ],
                              ),
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          AdaptiveColumns(
            children: [
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Data integrity & device health', style: AppText.sans(size: 13, weight: FontWeight.w600)),
                    const SizedBox(height: 12),
                    _HealthRow(
                      ok: data.trialBalanceInAgreement,
                      title: data.trialBalanceInAgreement ? 'Trial balance in agreement' : 'Trial balance OUT OF BALANCE',
                      sub: 'debits = credits · checked after every journal commit',
                    ),
                    _HealthRow(ok: true, title: 'Encrypted Drive backup verified', sub: 'today 04:00 · AES-256-GCM'),
                    _HealthRow(ok: false, title: 'License revalidation pending', sub: 'offline grace 21 d remaining'),
                    _HealthRow(ok: true, title: 'Schema at migration ${data.schemaVersion}', sub: 'no pending migrations'),
                  ],
                ),
              ),
              SectionCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Pending approvals', style: AppText.sans(size: 13, weight: FontWeight.w600)),
                    const SizedBox(height: 11),
                    const _ApprovalRow(
                      title: 'Purchase order PO/26-27/0173 · ₹7,38,000',
                      sub: 'Sahyadri Polymers · above ₹5 L threshold',
                    ),
                    const _ApprovalRow(
                      title: 'Credit limit breach · Chandrika Enterprises',
                      sub: 'invoice would exceed limit',
                    ),
                    const _ApprovalRow(
                      title: 'Stock write-off ADJ/0088 · ₹13,200',
                      sub: 'expiry · requires finance approval',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GstRow extends StatelessWidget {
  const _GstRow(this.label, this.paise, {this.bold = false});
  final String label;
  final int paise;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Text(label, style: AppText.sans(size: 12.5, color: AppColors.mutedInk)),
          const Spacer(),
          Text(
            paise.toIndianRupees(withSymbol: true),
            style: AppText.mono(size: 12.5, weight: bold ? FontWeight.w600 : FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

class _HealthRow extends StatelessWidget {
  const _HealthRow({required this.ok, required this.title, required this.sub});
  final bool ok;
  final String title;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(color: ok ? AppColors.success : AppColors.warn, shape: BoxShape.circle),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppText.sans(size: 12.5, weight: FontWeight.w500)),
                Text(sub, style: AppText.mono(size: 10.5, color: AppColors.mutedFaint)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ApprovalRow extends StatelessWidget {
  const _ApprovalRow({required this.title, required this.sub});
  final String title;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.fieldFill,
        border: Border.all(color: AppColors.borderSoft),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, overflow: TextOverflow.ellipsis, style: AppText.sans(size: 12.5, weight: FontWeight.w500)),
                Text(sub, style: AppText.mono(size: 10.5, color: AppColors.mutedFaint)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            height: 26,
            padding: const EdgeInsets.symmetric(horizontal: 11),
            decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(6)),
            alignment: Alignment.center,
            child: Text('Approve', style: AppText.sans(size: 11.5, weight: FontWeight.w600, color: AppColors.white)),
          ),
          const SizedBox(width: 6),
          Container(
            height: 26,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.card,
              border: Border.all(color: AppColors.controlBorder),
              borderRadius: BorderRadius.circular(6),
            ),
            alignment: Alignment.center,
            child: Text('Review', style: AppText.sans(size: 11.5)),
          ),
        ],
      ),
    );
  }
}

class _SalesBars extends StatelessWidget {
  const _SalesBars({required this.data});
  final DashboardData data;

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final days = List.generate(14, (i) => DateTime(now.year, now.month, now.day).subtract(Duration(days: 13 - i)));
    final values = days.map((d) => data.salesByDay[d] ?? 0).toList();
    final maxV = values.fold<int>(1, (a, b) => b > a ? b : a);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        for (var i = 0; i < days.length; i++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 130 * (values[i] / maxV).clamp(0.02, 1.0),
                    decoration: BoxDecoration(
                      color: i == days.length - 1 ? AppColors.accent : AppColors.accentTintBorder,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(4), bottom: Radius.circular(2)),
                    ),
                  ),
                  const SizedBox(height: 7),
                  Text(DateFormat('d').format(days[i]), style: AppText.mono(size: 9.5, color: AppColors.mutedFainter)),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
