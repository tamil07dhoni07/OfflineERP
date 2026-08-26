import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../core/providers.dart';
import '../../core/router/nav_data.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../../features/auth/auth_controller.dart';

final offlineProvider = StateProvider<bool>((ref) => true);

final draftInvoiceCountProvider = StreamProvider<int>((ref) {
  final db = ref.watch(databaseProvider);
  return (db.select(db.salesInvoices)..where((t) => t.status.equals('draft'))).watch().map((r) => r.length);
});

final belowReorderCountProvider = StreamProvider<int>((ref) {
  final db = ref.watch(databaseProvider);
  return db.select(db.products).watch().asyncMap((products) async {
    final levels = await ref.read(stockRepositoryProvider).onHandByProductWarehouse();
    final onHandByProduct = <String, int>{};
    for (final l in levels) {
      onHandByProduct[l.productId] = (onHandByProduct[l.productId] ?? 0) + l.onHand;
    }
    return products.where((p) => (onHandByProduct[p.id] ?? 0) < p.reorderLevel).length;
  });
});

class AppShell extends ConsumerWidget {
  const AppShell({super.key, required this.activeKey, required this.child});

  final String activeKey;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wide = MediaQuery.of(context).size.width >= 980;
    final sidebar = _Sidebar(activeKey: activeKey);

    return Scaffold(
      backgroundColor: AppColors.paper,
      drawer: wide ? null : Drawer(backgroundColor: AppColors.sidebar, width: 260, child: sidebar),
      body: Row(
        children: [
          if (wide) SizedBox(width: 236, child: sidebar),
          Expanded(
            child: Column(
              children: [
                Consumer(
                  builder: (context, ref, _) {
                    final offline = ref.watch(offlineProvider);
                    if (!offline) return const SizedBox.shrink();
                    return const _OfflineBanner();
                  },
                ),
                _TopBar(activeKey: activeKey, showMenuButton: !wide),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                    child: child,
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

class _OfflineBanner extends StatelessWidget {
  const _OfflineBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: AppColors.bannerFill,
        border: Border(bottom: BorderSide(color: AppColors.bannerBorder)),
      ),
      child: Row(
        children: [
          Text('Working offline', style: AppText.sans(size: 12, weight: FontWeight.w600, color: AppColors.bannerText)),
          const SizedBox(width: 14),
          Text(
            'All ERP data is already committed locally',
            style: AppText.sans(size: 12, color: AppColors.bannerTextSoft),
          ),
          const Spacer(),
          Text('grace period · 21 d remaining', style: AppText.mono(size: 11, color: AppColors.bannerTextSoft)),
        ],
      ),
    );
  }
}

class _TopBar extends ConsumerWidget {
  const _TopBar({required this.activeKey, required this.showMenuButton});
  final String activeKey;
  final bool showMenuButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);
    return Container(
      height: 52,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: const BoxDecoration(
        color: AppColors.card,
        border: Border(bottom: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          if (showMenuButton)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: () => Scaffold.of(context).openDrawer(),
                child: const Icon(Icons.menu, size: 20, color: AppColors.ink),
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                crumbFor[activeKey] ?? 'HOME',
                style: AppText.mono(size: 10, color: AppColors.mutedFainter, letterSpacing: 0.6),
              ),
              Text(
                titleFor[activeKey] ?? 'Dashboard',
                style: AppText.sans(size: 14.5, weight: FontWeight.w600, letterSpacing: -0.2),
              ),
            ],
          ),
          const Spacer(),
          Container(
            height: 31,
            width: 220,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: AppColors.fieldFill,
              border: Border.all(color: AppColors.controlBorder),
              borderRadius: BorderRadius.circular(7),
            ),
            child: Row(
              children: [
                Text('Search records', style: AppText.sans(size: 12.5, color: AppColors.mutedFaint)),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    border: Border.all(color: AppColors.controlBorder),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text('⌘K', style: AppText.mono(size: 10.5)),
                ),
              ],
            ),
          ),
          const SizedBox(width: 9),
          _Chip(label: 'Mumbai HQ ▾'),
          const SizedBox(width: 9),
          _Chip(label: 'FY 2026-27 ▾'),
          const SizedBox(width: 9),
          GestureDetector(
            onTap: () {
              ref.read(authControllerProvider.notifier).signOut();
              context.go('/login');
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: CircleAvatar(
                radius: 13.5,
                backgroundColor: AppColors.accentTint,
                child: Text(
                  user?.initials ?? '—',
                  style: AppText.sans(size: 11.5, weight: FontWeight.w600, color: AppColors.accent),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 31,
      padding: const EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.controlBorder),
        borderRadius: BorderRadius.circular(7),
      ),
      alignment: Alignment.center,
      child: Text(label, style: AppText.sans(size: 12.5)),
    );
  }
}

class _Sidebar extends ConsumerWidget {
  const _Sidebar({required this.activeKey});
  final String activeKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draftCount = ref.watch(draftInvoiceCountProvider).valueOrNull;
    final reorderCount = ref.watch(belowReorderCountProvider).valueOrNull;

