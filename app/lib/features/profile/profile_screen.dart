import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/security/roles.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../shared/widgets/buttons.dart';
import '../../shared/widgets/cards.dart';
import '../../shared/widgets/quick_add_dialog.dart';
import '../auth/auth_controller.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);
    if (user == null) return const SizedBox.shrink();
    final role = AppRole.fromDb(user.role);
    final hasPin = user.pinHash != null;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 640),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Profile', style: AppText.sans(size: 19, weight: FontWeight.w600, letterSpacing: -0.4)),
          const SizedBox(height: 4),
          Text('Your account on this device', style: AppText.sans(size: 12.5, color: AppColors.mutedInk)),
          const SizedBox(height: 16),
          SectionCard(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: AppColors.accentTint,
                  child: Text(user.initials, style: AppText.sans(size: 17, weight: FontWeight.w600, color: AppColors.accent)),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(user.displayName, style: AppText.sans(size: 16, weight: FontWeight.w600)),
                      const SizedBox(height: 3),
                      Text('@${user.username}', style: AppText.mono(size: 12.5, color: AppColors.mutedInk)),
                    ],
                  ),
                ),
                pillFor(role),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SectionCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                const SectionHeader(title: 'Account details'),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      _detailRow('Role', role.label),
                      _detailRow('Username', user.username),
                      _detailRow('Device', currentDeviceId),
                      _detailRow('User ID', user.id, mono: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          SectionCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                const SectionHeader(title: 'Quick-unlock PIN', trailing: 'device-local'),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hasPin
                            ? 'A PIN is set for quick sign-in on this device — use "Use PIN" on the login screen instead of typing your password.'
                            : 'No PIN set yet. Set one to sign in on this device with a short PIN instead of your full password.',
                        style: AppText.sans(size: 12.5, color: AppColors.mutedInk, height: 1.5),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          SecondaryButton(label: hasPin ? 'Change PIN' : 'Set PIN', onTap: () => _openPinDialog(context, ref)),
                          if (hasPin) ...[
                            const SizedBox(width: 8),
                            SecondaryButton(label: 'Remove PIN', onTap: () => ref.read(authControllerProvider.notifier).clearPin()),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: SecondaryButton(
              label: 'Log out',
              onTap: () {
                ref.read(authControllerProvider.notifier).signOut();
                context.go('/login');
              },
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  void _openPinDialog(BuildContext context, WidgetRef ref) {
    final pin = QuickField('NEW PIN (4-6 DIGITS)', keyboardType: TextInputType.number);
    final confirm = QuickField('CONFIRM PIN', keyboardType: TextInputType.number);
    showRecordFormDialog(
      context: context,
      title: 'Set quick-unlock PIN',
      submitLabel: 'Save',
      fields: [pin, confirm],
      onSubmit: () async {
        final p = pin.controller.text.trim();
        if (p.length < 4 || p.length > 6 || int.tryParse(p) == null) {
          throw 'PIN must be 4-6 digits.';
        }
        if (p != confirm.controller.text.trim()) throw 'PINs do not match.';
        await ref.read(authControllerProvider.notifier).setPin(p);
      },
    );
  }

  Widget _detailRow(String label, String value, {bool mono = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label, style: AppText.sans(size: 12.5, color: AppColors.mutedSoft))),
          Expanded(child: Text(value, style: mono ? AppText.mono(size: 12.5) : AppText.sans(size: 12.5, weight: FontWeight.w500))),
        ],
      ),
    );
  }

  Widget pillFor(AppRole role) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(color: AppColors.accentTint, borderRadius: BorderRadius.circular(999)),
      child: Text(role.label, style: AppText.sans(size: 11.5, weight: FontWeight.w600, color: AppColors.accent)),
    );
  }
}
