import 'package:flutter/material.dart';

/// Lays children out in a row above [breakpoint] width, stacked in a column
/// below it — the one deliberate concession to "don't just stretch mobile
/// onto desktop": narrow viewports get a single scrollable column instead
/// of a squeezed multi-column grid.
class AdaptiveColumns extends StatelessWidget {
  const AdaptiveColumns({super.key, required this.children, this.flexes, this.gap = 12, this.breakpoint = 760});

  final List<Widget> children;
  final List<int>? flexes;
  final double gap;
  final double breakpoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= breakpoint) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < children.length; i++) ...[
                if (i > 0) SizedBox(width: gap),
                Expanded(flex: flexes != null ? flexes![i] : 1, child: children[i]),
              ],
            ],
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (var i = 0; i < children.length; i++) ...[
              if (i > 0) SizedBox(height: gap),
              children[i],
            ],
          ],
        );
      },
    );
  }
}

/// A responsive wrap-grid: N columns above the breakpoint, fewer as space
/// shrinks, always at least 1.
class AdaptiveGrid extends StatelessWidget {
  const AdaptiveGrid({super.key, required this.children, this.columns = 4, this.gap = 12, this.minTileWidth = 220});

  final List<Widget> children;
  final int columns;
  final double gap;
  final double minTileWidth;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxCols = (constraints.maxWidth / minTileWidth).floor().clamp(1, columns);
        final width = (constraints.maxWidth - gap * (maxCols - 1)) / maxCols;
        return Wrap(
          spacing: gap,
          runSpacing: gap,
          children: [for (final c in children) SizedBox(width: width, child: c)],
        );
      },
    );
  }
}
