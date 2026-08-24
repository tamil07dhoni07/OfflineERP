import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../shared/widgets/adaptive.dart';
import '../../shared/widgets/cards.dart';

class LicenseScreen extends ConsumerWidget {
  const LicenseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsAsync = ref.watch(appSettingsMapProvider);
    if (!settingsAsync.hasValue) return const Center(child: CircularProgressIndicator());
    final s = settingsAsync.value!;

    final licenseRows = [
      ('Client', 'Nexus Traders Pvt Ltd', AppColors.ink),
      ('Plan', s['license.plan'] ?? '—', AppColors.ink),
      ('Activated', s['license.activatedAt'] ?? '—', AppColors.ink),
      ('Expires', s['license.expiresAt'] ?? '—', AppColors.ink),
      ('Last revalidation', s['license.lastRevalidation']?.replaceFirst('T', ' ') ?? '—', AppColors.mutedInk),
      ('Offline grace remaining', '${s['license.offlineGraceDays'] ?? '—'} days', AppColors.warnText),
    ];

    const modules = [
      ('Sales', true), ('Purchasing', true), ('Inventory', true), ('Accounting', true),
      ('GST & returns', true), ('HR', true), ('Payroll', true), ('Reports', true),
      ('Manufacturing', false), ('POS', false), ('E-way bill', false),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionCard(
          padding: const EdgeInsets.all(16),
          child: AdaptiveColumns(
            flexes: const [11, 10],
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                        decoration: BoxDecoration(color: AppColors.successTint, borderRadius: BorderRadius.circular(999)),
                        child: Text(
                          s['license.status'] ?? 'ACTIVE',
                          style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.successText),
                        ),
                      ),
                      const SizedBox(width: 9),
                      Text(s['license.key'] ?? '—', style: AppText.mono(size: 11.5, color: AppColors.mutedSoft)),
                    ],
                  ),
                  const SizedBox(height: 12),
                  for (final r in licenseRows)
                    Container(
                      padding: const EdgeInsets.only(bottom: 7),
                      margin: const EdgeInsets.only(bottom: 7),
                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderRow))),
                      child: Row(
                        children: [
                          Text(r.$1, style: AppText.sans(size: 12.5, color: AppColors.mutedInk)),
                          const Spacer(),
                          Text(r.$2, style: AppText.mono(size: 12.5, weight: FontWeight.w500, color: r.$3)),
                        ],
                      ),
                    ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Enabled modules', style: AppText.sans(size: 13, weight: FontWeight.w600)),
                  const SizedBox(height: 11),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: [
                      for (final m in modules)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: m.$2 ? AppColors.accentTint : AppColors.moduleOffTint,
                            border: Border.all(color: m.$2 ? AppColors.accentTintBorder : AppColors.moduleOffBorder),
                            borderRadius: BorderRadius.circular(999),
                          ),
                          child: Text(
                            m.$1,
                            style: AppText.sans(size: 11.5, color: m.$2 ? AppColors.accent : AppColors.moduleOffText),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 11),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                    decoration: BoxDecoration(
                      color: AppColors.fieldFill,
                      border: Border.all(color: AppColors.borderSoft),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Feature flags are pulled from the control plane at activation and cached locally. Disabling a module in Super Admin takes effect at the next successful revalidation — never mid-session.',
                      style: AppText.sans(size: 11.5, color: AppColors.mutedInk, height: 1.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SectionCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(15, 13, 15, 12),
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderSoft))),
                child: Row(
                  children: [
                    Text('Registered devices', style: AppText.sans(size: 13, weight: FontWeight.w600)),
                    const SizedBox(width: 10),
                    Text('1 of 5 seats used', style: AppText.mono(size: 10.5, color: AppColors.mutedFainter)),
                    const Spacer(),
                    Container(
                      height: 29,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        color: AppColors.fieldFill,
                        border: Border.all(color: AppColors.controlBorder),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      alignment: Alignment.center,
                      child: Text('Revalidate now', style: AppText.sans(size: 12)),
                    ),
                  ],
                ),
              ),
              _DeviceRow(id: s['device.id'] ?? 'WIN-MUM-04', platform: s['device.platform'] ?? 'Windows 11 · desktop', user: 'r.deshmukh'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        SectionCard(
          child: AdaptiveGrid(
            columns: 3,
            minTileWidth: 200,
            children: [
              _BackupCard('LAST BACKUP', (s['backup.lastAt'] ?? '—').replaceFirst('T', ' '), 'Encrypted, compressed, uploaded to Drive'),
              const _BackupCard('RETENTION', '14 versions', 'Daily for 14 days, then monthly for 12 months'),
              const _BackupCard('LAST RESTORE TEST', 'Not yet run', 'Restore/verify flow isn\'t wired in this build'),
            ],
          ),
        ),
      ],
    );
  }
}

class _DeviceRow extends StatelessWidget {
  const _DeviceRow({required this.id, required this.platform, required this.user});
  final String id;
  final String platform;
  final String user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Expanded(flex: 2, child: Text(id, style: AppText.mono(size: 12.5, weight: FontWeight.w500))),
          Expanded(flex: 2, child: Text(platform, style: AppText.sans(size: 12.5))),
          Expanded(child: Text(user, style: AppText.sans(size: 12.5))),
          Expanded(child: _pill('Active')),
          Text('Revoke', style: AppText.sans(size: 12, color: AppColors.danger)),
        ],
      ),
    );
  }

  Widget _pill(String label) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
    decoration: BoxDecoration(color: AppColors.successTint, borderRadius: BorderRadius.circular(999)),
    child: Text(label, style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.successText)),
  );
}

class _BackupCard extends StatelessWidget {
  const _BackupCard(this.label, this.value, this.sub);
  final String label;
  final String value;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(label, style: AppText.sans(size: 11.5, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.4)),
        const SizedBox(height: 7),
        Text(value, style: AppText.mono(size: 15, weight: FontWeight.w600)),
        const SizedBox(height: 7),
        Text(sub, style: AppText.sans(size: 11.5, color: AppColors.mutedFaint, height: 1.5)),
      ],
    );
  }
}
