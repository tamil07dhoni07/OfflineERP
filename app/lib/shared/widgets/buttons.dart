import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';

class PrimaryButton extends StatefulWidget {
  const PrimaryButton({super.key, required this.label, this.onTap, this.height = 32, this.fontSize = 12.5});

  final String label;
  final VoidCallback? onTap;
  final double height;
  final double fontSize;

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: widget.height,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _hover ? AppColors.accentHover : AppColors.accent,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(
            widget.label,
            style: AppText.sans(size: widget.fontSize, weight: FontWeight.w600, color: AppColors.white),
          ),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({super.key, required this.label, this.onTap, this.height = 32});

  final String label;
  final VoidCallback? onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          height: height,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.card,
            border: Border.all(color: AppColors.controlBorder),
            borderRadius: BorderRadius.circular(7),
          ),
          child: Text(label, style: AppText.sans(size: 12.5)),
        ),
      ),
    );
  }
}
