import 'dart:typed_data';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';

import '../models/table_spec.dart';

/// Turns any [TableSpec] into a CSV file and hands it to the platform share
/// sheet (which on desktop/mobile is "save/share", and on web triggers a
/// download) — every list screen gets a working Export for free since they
/// all already render from this one model.
Future<void> exportTableCsv(TableSpec spec) async {
  final rows = <List<String>>[
    [for (final c in spec.columns) c.label],
    for (final row in spec.rows) [for (final cell in row.cells) cell.value],
  ];
  final csv = const ListToCsvConverter().convert(rows);
  final bytes = Uint8List.fromList(csv.codeUnits);
  final fileName = '${_slug(spec.title)}.csv';
  await Share.shareXFiles([XFile.fromData(bytes, name: fileName, mimeType: 'text/csv')], text: spec.title);
}

/// Renders the same [TableSpec] as a landscape PDF and opens the native
/// print/save dialog (via `printing`, which works the same way on
/// Android/iOS/Windows/macOS/Linux and — through the browser's own print
/// dialog — on Web).
Future<void> printTablePdf(TableSpec spec) async {
  final doc = pw.Document();
  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4.landscape,
      header: (context) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(spec.title, style: pw.TextStyle(fontSize: 16, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 2),
          pw.Text(spec.subtitle, style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey700)),
          pw.SizedBox(height: 10),
        ],
      ),
      footer: (context) => pw.Align(
        alignment: pw.Alignment.centerRight,
        child: pw.Text(
          'Page ${context.pageNumber} of ${context.pagesCount}',
          style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600),
        ),
      ),
      build: (context) => [
        pw.TableHelper.fromTextArray(
          headers: [for (final c in spec.columns) c.label],
          data: [
            for (final row in spec.rows) [for (final cell in row.cells) cell.value],
          ],
          headerStyle: pw.TextStyle(fontSize: 8, fontWeight: pw.FontWeight.bold),
          cellStyle: const pw.TextStyle(fontSize: 8),
          headerDecoration: const pw.BoxDecoration(color: PdfColors.grey200),
          cellHeight: 20,
          cellAlignments: {
            for (var i = 0; i < spec.columns.length; i++)
              i: spec.columns[i].align == CellAlign.right ? pw.Alignment.centerRight : pw.Alignment.centerLeft,
          },
        ),
        pw.SizedBox(height: 10),
        pw.Text(spec.count, style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey600)),
      ],
    ),
  );
  await Printing.layoutPdf(onLayout: (_) => doc.save(), name: '${_slug(spec.title)}.pdf');
}

String _slug(String s) => s.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-').replaceAll(RegExp(r'(^-|-$)'), '');

/// Shows a small menu so a single Export button on tight layouts can still
/// offer both CSV and PDF, matching the desktop layout's two separate
/// buttons without needing two buttons worth of width.
Future<void> showExportMenu(BuildContext context, TableSpec spec) async {
  final choice = await showModalBottomSheet<String>(
    context: context,
    builder: (context) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(leading: const Icon(Icons.table_chart_outlined), title: const Text('Export as CSV'), onTap: () => Navigator.pop(context, 'csv')),
          ListTile(leading: const Icon(Icons.print_outlined), title: const Text('Print / Save as PDF'), onTap: () => Navigator.pop(context, 'pdf')),
        ],
      ),
    ),
  );
  if (choice == 'csv') await exportTableCsv(spec);
  if (choice == 'pdf') await printTablePdf(spec);
}
