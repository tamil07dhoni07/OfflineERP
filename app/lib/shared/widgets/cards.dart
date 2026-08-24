import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.child, this.padding = const EdgeInsets.all(15)});
  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, this.trailing});
  final String title;
  final String? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 13, 15, 12),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderSoft))),
      child: Row(
        children: [
          Text(title, style: AppText.sans(size: 13, weight: FontWeight.w600)),
          if (trailing != null) ...[
            const Spacer(),
            Text(trailing!, style: AppText.mono(size: 10.5, color: AppColors.mutedFainter)),
          ],
        ],
      ),
    );
  }
}

class KpiCard extends StatelessWidget {
  const KpiCard({super.key, required this.label, required this.value, required this.delta, required this.sub, required this.tone});
  final String label;
  final String value;
  final String delta;
  final String sub;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppText.sans(size: 11.5, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.4)),
          const SizedBox(height: 9),
          Text(value, style: AppText.mono(size: 23, weight: FontWeight.w600, color: AppColors.ink, letterSpacing: -0.4)),
          const SizedBox(height: 7),
          Row(
            children: [
              Text(delta, style: AppText.sans(size: 11.5, weight: FontWeight.w600, color: tone)),
              const SizedBox(width: 7),
              Flexible(child: Text(sub, overflow: TextOverflow.ellipsis, style: AppText.sans(size: 11.5, color: AppColors.mutedFaint))),
            ],
          ),
        ],
      ),
    );
  }
}
