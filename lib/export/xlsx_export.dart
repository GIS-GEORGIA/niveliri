import 'dart:typed_data';

import 'package:excel/excel.dart';

import '../l10n/app_localizations.dart';
import 'report.dart';

String safeFileName(String name) {
  final s = name.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_').trim();
  return s.isEmpty ? 'project' : s;
}

CellValue _cv(Object? v) {
  if (v == null) return TextCellValue('');
  if (v is int) return IntCellValue(v);
  if (v is double) return DoubleCellValue(v);
  return TextCellValue(v.toString());
}

Uint8List buildXlsx(Report r, AppLocalizations t) {
  final book = Excel.createExcel();
  final name = safeFileName(r.projectName).replaceAll(RegExp(r'[\[\]]'), '');
  final sheetName = name.length > 31 ? name.substring(0, 31) : name;
  final def = book.getDefaultSheet()!;
  book.rename(def, sheetName);
  final sh = book[sheetName];

  void line(List<Object?> cells) => sh.appendRow(cells.map(_cv).toList());

  for (final l in r.intro) {
    line([l]);
  }
  line([]);
  line([t.legendTitle]);
  for (final l in r.legend) {
    line([l]);
  }
  line([]);
  line([...r.columns.map((c) => c.label), t.howCalculated]);
  for (var i = 0; i < r.rows.length; i++) {
    line([...r.rows[i], r.steps[i]]);
  }
  line([]);
  line([t.controlTitle]);
  for (final (k, v) in r.checks) {
    line([k, v]);
  }

  const widths = [8.0, 22.0, 38.0, 20.0, 20.0, 20.0, 24.0, 22.0, 24.0, 110.0];
  for (var i = 0; i < widths.length; i++) {
    sh.setColumnWidth(i, widths[i]);
  }
  final bytes = book.encode();
  if (bytes == null) throw StateError('xlsx encode failed');
  return Uint8List.fromList(bytes);
}
