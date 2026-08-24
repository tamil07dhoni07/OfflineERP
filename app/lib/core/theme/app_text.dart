import 'package:flutter/widgets.dart';

import 'app_colors.dart';

/// Font family handles for the design's two typefaces.
abstract final class AppFonts {
  static const sans = 'IBM Plex Sans';
  static const mono = 'IBM Plex Mono';
}

/// Reusable text styles matching the exact sizes/weights used across the
/// prototype's inline styles.
abstract final class AppText {
  static const base = TextStyle(fontFamily: AppFonts.sans, color: AppColors.ink);

  static TextStyle sans({
    double size = 12.5,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.ink,
    double? letterSpacing,
    double? height,
  }) => TextStyle(
    fontFamily: AppFonts.sans,
    fontSize: size,
    fontWeight: weight,
    color: color,
    letterSpacing: letterSpacing,
    height: height,
  );

  static TextStyle mono({
    double size = 12.5,
    FontWeight weight = FontWeight.w400,
    Color color = AppColors.ink,
    double? letterSpacing,
  }) => TextStyle(
    fontFamily: AppFonts.mono,
    fontSize: size,
    fontWeight: weight,
    color: color,
    letterSpacing: letterSpacing,
  );
}
