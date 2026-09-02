import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../core/backup/drive_backup_service.dart';
import '../../core/database/app_database.dart';
import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../shared/widgets/adaptive.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/widgets/cards.dart';
import '../../shared/widgets/quick_add_dialog.dart';

class _Row {
  const _Row(this.label, this.value, {this.mono = false});
  final String label;
  final String value;
  final bool mono;
}

class _Section {
  const _Section(this.title, this.table, this.rows, {this.onEdit});
  final String title;
  final String table;
  final List<_Row> rows;
  final VoidCallback? onEdit;
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
      ], onEdit: () => _editCompany(context, ref, company)),
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
        const _Row('Roles', 'Admin, Accountant, Sales, Store, HR, Auditor · Super Admin (control plane, separate)'),
        const _Row('Session timeout', '30 minutes idle'),
        const _Row('Password policy', 'PBKDF2-SHA256, 120k iterations'),
        const _Row('Quick PIN login', 'Not yet wired'),
      ]),
    ];

    return AdaptiveGrid(
      columns: 2,
      minTileWidth: 420,
      children: [for (final s in sections) _SectionCardView(s), const _BackupSyncCard()],
    );
  }

  void _editCompany(BuildContext context, WidgetRef ref, Company company) {
    final legalName = QuickField('LEGAL NAME', initial: company.legalName);
    final gstin = QuickField('GSTIN', initial: company.gstin);
    final pan = QuickField('PAN', initial: company.pan);
    final state = QuickField('STATE', initial: company.state);
    final stateCode = QuickField('STATE CODE', initial: company.stateCode);

    showRecordFormDialog(
      context: context,
      title: 'Edit company',
      submitLabel: 'Save',
      fields: [legalName, gstin, pan, state, stateCode],
      onSubmit: () async {
        if (legalName.controller.text.trim().isEmpty) throw 'Legal name is required';
        await ref
            .read(masterDataRepositoryProvider)
            .updateCompany(
              company.id,
              legalName: legalName.controller.text.trim(),
              gstin: gstin.controller.text.trim(),
              pan: pan.controller.text.trim(),
              state: state.controller.text.trim(),
              stateCode: stateCode.controller.text.trim(),
            );
      },
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
                if (section.onEdit != null)
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: section.onEdit,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Text('Edit', style: AppText.sans(size: 12, weight: FontWeight.w600, color: AppColors.accent)),
                      ),
                    ),
                  ),
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

/// Google Drive backup — private "app data" storage tied to whoever signs
/// in, not visible in their regular Drive. See DriveBackupService for the
/// exact semantics of Sync / Upload / Download, and for why Google sign-in
/// won't succeed yet: the Firebase project has no OAuth client registered
/// for either platform.
class _BackupSyncCard extends ConsumerStatefulWidget {
  const _BackupSyncCard();

  @override
  ConsumerState<_BackupSyncCard> createState() => _BackupSyncCardState();
}

enum _BackupBusy { none, signIn, sync, upload, download }

class _BackupSyncCardState extends ConsumerState<_BackupSyncCard> {
  _BackupBusy _busy = _BackupBusy.none;
  String? _status;
  String? _error;
  DateTime? _remoteBackupTime;

  Future<void> _run(_BackupBusy which, Future<void> Function() action, {String? successMessage}) async {
    setState(() {
      _busy = which;
      _error = null;
    });
    try {
      await action();
      if (mounted) setState(() => _status = successMessage);
    } catch (e) {
      if (mounted) setState(() => _error = '$e');
    } finally {
      if (mounted) setState(() => _busy = _BackupBusy.none);
    }
  }

  Future<void> _signIn() => _run(_BackupBusy.signIn, () async {
    await DriveBackupService.signIn();
  });

  Future<void> _signOut() => _run(_BackupBusy.none, () async {
    await DriveBackupService.signOut();
    setState(() {
      _remoteBackupTime = null;
      _status = null;
    });
  });

  Future<void> _upload() => _run(_BackupBusy.upload, () async {
    await DriveBackupService.upload(ref.read(databaseProvider));
    _remoteBackupTime = await DriveBackupService.remoteBackupTime();
  }, successMessage: 'Uploaded to Google Drive.');

  Future<void> _download() => _run(_BackupBusy.download, () async {
    final staged = await DriveBackupService.downloadToStaging();
    if (!staged) throw 'No backup found on Google Drive yet.';
  }, successMessage: 'Downloaded — restart the app to finish applying this backup.');

  Future<void> _sync() => _run(_BackupBusy.sync, () async {
    final result = await DriveBackupService.sync(ref.read(databaseProvider));
    if (result.direction == 'uploaded') {
      _remoteBackupTime = await DriveBackupService.remoteBackupTime();
    }
    _status = result.restartRequired
        ? 'Synced (downloaded newer backup) — restart the app to finish applying it.'
        : 'Synced (this device was already the newest copy — uploaded).';
  });

  @override
  Widget build(BuildContext context) {
    final account = DriveBackupService.signedInAccount;
    final busy = _busy != _BackupBusy.none;

    return SectionCard(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          const SectionHeader(title: 'Backup & Sync', trailing: 'Google Drive · app-private storage'),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (kIsWeb)
                  Text(
                    'Not available on web — Drive backup works on the desktop and mobile app.',
                    style: AppText.sans(size: 12.5, color: AppColors.mutedInk, height: 1.5),
                  )
                else if (account == null) ...[
                  Text(
                    'Sign in with the Google account this device should back up to and restore from.',
                    style: AppText.sans(size: 12.5, color: AppColors.mutedInk, height: 1.5),
                  ),
                  const SizedBox(height: 10),
                  SecondaryButton(
                    label: _busy == _BackupBusy.signIn ? 'Signing in…' : 'Sign in with Google',
                    onTap: busy ? null : _signIn,
                  ),
                ] else ...[
                  Row(
                    children: [
                      Expanded(
                        child: Text(account.email, style: AppText.sans(size: 12.5, weight: FontWeight.w500)),
                      ),
                      GestureDetector(
                        onTap: busy ? null : _signOut,
                        child: Text('Sign out', style: AppText.sans(size: 12, color: AppColors.mutedInk)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      PrimaryButton(label: _busy == _BackupBusy.sync ? 'Syncing…' : 'Sync', onTap: busy ? null : _sync),
                      SecondaryButton(
                        label: _busy == _BackupBusy.upload ? 'Uploading…' : 'Upload only',
                        onTap: busy ? null : _upload,
                      ),
                      SecondaryButton(
                        label: _busy == _BackupBusy.download ? 'Downloading…' : 'Download only',
                        onTap: busy ? null : _download,
                      ),
                    ],
                  ),
                  if (_remoteBackupTime != null) ...[
                    const SizedBox(height: 10),
                    Text(
                      'Last backup on Drive: ${DateFormat('d MMM yyyy, HH:mm').format(_remoteBackupTime!.toLocal())}',
                      style: AppText.sans(size: 11.5, color: AppColors.mutedFaint),
                    ),
                  ],
                ],
                if (_status != null) ...[
                  const SizedBox(height: 10),
                  Text(_status!, style: AppText.sans(size: 12, color: AppColors.successText, height: 1.4)),
                ],
                if (_error != null) ...[
                  const SizedBox(height: 10),
                  Text(_error!, style: AppText.sans(size: 12, color: AppColors.danger, height: 1.4)),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
