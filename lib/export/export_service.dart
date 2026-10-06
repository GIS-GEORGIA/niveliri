import 'dart:typed_data';

import 'package:file_saver/file_saver.dart';
import 'package:share_plus/share_plus.dart';

import '../features/projects/project.dart';
import '../l10n/app_localizations.dart';
import 'pdf_export.dart';
import 'report.dart';
import 'xlsx_export.dart';

enum ExportFormat { pdf, xlsx }

enum ExportOutcome { saved, shared }

/// Builds the file for [p] and either saves it or opens the system share sheet.
Future<(ExportOutcome, String)> exportProject(
  Project p,
  AppLocalizations t,
  ExportFormat format, {
  required bool share,
}) async {
  final report = buildReport(p, t);
  final base = safeFileName(p.name);
  final Uint8List bytes;
  final String ext, mime;
  switch (format) {
    case ExportFormat.pdf:
      bytes = await buildPdf(report, t, await PdfFonts.loadBundled());
      ext = 'pdf';
      mime = 'application/pdf';
    case ExportFormat.xlsx:
      bytes = buildXlsx(report, t);
      ext = 'xlsx';
      mime = 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet';
  }
  final fileName = '$base.$ext';

  if (share) {
    await SharePlus.instance.share(ShareParams(
      files: [XFile.fromData(bytes, mimeType: mime, name: fileName)],
      fileNameOverrides: [fileName],
      title: base,
    ));
    return (ExportOutcome.shared, fileName);
  }
  await FileSaver.instance.saveFile(
    name: base,
    bytes: bytes,
    fileExtension: ext,
    mimeType: format == ExportFormat.pdf ? MimeType.pdf : MimeType.microsoftExcel,
  );
  return (ExportOutcome.saved, fileName);
}
