import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../features/auth/auth_controller.dart';

/// The Super Admin console's own shell — deliberately not [AppShell]. Per
/// the spec, Super Admin is "a separate Super Admin application/interface"
/// that manages clients/licenses/devices and must never reach a client's
/// private ERP screens; giving it a visually distinct frame (no ERP nav
/// groups, a different sidebar heading) makes that separation obvious to
/// whoever's using it, not just enforced in the router.
class SuperAdminShell extends ConsumerWidget {
  const SuperAdminShell({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);
    return Scaffold(
      backgroundColor: AppColors.paper,
      body: Row(
        children: [
          SafeArea(
            right: false,
            bottom: false,
            child: Container(
              width: 220,
              color: AppColors.sidebar,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.sidebarBorder))),
                    child: Row(
                      children: [
                        Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(color: AppColors.warn, borderRadius: BorderRadius.circular(7)),
                          alignment: Alignment.center,
                          child: Text('N', style: AppText.sans(size: 13, weight: FontWeight.w700, color: AppColors.white)),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Super Admin', style: AppText.sans(size: 12.5, weight: FontWeight.w600, color: AppColors.paper)),
                              Text('Control plane', style: AppText.sans(size: 10.5, color: AppColors.mutedSoft)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(8, 10, 8, 16),
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(9, 6, 9, 4),
                          child: Text('CLIENTS', style: AppText.mono(size: 9.5, color: AppColors.sidebarGroupLabel, letterSpacing: 1.4)),
                        ),
                        _NavRow(label: 'Clients & Licenses', active: true, onTap: () => context.go('/admin/clients')),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
                    decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.sidebarBorder))),
                    child: Text(
                      'Local demo store · will move to Firebase',
                      style: AppText.sans(size: 10.5, color: AppColors.sidebarMuted),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SafeArea(
              left: false,
              child: Column(
                children: [
                  Container(
                    height: 52,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(color: AppColors.card, border: Border(bottom: BorderSide(color: AppColors.border))),
                    child: Row(
                      children: [
                        Text('Super Admin Console', style: AppText.sans(size: 14.5, weight: FontWeight.w600, letterSpacing: -0.2)),
                        const Spacer(),
                        Text(user?.displayName ?? '—', style: AppText.sans(size: 12.5, color: AppColors.mutedInk)),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            ref.read(authControllerProvider.notifier).signOut();
                            context.go('/login');
                          },
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: CircleAvatar(
                              radius: 13.5,
                              backgroundColor: AppColors.warnTint,
                              child: Text(
                                user?.initials ?? '—',
                                style: AppText.sans(size: 11.5, weight: FontWeight.w600, color: AppColors.warnText),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(child: SingleChildScrollView(padding: const EdgeInsets.fromLTRB(20, 20, 20, 40), child: child)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavRow extends StatelessWidget {
  const _NavRow({required this.label, required this.active, required this.onTap});
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          height: 29,
          padding: const EdgeInsets.symmetric(horizontal: 9),
          decoration: BoxDecoration(color: active ? AppColors.warn : Colors.transparent, borderRadius: BorderRadius.circular(6)),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.sans(size: 12.5, weight: active ? FontWeight.w600 : FontWeight.w400, color: active ? AppColors.ink : AppColors.sidebarItemFg),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
