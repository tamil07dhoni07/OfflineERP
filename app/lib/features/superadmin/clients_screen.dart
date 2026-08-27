import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/database/app_database.dart';
import '../../core/providers.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../shared/models/table_spec.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/widgets/list_screen.dart';
import '../auth/auth_controller.dart';

final clientsProvider = StreamProvider((ref) => ref.watch(superAdminRepositoryProvider).watchClients());

const _clientStatusTone = {'active': PillTone.paid, 'suspended': PillTone.warn, 'deactivated': PillTone.late};

class ClientsScreen extends ConsumerWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(clientsProvider);

    return async.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, st) => Text('Failed to load clients: $e'),
      data: (clients) {
        return FutureBuilder<List<(Client, ClientLicense?)>>(
          future: _withLicenses(ref, clients),
          builder: (context, snap) {
            if (!snap.hasData) return const Center(child: CircularProgressIndicator());
            final rows = snap.data!.map((pair) {
              final (client, license) = pair;
              return RowSpec([
                Cell.text(client.companyName, weight: FontWeight.w500),
                Cell.text(client.contactEmail, color: AppColors.mutedInk),
                Cell.text(license?.plan ?? '—'),
                Cell.text(license?.licenseKey ?? '—', mono: true, color: AppColors.mutedInk),
                Cell.text(license == null ? '—' : _fmtDate(license.expiresAt), mono: true, color: AppColors.mutedInk),
                pillCell(_clientStatusTone[client.status] ?? PillTone.draft, client.status[0].toUpperCase() + client.status.substring(1)),
              ], onTap: () => showDialog(context: context, builder: (_) => _ClientDetailDialog(client: client, license: license)));
            }).toList();

            final spec = TableSpec(
              title: 'Clients & Licenses',
              subtitle: 'Every tenant on this control plane · tap a row to manage',
              devNote: 'super_admin · clients · client_licenses · client_devices',
              filters: const [FilterSpec('Status', 'All')],
              columns: const [
                ColumnSpec('COMPANY'),
                ColumnSpec('CONTACT'),
                ColumnSpec('PLAN'),
                ColumnSpec('LICENSE KEY'),
                ColumnSpec('EXPIRES'),
                ColumnSpec('STATUS'),
              ],
              rows: rows,
              count: '${rows.length} client(s)',
              cta: 'New client',
              onCta: () => showDialog(context: context, builder: (_) => const _NewClientDialog()),
              note: 'This runs against the local demo store described in the sidebar — real Super Admin data belongs in Firebase, '
                  'shared across every client and device rather than one client\'s own local database.',
            );
            return ListScreen(spec: spec);
          },
        );
      },
    );
  }

  Future<List<(Client, ClientLicense?)>> _withLicenses(WidgetRef ref, List<Client> clients) async {
    final repo = ref.read(superAdminRepositoryProvider);
    final result = <(Client, ClientLicense?)>[];
    for (final c in clients) {
      result.add((c, await repo.licenseFor(c.id)));
    }
    return result;
  }
}

String _fmtDate(DateTime d) {
  const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
  return '${d.day.toString().padLeft(2, '0')} ${months[d.month - 1]} ${d.year}';
}