    return Container(
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
                  decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(7)),
                  alignment: Alignment.center,
                  child: Text('N', style: AppText.sans(size: 13, weight: FontWeight.w700, color: AppColors.white)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nexus Traders',
                        overflow: TextOverflow.ellipsis,
                        style: AppText.sans(size: 12.5, weight: FontWeight.w600, color: AppColors.paper),
                      ),
                      Text('Mumbai HQ · FY 26-27', style: AppText.sans(size: 10.5, color: AppColors.mutedSoft)),
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
                for (final group in navGroups)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(9, 6, 9, 4),
                          child: Text(
                            group.label,
                            style: AppText.mono(size: 9.5, color: AppColors.sidebarGroupLabel, letterSpacing: 1.4),
                          ),
                        ),
                        for (final item in group.items)
                          _NavRow(
                            item: item,
                            active: item.key == activeKey || (activeKey == 'invoice-new' && item.key == 'invoices'),
                            liveBadge: item.key == 'invoices'
                                ? draftCount?.toString()
                                : item.key == 'stock'
                                ? reorderCount?.toString()
                                : null,
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: AppColors.sidebarBorder))),
            child: Consumer(
              builder: (context, ref, _) {
                final offline = ref.watch(offlineProvider);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: offline ? AppColors.warn : AppColors.success,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          offline ? 'Offline · local data authoritative' : 'Online · license validated 2 min ago',
                          style: AppText.sans(size: 11, color: AppColors.sidebarMuted),
                        ),
                      ],
                    ),
                    const SizedBox(height: 7),
                    Text('local db · backup 04:00', style: AppText.mono(size: 10, color: AppColors.sidebarFooterMuted)),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _NavRow extends StatefulWidget {
  const _NavRow({required this.item, required this.active, this.liveBadge});
  final NavItem item;
  final bool active;
  final String? liveBadge;

  @override
  State<_NavRow> createState() => _NavRowState();
}

class _NavRowState extends State<_NavRow> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final badge = widget.liveBadge ?? widget.item.badge;
    final showBadge = badge != null && badge != '0' && badge.isNotEmpty;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: () => context.go('/${widget.item.key}'),
        child: Container(
          height: 29,
          padding: const EdgeInsets.symmetric(horizontal: 9),
          margin: const EdgeInsets.only(bottom: 1),
          decoration: BoxDecoration(
            color: widget.active ? AppColors.accent : (_hover ? AppColors.sidebarHover : Colors.transparent),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: widget.active ? AppColors.sidebarDotActive : AppColors.sidebarDotInactive,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  widget.item.label,
                  overflow: TextOverflow.ellipsis,
                  style: AppText.sans(
                    size: 12.5,
                    weight: widget.active ? FontWeight.w600 : FontWeight.w400,
                    color: widget.active ? AppColors.paper : AppColors.sidebarItemFg,
                  ),
                ),
              ),
              if (showBadge) Text(badge, style: AppText.mono(size: 10, color: AppColors.mutedSoft)),
            ],
          ),
        ),
      ),
    );
  }
}
