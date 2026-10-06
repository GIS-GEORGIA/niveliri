import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../core/leveling.dart';
import '../l10n/app_localizations.dart';
import 'report.dart';

/// Fonts used by the PDF. Georgian glyphs need a bundled font; the built-in
/// PDF fonts only cover Latin. Noto Sans Georgian has no Σ or √, so Roboto
/// is the fallback for those.
class PdfFonts {
  const PdfFonts(this.regular, this.bold, {this.fallback = const []});
  final pw.Font regular;
  final pw.Font bold;
  final List<pw.Font> fallback;

  static Future<PdfFonts> loadBundled() async {
    Future<pw.Font> load(String path) async => pw.Font.ttf(await rootBundle.load(path));
    return PdfFonts(
      await load('assets/fonts/NotoSansGeorgian-Regular.ttf'),
      await load('assets/fonts/NotoSansGeorgian-Bold.ttf'),
      fallback: [await load('assets/fonts/Roboto-Regular.ttf')],
    );
  }
}

const _rowColors = {
  PointType.start: PdfColor.fromInt(0xFFDFF3E6),
  PointType.turning: PdfColor.fromInt(0xFFDCE9F7),
  PointType.end: PdfColor.fromInt(0xFFFBE9CF),
};

Future<Uint8List> buildPdf(Report r, AppLocalizations t, PdfFonts fonts) async {
  final doc = pw.Document(title: r.projectName);
  final theme = pw.ThemeData.withFont(
    base: fonts.regular,
    bold: fonts.bold,
  ).copyWith(defaultTextStyle: pw.TextStyle(font: fonts.regular, fontFallback: fonts.fallback));
  const border = pw.TableBorder(
    left: pw.BorderSide(color: PdfColors.grey500, width: 0.5),
    right: pw.BorderSide(color: PdfColors.grey500, width: 0.5),
    top: pw.BorderSide(color: PdfColors.grey500, width: 0.5),
    bottom: pw.BorderSide(color: PdfColors.grey500, width: 0.5),
    horizontalInside: pw.BorderSide(color: PdfColors.grey500, width: 0.5),
    verticalInside: pw.BorderSide(color: PdfColors.grey500, width: 0.5),
  );

  pw.Widget heading(String s) => pw.Padding(
        padding: const pw.EdgeInsets.only(top: 14, bottom: 4),
        child: pw.Text(s, style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold)),
      );

  pw.Widget cellText(String s, {bool bold = false, pw.TextAlign align = pw.TextAlign.center}) =>
      pw.Padding(
        padding: const pw.EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        child: pw.Text(s,
            textAlign: align,
            style: pw.TextStyle(fontSize: 8.5, fontWeight: bold ? pw.FontWeight.bold : null)),
      );

  final headerRow = pw.TableRow(
    decoration: const pw.BoxDecoration(color: PdfColor.fromInt(0xFFE3E9F0)),
    repeat: true,
    children: [for (final c in r.columns) cellText(c.label, bold: true)],
  );
  final bodyRows = [
    for (var i = 0; i < r.rows.length; i++)
      pw.TableRow(
        decoration: _rowColors[r.rowKinds[i]] == null
            ? null
            : pw.BoxDecoration(color: _rowColors[r.rowKinds[i]]),
        children: [
          for (var c = 0; c < r.columns.length; c++) cellText(r.cell(c, r.rows[i][c])),
        ],
      ),
  ];

  doc.addPage(pw.MultiPage(
    pageTheme: pw.PageTheme(
      pageFormat: PdfPageFormat.a4.landscape,
      margin: const pw.EdgeInsets.all(28),
      theme: theme,
    ),
    build: (_) => [
      pw.Text(r.intro.first, style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
      pw.SizedBox(height: 4),
      for (final l in r.intro.skip(1)) pw.Text(l, style: const pw.TextStyle(fontSize: 11)),
      heading(t.legendTitle),
      for (final l in r.legend)
        pw.Padding(
            padding: const pw.EdgeInsets.only(bottom: 2),
            child: pw.Text(l, style: const pw.TextStyle(fontSize: 9, color: PdfColors.grey800))),
      pw.SizedBox(height: 10),
      pw.Table(
        border: border,
        defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
        children: [headerRow, ...bodyRows],
      ),
      heading(t.howCalculatedPerPoint),
      for (final s in r.steps)
        pw.Padding(padding: const pw.EdgeInsets.only(bottom: 3), child: pw.Text(s, style: const pw.TextStyle(fontSize: 9.5))),
      heading(t.controlTitle),
      for (final (k, v) in r.checks)
        pw.Padding(padding: const pw.EdgeInsets.only(bottom: 3), child: pw.Text('$k: $v', style: const pw.TextStyle(fontSize: 9.5))),
    ],
  ));
  return doc.save();
}