class _ClientDetailDialog extends ConsumerWidget {
  const _ClientDetailDialog({required this.client, required this.license});
  final Client client;
  final ClientLicense? license;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actor = ref.watch(authControllerProvider)?.username ?? 'unknown';
    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480, maxHeight: 620),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(client.companyName, style: AppText.sans(size: 16, weight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(client.contactEmail, style: AppText.sans(size: 12, color: AppColors.mutedInk)),
              const SizedBox(height: 16),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('CLIENT STATUS', style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          if (client.status != 'active')
                            _ActionChip(
                              label: 'Activate',
                              onTap: () => ref.read(superAdminRepositoryProvider).setClientStatus(client.id, 'active', actor: actor, device: currentDeviceId),
                            ),
                          if (client.status == 'active')
                            _ActionChip(
                              label: 'Suspend',
                              danger: true,
                              onTap: () => ref.read(superAdminRepositoryProvider).setClientStatus(client.id, 'suspended', actor: actor, device: currentDeviceId),
                            ),
                          const SizedBox(width: 8),
                          _ActionChip(
                            label: 'Deactivate',
                            danger: true,
                            onTap: () => ref.read(superAdminRepositoryProvider).setClientStatus(client.id, 'deactivated', actor: actor, device: currentDeviceId),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      if (license != null) ...[
                        Text('LICENSE', style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
                        const SizedBox(height: 8),
                        _kv('Key', license!.licenseKey, mono: true),
                        _kv('Plan', license!.plan),
                        _kv('Status', license!.status),
                        _kv('Activated', _fmtDate(license!.activatedAt)),
                        _kv('Expires', _fmtDate(license!.expiresAt)),
                        _kv('Max devices', '${license!.maxDevices}'),
                        _kv('Enabled modules', license!.enabledModulesCsv.replaceAll(',', ', ')),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            if (license!.status != 'active')
                              _ActionChip(
                                label: 'Activate license',
                                onTap: () => ref.read(superAdminRepositoryProvider).setLicenseStatus(license!.id, 'active', actor: actor, device: currentDeviceId),
                              ),
                            if (license!.status == 'active')
                              _ActionChip(
                                label: 'Suspend license',
                                danger: true,
                                onTap: () => ref.read(superAdminRepositoryProvider).setLicenseStatus(license!.id, 'suspended', actor: actor, device: currentDeviceId),
                              ),
                            const SizedBox(width: 8),
                            _ActionChip(
                              label: 'Revoke license',
                              danger: true,
                              onTap: () => ref.read(superAdminRepositoryProvider).setLicenseStatus(license!.id, 'revoked', actor: actor, device: currentDeviceId),
                            ),
                            const SizedBox(width: 8),
                            _ActionChip(
                              label: 'Renew +1y',
                              onTap: () => ref
                                  .read(superAdminRepositoryProvider)
                                  .renewLicense(license!.id, DateTime.now().add(const Duration(days: 365)), actor: actor, device: currentDeviceId),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                      Text('DEVICES', style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
                      const SizedBox(height: 8),
                      FutureBuilder<List<ClientDevice>>(
                        future: ref.read(superAdminRepositoryProvider).devicesFor(client.id),
                        builder: (context, snap) {
                          if (!snap.hasData) return const LinearProgressIndicator();
                          final devices = snap.data!;
                          if (devices.isEmpty) return Text('No registered devices.', style: AppText.sans(size: 12.5, color: AppColors.mutedInk));
                          return Column(
                            children: [
                              for (final d in devices)
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(d.deviceId, style: AppText.mono(size: 12, weight: FontWeight.w500)),
                                            Text(d.platform, style: AppText.sans(size: 10.5, color: AppColors.mutedFaint)),
                                          ],
                                        ),
                                      ),
                                      if (d.status == 'active')
                                        _ActionChip(
                                          label: 'Revoke',
                                          danger: true,
                                          small: true,
                                          onTap: () => ref.read(superAdminRepositoryProvider).revokeDevice(d.id, actor: actor, device: currentDeviceId),
                                        )
                                      else
                                        Text('Revoked', style: AppText.sans(size: 11.5, color: AppColors.danger)),
                                    ],
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 14),
              Align(alignment: Alignment.centerRight, child: SecondaryButton(label: 'Close', onTap: () => Navigator.of(context).pop())),
            ],
          ),
        ),
      ),
    );
  }

  Widget _kv(String label, String value, {bool mono = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: AppText.sans(size: 12, color: AppColors.mutedInk)),
          const Spacer(),
          Text(value, style: mono ? AppText.mono(size: 12) : AppText.sans(size: 12, weight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _ActionChip extends StatefulWidget {
  const _ActionChip({required this.label, required this.onTap, this.danger = false, this.small = false});
  final String label;
  final Future<void> Function() onTap;
  final bool danger;
  final bool small;

  @override
  State<_ActionChip> createState() => _ActionChipState();
}

class _ActionChipState extends State<_ActionChip> {
  bool _busy = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _busy
          ? null
          : () async {
              setState(() => _busy = true);
              await widget.onTap();
              if (mounted) setState(() => _busy = false);
            },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: widget.small ? 9 : 12, vertical: widget.small ? 5 : 7),
        decoration: BoxDecoration(
          color: widget.danger ? AppColors.dangerTint : AppColors.accentTint,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Text(
          _busy ? '…' : widget.label,
          style: AppText.sans(size: widget.small ? 11 : 12, weight: FontWeight.w600, color: widget.danger ? AppColors.danger : AppColors.accent),
        ),
      ),
    );
  }
}

const _availableModules = ['Sales', 'Purchasing', 'Inventory', 'Accounting', 'GST & returns', 'HR', 'Payroll', 'Reports'];

class _NewClientDialog extends ConsumerStatefulWidget {
  const _NewClientDialog();

  @override
  ConsumerState<_NewClientDialog> createState() => _NewClientDialogState();
}

class _NewClientDialogState extends ConsumerState<_NewClientDialog> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _plan = TextEditingController(text: 'Business · 5 devices');
  final _maxDevices = TextEditingController(text: '5');
  final Set<String> _modules = {..._availableModules};
  bool _submitting = false;
  String? _error;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.card,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('New client', style: AppText.sans(size: 16, weight: FontWeight.w600)),
              const SizedBox(height: 16),
              _field('COMPANY NAME', _name),
              const SizedBox(height: 12),
              _field('CONTACT EMAIL', _email),
              const SizedBox(height: 12),
              _field('PLAN', _plan),
              const SizedBox(height: 12),
              _field('MAX DEVICES', _maxDevices, keyboardType: TextInputType.number),
              const SizedBox(height: 12),
              Text('ENABLED MODULES', style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
              const SizedBox(height: 6),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: [
                  for (final m in _availableModules)
                    GestureDetector(
                      onTap: () => setState(() => _modules.contains(m) ? _modules.remove(m) : _modules.add(m)),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: _modules.contains(m) ? AppColors.accent : AppColors.fieldFill,
                          border: Border.all(color: _modules.contains(m) ? AppColors.accent : AppColors.controlBorder),
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(m, style: AppText.sans(size: 11.5, weight: FontWeight.w600, color: _modules.contains(m) ? AppColors.white : AppColors.ink)),
                      ),
                    ),
                ],
              ),
              if (_error != null) ...[
                const SizedBox(height: 10),
                Text(_error!, style: AppText.sans(size: 12, color: AppColors.danger)),
              ],
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SecondaryButton(label: 'Cancel', onTap: _submitting ? null : () => Navigator.of(context).pop()),
                  const SizedBox(width: 8),
                  PrimaryButton(label: _submitting ? 'Creating…' : 'Create client', onTap: _submitting ? null : _submit),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async {
    if (_name.text.trim().isEmpty || _email.text.trim().isEmpty) {
      setState(() => _error = 'Company name and contact email are required.');
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      await ref
          .read(superAdminRepositoryProvider)
          .createClient(
            companyName: _name.text.trim(),
            contactEmail: _email.text.trim(),
            plan: _plan.text.trim(),
            maxDevices: int.tryParse(_maxDevices.text.trim()) ?? 1,
            enabledModules: _modules.toList(),
            actor: ref.read(authControllerProvider)?.username ?? 'unknown',
            device: currentDeviceId,
          );
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      setState(() {
        _error = '$e';
        _submitting = false;
      });
    }
  }

  Widget _field(String label, TextEditingController controller, {TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5)),
        const SizedBox(height: 5),
        Container(
          height: 38,
          padding: const EdgeInsets.symmetric(horizontal: 11),
          decoration: BoxDecoration(color: AppColors.fieldFill, border: Border.all(color: AppColors.fieldBorder), borderRadius: BorderRadius.circular(7)),
          child: TextField(
            controller: controller,
            keyboardType: keyboardType,
            style: AppText.sans(size: 13),
            decoration: const InputDecoration(border: InputBorder.none, isDense: true, filled: false),
          ),
        ),
      ],
    );
  }
}
