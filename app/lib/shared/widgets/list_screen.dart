import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text.dart';
import '../export/table_export.dart';
import '../models/table_spec.dart';
import 'buttons.dart';

/// Renders a full list screen (header, filter chips, data table, pager,
/// footnote) from a [TableSpec] — the Flutter equivalent of the prototype's
/// `sc-if value="{{ table }}"` block.
class ListScreen extends StatefulWidget {
  const ListScreen({super.key, required this.spec, this.dense = false});

  final TableSpec spec;
  final bool dense;

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spec = widget.spec;
    final dense = widget.dense;
    final filteredRows = _query.isEmpty
        ? spec.rows
        : spec.rows.where((r) => r.cells.any((c) => c.value.toLowerCase().contains(_query))).toList();
    final count = _query.isEmpty ? spec.count : '${filteredRows.length} of ${spec.rows.length} match "${_searchController.text.trim()}"';
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _SearchBox(controller: _searchController, onChanged: (v) => setState(() => _query = v.trim().toLowerCase())),
                    for (final f in spec.filters) _FilterChip(f),
                  ],
                ),
              ),
              const SizedBox(width: 8),
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
                LayoutBuilder(
                  builder: (context, constraints) {
                    // Few columns (say, a compact PO/GRN list) should
                    // stretch to fill the card instead of hugging content
                    // width and leaving a slab of empty space — that's the
                    // "fit to screen" ask. Wider tables (10+ columns, e.g.
                    // Sales Invoices) still need to scroll horizontally
                    // rather than squeeze unreadably narrow.
                    final stretch = spec.columns.length <= 6;
                    final table = _DataTable(columns: spec.columns, rows: filteredRows, dense: dense, stretch: stretch);
                    if (stretch) return table;
                    return SingleChildScrollView(scrollDirection: Axis.horizontal, child: table);
                  },
                ),
                if (filteredRows.isEmpty && spec.rows.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 28),
                    alignment: Alignment.center,
                    child: Text('No records match your search.', style: AppText.sans(size: 12.5, color: AppColors.mutedFaint)),
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
                      Text(count, style: AppText.mono(size: 11, color: AppColors.mutedSoft)),
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
  const _DataTable({required this.columns, required this.rows, required this.dense, required this.stretch});
  final List<ColumnSpec> columns;
  final List<RowSpec> rows;
  final bool dense;

  /// True for narrow tables: columns get FlexColumnWidth so the table
  /// fills the card instead of shrink-wrapping to content. False keeps the
  /// old IntrinsicColumnWidth + horizontal-scroll behaviour for wide
  /// tables where flexing would squeeze every column unreadably.
  final bool stretch;

  bool get _hasActions => rows.any((r) => r.onEdit != null || r.onDelete != null);

  @override
  Widget build(BuildContext context) {
    final rowHeight = dense ? 34.0 : 40.0;
    final hasActions = _hasActions;
    final widths = <int, TableColumnWidth>{
      for (var i = 0; i < columns.length; i++)
        i: stretch
            ? FlexColumnWidth(columns[i].align == CellAlign.right ? 1 : 1.7)
            : const IntrinsicColumnWidth(),
      if (hasActions) columns.length: const FixedColumnWidth(76),
    };
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: widths,
      children: [
        TableRow(
          decoration: const BoxDecoration(color: AppColors.fieldFill),
          children: [
            for (final c in columns)
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
            if (hasActions)
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: SizedBox(height: 36),
              ),
          ],
        ),
        for (final row in rows)
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
              if (hasActions)
                _RowActionsCell(
                  height: rowHeight,
                  onEdit: row.onEdit,
                  onDelete: row.onDelete,
                  deleteTooltip: row.deleteTooltip,
                  deleteConfirmTitle: row.deleteConfirmTitle,
                  deleteConfirmMessage: row.deleteConfirmMessage,
                ),
            ],
          ),
      ],
    );
  }
}

class _RowActionsCell extends StatefulWidget {
  const _RowActionsCell({
    required this.height,
    this.onEdit,
    this.onDelete,
    this.deleteTooltip = 'Delete',
    this.deleteConfirmTitle = 'Delete this record?',
    this.deleteConfirmMessage = 'This cannot be undone.',
  });
  final double height;
  final VoidCallback? onEdit;
  final Future<void> Function()? onDelete;
  final String deleteTooltip;
  final String deleteConfirmTitle;
  final String deleteConfirmMessage;

  @override
  State<_RowActionsCell> createState() => _RowActionsCellState();
}

class _RowActionsCellState extends State<_RowActionsCell> {
  bool _deleting = false;
  String? _error;

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.card,
        title: Text(widget.deleteConfirmTitle),
        content: Text(widget.deleteConfirmMessage),
        actions: [
          TextButton(onPressed: () => Navigator.of(context).pop(false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(widget.deleteTooltip, style: const TextStyle(color: AppColors.danger)),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    setState(() {
      _deleting = true;
      _error = null;
    });
    try {
      await widget.onDelete!();
    } catch (e) {
      _error = e.toString();
    }
    if (mounted) {
      setState(() => _deleting = false);
      if (_error != null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_error!), backgroundColor: AppColors.danger));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      alignment: Alignment.centerRight,
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.borderFaint))),
      child: _deleting
          ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(strokeWidth: 2))
          : Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.onEdit != null)
                  _RowIconButton(icon: Icons.edit_outlined, color: AppColors.accent, tooltip: 'Edit', onTap: widget.onEdit!),
                if (widget.onDelete != null)
                  _RowIconButton(
                    icon: Icons.delete_outline,
                    color: AppColors.danger,
                    tooltip: widget.deleteTooltip,
                    onTap: _confirmDelete,
                  ),
              ],
            ),
    );
  }
}

class _RowIconButton extends StatelessWidget {
  const _RowIconButton({required this.icon, required this.color, required this.tooltip, required this.onTap});
  final IconData icon;
  final Color color;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Padding(padding: const EdgeInsets.all(6), child: Icon(icon, size: 16, color: color)),
      ),
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

class _SearchBox extends StatelessWidget {
  const _SearchBox({required this.controller, required this.onChanged});
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 32,
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppText.sans(size: 12.5),
        decoration: InputDecoration(
          isDense: true,
          hintText: 'Search…',
          hintStyle: AppText.sans(size: 12.5, color: AppColors.mutedFaint),
          prefixIcon: const Icon(Icons.search, size: 16, color: AppColors.mutedFaint),
          filled: true,
          fillColor: AppColors.card,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(999), borderSide: const BorderSide(color: AppColors.controlBorder)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(999), borderSide: const BorderSide(color: AppColors.controlBorder)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(999), borderSide: const BorderSide(color: AppColors.accent)),
        ),
      ),
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
