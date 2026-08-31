import 'package:flutter/widgets.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';

enum CellAlign { left, right }

enum CellTone { plain, pill }

class Cell {
  const Cell.text(
    this.value, {
    this.align = CellAlign.left,
    this.color = AppColors.ink,
    this.mono = false,
    this.weight = FontWeight.w400,
  }) : tone = CellTone.plain,
       pillBg = null,
       pillFg = null;

  const Cell.pill(this.value, {required Color bg, required Color fg})
    : tone = CellTone.pill,
      pillBg = bg,
      pillFg = fg,
      align = CellAlign.left,
      color = AppColors.ink,
      mono = false,
      weight = FontWeight.w400;

  /// Right-aligned monospace number cell — the design's `N()` helper.
  factory Cell.number(String value, {Color color = AppColors.ink, FontWeight weight = FontWeight.w400}) {
    return Cell.text(value, align: CellAlign.right, color: color, mono: true, weight: weight);
  }

  final String value;
  final CellTone tone;
  final CellAlign align;
  final Color color;
  final bool mono;
  final FontWeight weight;
  final Color? pillBg;
  final Color? pillFg;

  TextStyle style() =>
      mono ? AppText.mono(color: color, weight: weight) : AppText.sans(color: color, weight: weight);
}

/// The five status tones used throughout the prototype's pills.
enum PillTone { paid, posted, draft, late, warn }

const _pillTones = <PillTone, (Color, Color)>{
  PillTone.paid: (AppColors.successTint, AppColors.successText),
  PillTone.posted: (AppColors.accentTint, AppColors.accent),
  PillTone.draft: (AppColors.draftTint, AppColors.mutedInk),
  PillTone.late: (AppColors.dangerTint, AppColors.danger),
  PillTone.warn: (AppColors.warnTint, AppColors.warnText),
};

Cell pillCell(PillTone tone, String label) {
  final (bg, fg) = _pillTones[tone]!;
  return Cell.pill(label, bg: bg, fg: fg);
}

class RowSpec {
  const RowSpec(
    this.cells, {
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.deleteTooltip = 'Delete',
    this.deleteConfirmTitle = 'Delete this record?',
    this.deleteConfirmMessage = 'This cannot be undone.',
  });
  final List<Cell> cells;

  /// Opens a detail page, edit dialog, etc. Rows without this stay
  /// non-interactive, same as before — nothing regresses just by adding it.
  final VoidCallback? onTap;

  /// When either is set, [ListScreen] renders a trailing actions column
  /// with an edit pencil and/or a delete trash icon for that row — visible
  /// buttons, not just a tappable row, per the explicit ask for edit/delete
  /// icons in every list. Leave both null for read-only rows (audit log,
  /// computed reports) — they simply get no actions column cell.
  final VoidCallback? onEdit;
  final Future<void> Function()? onDelete;

  /// Lets rows whose "delete" action is really something else — voiding a
  /// posted invoice, cancelling a PO — relabel the trash-icon tooltip and
  /// confirm dialog instead of pretending it's a plain delete.
  final String deleteTooltip;
  final String deleteConfirmTitle;
  final String deleteConfirmMessage;
}

class ColumnSpec {
  const ColumnSpec(this.label, {this.align = CellAlign.left});
  final String label;
  final CellAlign align;
}

class FilterSpec {
  const FilterSpec(this.label, this.value);
  final String label;
  final String value;
}

/// Everything a generic list screen needs to render — mirrors the `table`
/// object shape from the original prototype's `tables()` function.
class TableSpec {
  const TableSpec({
    required this.title,
    required this.subtitle,
    required this.devNote,
    required this.columns,
    required this.rows,
    required this.count,
    this.filters = const [],
    this.cta,
    this.onCta,
    this.note,
  });

  final String title;
  final String subtitle;
  final String devNote;
  final List<ColumnSpec> columns;
  final List<RowSpec> rows;
  final String count;
  final List<FilterSpec> filters;
  final String? cta;
  final VoidCallback? onCta;
  final String? note;
}
