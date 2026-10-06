import 'dart:async';
import 'dart:io';

import 'package:excel/excel.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:niveliri/core/leveling.dart';
import 'package:niveliri/export/pdf_export.dart';
import 'package:niveliri/export/report.dart';
import 'package:niveliri/export/xlsx_export.dart';
import 'package:niveliri/features/projects/project.dart';
import 'package:niveliri/l10n/app_localizations_en.dart';
import 'package:niveliri/l10n/app_localizations_ka.dart';
import 'package:pdf/widgets.dart' as pw;

Project example() => Project(
      id: 'x',
      name: 'Example/1',
      settings: const LevelingSettings(startHeight: 100, knownEndHeight: 100.240, lengthKm: 0.2),
      rows: [
        LevelRow(name: 'Rp1', type: PointType.start, backsight: 1.523),
        LevelRow(name: 'P1', type: PointType.intermediate, intermediate: 1.310),
        LevelRow(name: 'TP1', type: PointType.turning, foresight: 1.742, backsight: 1.605),
        LevelRow(name: 'P2', type: PointType.intermediate, intermediate: 0.987),
        LevelRow(name: 'Rp2', type: PointType.end, foresight: 1.150),
      ],
    );

Project stakeExample() => Project(
      id: 's',
      name: 'Floor',
      settings: const LevelingSettings(
        startHeight: 100,
        mode: LevelingMode.stake,
        designStart: 100,
        slopePercent: 0.5,
        slopeSign: -1,
      ),
      rows: [
        LevelRow(name: 'A', type: PointType.start, backsight: 1.500),
        LevelRow(name: 'B', type: PointType.intermediate, intermediate: 1.480, chainage: 10),
      ],
    );

void main() {
  final en = AppLocalizationsEn();
  final now = DateTime(2026, 10, 5);

  test('report rows, steps and checks for the example', () {
    final r = buildReport(example(), en, now: now);
    expect(r.intro[1], 'Leveling journal · 05.10.2026');
    expect(r.rows.length, 5);
    expect(r.rows[2][7], closeTo(99.781, 1e-9)); // point height of TP1
    expect(r.rows[2][8], closeTo(99.783, 1e-9)); // adjusted
    expect(r.steps[2], contains('99.781'));
    expect(r.steps[2], contains('Adjusted = 99.781 − (-0.004 × 1/2) = 99.783'));
    final checks = Map.fromEntries(r.checks.map((c) => MapEntry(c.$1, c.$2)));
    expect(checks['ΣBS (sum of backsights)'], '1.523 + 1.605 = 3.128');
    expect(checks['Verification'], contains('correct'));
    expect(checks['Allowed error'], '12 × √0.2 = 5.4 mm');
    expect(checks['Conclusion'], 'The error is acceptable');
  });

  test('Georgian report uses the same data', () {
    final r = buildReport(example(), AppLocalizationsKa(), now: now);
    expect(r.columns.first.label, '#');
    expect(r.checks.any((c) => c.$2 == 'ცდომილება დასაშვებია'), isTrue);
    expect(r.steps[0], 'Rp1: სიმაღლე ცნობილია = 100.000. ხედვის სიმაღლე = 100.000 + 1.523 (უკან ათვლა) = 101.523');
  });

  test('stakeout report has deviation and action columns', () {
    final r = buildReport(stakeExample(), en, now: now);
    expect(r.columns.length, 9);
    final b = r.rows[1];
    expect(b[5], closeTo(99.95, 1e-9)); // design
    expect(b[7], closeTo(70, 1e-6)); // deviation mm
    expect(b[8], 'Remove');
    expect(r.rows[0][8], ''); // no action on the start point
  });

  test('xlsx contains numbers, not text, for heights', () {
    final bytes = buildXlsx(buildReport(example(), en, now: now), en);
    final book = Excel.decodeBytes(bytes);
    final sh = book.tables.values.first;
    expect(book.tables.keys.first, 'Example_1');
    final hdr = sh.rows.indexWhere((row) => row.first?.value.toString() == '#');
    expect(hdr, greaterThan(0));
    final tp = sh.rows[hdr + 3];
    expect(tp[1]?.value.toString(), 'TP1');
    expect((tp[7]!.value as DoubleCellValue).value, closeTo(99.781, 1e-9));
  });

  test('pdf builds a valid document', () async {
    final bytes = await buildPdf(
        buildReport(example(), en, now: now), en, PdfFonts(pw.Font.helvetica(), pw.Font.helveticaBold()));
    expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
    expect(bytes.length, greaterThan(2000));
  });

  test('pdf with the bundled Georgian font has every glyph it needs', () async {
    pw.Font load(String p) => pw.Font.ttf(File(p).readAsBytesSync().buffer.asByteData());
    final fonts = PdfFonts(
      load('assets/fonts/NotoSansGeorgian-Regular.ttf'),
      load('assets/fonts/NotoSansGeorgian-Bold.ttf'),
      fallback: [load('assets/fonts/Roboto-Regular.ttf')],
    );
    final warnings = <String>[];
    await runZoned(
      () async {
        for (final loc in [AppLocalizationsKa(), en]) {
          for (final p in [example(), stakeExample()]) {
            final b = await buildPdf(buildReport(p, loc, now: now), loc, fonts);
            expect(String.fromCharCodes(b.take(5)), '%PDF-');
          }
        }
      },
      zoneSpecification: ZoneSpecification(print: (s, parent, zone, line) => warnings.add(line)),
    );
    expect(warnings.where((w) => w.contains('Unable to find a font')).toSet(), isEmpty);
  });

  test('safe file names', () {
    expect(safeFileName('a/b:c'), 'a_b_c');
    expect(safeFileName('  '), 'project');
  });
}
