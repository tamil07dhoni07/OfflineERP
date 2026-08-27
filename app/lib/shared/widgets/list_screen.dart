import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../export/table_export.dart';
import '../models/table_spec.dart';
import 'buttons.dart';

/// Renders a full list screen (header, filter chips, data table, pager,
/// footnote) from a [TableSpec] — the Flutter equivalent of the prototype's
/// `sc-if value="{{ table }}"` block.
class ListScreen extends StatelessWidget {
  const ListScreen({super.key, required this.spec, this.dense = false});

  final TableSpec spec;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1320),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              // Export/Print are secondary on a phone: drop them rather
              // than let a long CTA label ("Generate GSTR-3B", "New payroll
              // run") push the header past the screen edge.
              final compact = constraints.maxWidth < 520;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(spec.title, style: AppText.sans(size: 19, weight: FontWeight.w600, letterSpacing: -0.4)),
                        const SizedBox(height: 4),
                        Text(spec.subtitle, style: AppText.sans(size: 12.5, color: AppColors.mutedInk)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  if (!compact) ...[
                    SecondaryButton(label: 'Export', onTap: () => exportTableCsv(spec)),
                    const SizedBox(width: 8),
                    SecondaryButton(label: 'Print', onTap: () => printTablePdf(spec)),
                  ] else
                    SecondaryButton(label: 'Export', onTap: () => showExportMenu(context, spec)),
                  if (spec.cta != null) ...[
                    const SizedBox(width: 8),
                    PrimaryButton(label: spec.cta!, onTap: spec.onCta),
                  ],
                ],
              );
            },
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [for (final f in spec.filters) _FilterChip(f)],
              ),
              const Spacer(),
              if (spec.devNote.isNotEmpty) _DevNote(spec.devNote),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: AppColors.card,
              border: Border.all(color: AppColors.border),
              borderRadius: BorderRadius.circular(10),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _DataTable(spec: spec, dense: dense),
                ),
                Container(
                  height: 41,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: const BoxDecoration(
                    color: AppColors.fieldFill,
                    border: Border(top: BorderSide(color: AppColors.border)),
                  ),
                  child: Row(
                    children: [
                      Text(spec.count, style: AppText.mono(size: 11, color: AppColors.mutedSoft)),
                      const Spacer(),
                      const _PagerButton('Prev', enabled: false),
                      const SizedBox(width: 6),
                      const _PagerButton('Next', enabled: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (spec.note != null) ...[
            const SizedBox(height: 12),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Text(
                spec.note!,
                style: AppText.sans(size: 12, color: AppColors.mutedSoft, height: 1.6),
              ),
            ),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _DataTable extends StatelessWidget {
  const _DataTable({required this.spec, required this.dense});
  final TableSpec spec;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final rowHeight = dense ? 34.0 : 40.0;
    final widths = <int, TableColumnWidth>{
      for (var i = 0; i < spec.columns.length; i++) i: const IntrinsicColumnWidth(),
    };
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: widths,
      children: [
        TableRow(
          decoration: const BoxDecoration(color: AppColors.fieldFill),
          children: [
            for (final c in spec.columns)
              Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 14),
                alignment: c.align == CellAlign.right ? Alignment.centerRight : Alignment.centerLeft,
                decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.border))),
                child: Text(
                  c.label,
                  softWrap: false,
                  style: AppText.sans(size: 11, weight: FontWeight.w600, color: AppColors.mutedInk, letterSpacing: 0.5),
                ),
              ),
          ],
        ),
        for (final row in spec.rows)
          TableRow(
            children: [
              for (final cell in row.cells)
                _RowCell(
                  height: rowHeight,
                  align: cell.align,
                  onTap: row.onTap,
                  child: cell.tone == CellTone.pill
                      ? _Pill(cell)
                      : Text(cell.value, softWrap: false, style: cell.style()),
                ),
            ],
          ),
      ],
    );
  }
}

class _RowCell extends StatefulWidget {
  const _RowCell({required this.height, required this.align, required this.child, this.onTap});
  final double height;
  final CellAlign align;
  final Widget child;
  final VoidCallback? onTap;

  @override
  State<_RowCell> createState() => _RowCellState();
}

class _RowCellState extends State<_RowCell> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    final content = Container(
      height: widget.height,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      alignment: widget.align == CellAlign.right ? Alignment.centerRight : Alignment.centerLeft,
      decoration: BoxDecoration(
        color: _hover && widget.onTap != null ? AppColors.fieldFill : null,
        border: const Border(bottom: BorderSide(color: AppColors.borderFaint)),
      ),
      child: widget.child,
    );
    if (widget.onTap == null) return content;
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(onTap: widget.onTap, child: content),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill(this.cell);
  final Cell cell;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(color: cell.pillBg, borderRadius: BorderRadius.circular(999)),
      child: Text(cell.value, style: AppText.sans(size: 11, weight: FontWeight.w600, color: cell.pillFg!)),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip(this.filter);
  final FilterSpec filter;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 11),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.controlBorder),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(filter.label, style: AppText.sans(size: 12, color: AppColors.mutedFaint)),
          const SizedBox(width: 7),
          Text(filter.value, style: AppText.sans(size: 12, weight: FontWeight.w500)),
          const SizedBox(width: 7),
          const Text('▾', style: TextStyle(color: AppColors.placeholder, fontSize: 11)),
        ],
      ),
    );
  }
}

class _DevNote extends StatelessWidget {
  const _DevNote(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(color: AppColors.devNoteTint, borderRadius: BorderRadius.circular(6)),
      child: Text(text, style: AppText.mono(size: 10.5, color: AppColors.mutedFainter)),
    );
  }
}

class _PagerButton extends StatelessWidget {
  const _PagerButton(this.label, {required this.enabled});
  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border.all(color: AppColors.controlBorder),
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Text(label, style: AppText.sans(size: 11.5, color: enabled ? AppColors.ink : AppColors.mutedFaint)),
    );
  }
}
