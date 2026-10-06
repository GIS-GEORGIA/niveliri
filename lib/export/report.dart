import 'dart:math' as math;

import 'package:intl/intl.dart';

import '../core/format.dart';
import '../core/leveling.dart';
import '../features/projects/project.dart';
import '../l10n/app_localizations.dart';

/// Everything an export needs, already localized and formatted.
/// Both the PDF and the Excel writers consume this, so they stay identical.
class ReportColumn {
  const ReportColumn(this.label, {this.decimals = 3, this.text = false});
  final String label;

  /// Decimal places for numeric cells.
  final int decimals;

  /// True for columns that hold text (names, labels).
  final bool text;
}

class Report {
  Report({
    required this.projectName,
    required this.intro,
    required this.legend,
    required this.columns,
    required this.rows,
    required this.rowKinds,
    required this.steps,
    required this.checks,
  });

  final String projectName;

  /// Header lines: journal title and date, start point, stakeout parameters.
  final List<String> intro;
  final List<String> legend;
  final List<ReportColumn> columns;

  /// Cells are String, num, or null.
  final List<List<Object?>> rows;
  final List<PointType> rowKinds;

  /// One "how it was calculated" sentence per row.
  final List<String> steps;
  final List<(String, String)> checks;

  /// Formats a cell for display (PDF).
  String cell(int col, Object? v) {
    if (v == null) return '—';
    if (v is num) return col == 0 ? v.toString() : v.toStringAsFixed(columns[col].decimals);
    return v.toString();
  }
}

double? _n(double? x) => x != null && x.isFinite ? x : null;

Report buildReport(Project p, AppLocalizations t, {DateTime? now}) {
  final s = p.settings;
  final rows = p.rows;
  final r = computeLeveling(rows, s);
  final stake = s.mode == LevelingMode.stake;
  final date = DateFormat('dd.MM.yyyy').format(now ?? DateTime.now());

  String typeLabel(PointType k) => switch (k) {
        PointType.start => t.typeStart,
        PointType.intermediate => t.typeIntermediate,
        PointType.turning => t.typeTurning,
        PointType.end => t.typeEnd,
      };
  String act(double d) => switch (stakeAction(d, s.stakeToleranceMm)) {
        StakeAction.exact => t.actExact,
        StakeAction.remove => t.actRemove,
        StakeAction.fill => t.actFill,
      };

  final intro = <String>[
    t.reportProject(p.name),
    '${t.reportJournal} · $date',
    '${t.reportStartPoint}: ${s.startName}   ${t.reportHeightM}: ${f3(s.startHeight)}',
    if (stake)
      '${t.reportDesignAtStart}: ${f3(s.designStart)}   ${t.reportSlope}: '
          '${numText(s.slopePercent * s.slopeSign)}   ${t.reportTolerance}: ${numText(s.stakeToleranceMm)}',
  ];

  final legend = stake
      ? [t.legendS1, t.legendS2, t.legendS3, t.legendS4, t.legendS5, t.legendS6, t.legendS7]
      : [
          t.legendM1, t.legendM2, t.legendM3, t.legendM4, t.legendM5,
          t.legendM6, t.legendM7, t.legendM8, t.legendM9, t.legendM10,
        ];

  final columns = stake
      ? [
          ReportColumn(t.colNo, decimals: 0),
          ReportColumn(t.colPoint, text: true),
          ReportColumn(t.colChainage, decimals: 1),
          ReportColumn(t.colRodReading),
          ReportColumn(t.colActualHeight),
          ReportColumn(t.colDesignHeight),
          ReportColumn(t.colShouldRead),
          ReportColumn(t.colDeviation, decimals: 1),
          ReportColumn(t.colAction, text: true),
        ]
      : [
          ReportColumn(t.colNo, decimals: 0),
          ReportColumn(t.colPoint, text: true),
          ReportColumn(t.colType, text: true),
          ReportColumn(t.colBacksight),
          ReportColumn(t.colIntermediate),
          ReportColumn(t.colForesight),
          ReportColumn(t.colInstrument),
          ReportColumn(t.colPointHeight),
          ReportColumn(t.colAdjusted),
        ];

  final table = <List<Object?>>[];
  for (var i = 0; i < rows.length; i++) {
    final w = rows[i], o = r.points[i];
    if (stake) {
      final reading = switch (w.type) {
        PointType.start => w.backsight,
        PointType.intermediate => w.intermediate,
        _ => w.foresight,
      };
      table.add([
        i + 1,
        w.name,
        _n(w.chainage),
        reading,
        _n(o.height),
        _n(o.design),
        _n(o.rodShouldRead),
        _n(o.deviationMm),
        i > 0 && o.deviationMm.isFinite ? act(o.deviationMm) : '',
      ]);
    } else {
      table.add([
        i + 1,
        w.name,
        typeLabel(w.type),
        w.backsight,
        w.intermediate,
        w.foresight,
        _n(o.instrumentHeight),
        _n(o.height),
        _n(o.corrected),
      ]);
    }
  }

  double v(double? x) => x ?? double.nan;
  final steps = <String>[];
  for (var i = 0; i < rows.length; i++) {
    final w = rows[i], o = r.points[i], n = w.name;
    final hp = i > 0 ? r.points[i - 1].instrumentHeight : double.nan;
    var line = switch (w.type) {
      PointType.start =>
        t.stepStart(n, f3(s.startHeight), f3(v(w.backsight)), f3(o.instrumentHeight)),
      PointType.intermediate => t.stepIntermediate(n, f3(hp), f3(v(w.intermediate)), f3(o.height)),
      PointType.turning => t.stepTurning(
          n, f3(hp), f3(v(w.foresight)), f3(o.height), f3(v(w.backsight)), f3(o.instrumentHeight)),
      PointType.end => t.stepEnd(n, f3(hp), f3(v(w.foresight)), f3(o.height)),
    };
    // Argument order follows the ARB placeholder order, which is order of first appearance.
    if (i > 0 && o.corrected.isFinite) {
      line += '. ${t.stepAdjusted(f3(o.height), f3(r.closingError), '${o.setup}', '${r.setups}', f3(o.corrected))}';
    }
    if (stake && o.design.isFinite) {
      final sl = s.slopePercent * s.slopeSign;
      line += '. ${t.stepDesign(f3(s.designStart), numText(sl), numText(w.chainage ?? 0), f3(o.design))}';
      if (i > 0) {
        line += '. ${t.stepStake(f3(hp), f3(o.design), f3(o.rodShouldRead), f3(o.height), o.deviationMm.toStringAsFixed(1), act(o.deviationMm))}';
      }
    }
    steps.add(line);
  }

  final checks = <(String, String)>[];
  final bl = rows.where((w) => w.backsight != null).map((w) => f3(w.backsight!)).join(' + ');
  final fl = rows.where((w) => w.foresight != null).map((w) => f3(w.foresight!)).join(' + ');
  checks.add((t.chkSumBs, '${bl.isEmpty ? '0' : bl} = ${f3(r.sumBacksight)}'));
  checks.add((t.chkSumFs, '${fl.isEmpty ? '0' : fl} = ${f3(r.sumForesight)}'));
  checks.add((
    t.chkDiffSums,
    '${f3(r.sumBacksight)} − ${f3(r.sumForesight)} = ${f3(r.diffSums)}'
  ));
  if (r.diffEnds.isFinite) {
    checks.add((
      t.chkEndMinusStart,
      '${f3(r.diffEnds + s.startHeight)} − ${f3(s.startHeight)} = ${f3(r.diffEnds)}'
    ));
    checks.add((
      t.chkVerify,
      (r.diffSums - r.diffEnds).abs() < 0.0006 ? t.chkVerifyOk : t.chkVerifyBad
    ));
  }
  if (r.hasClosing) {
    final known = s.knownEndHeight;
    final e = r.closingError;
    checks.add((t.chkKnownEnd, f3(known)));
    checks.add((
      t.chkError,
      t.chkErrorValue(f3(known + e), f3(known), f3(e), (e * 1000).toStringAsFixed(1))
    ));
    if (r.allowedMm > 0) {
      checks.add((
        t.chkAllowed,
        s.toleranceMode == ToleranceMode.fixed
            ? t.chkAllowedFixed(r.allowedMm.toStringAsFixed(1))
            : t.chkAllowedFormula(numText(s.coefficient), numText(s.lengthKm), r.allowedMm.toStringAsFixed(1))
      ));
      checks.add((t.chkConclusion, r.closingOk ? t.chkConclOk : t.chkConclBad));
    }
    checks.add((
      t.chkAdjust,
      t.chkAdjustValue('${r.setups}', (-e * 1000 / math.max(1, r.setups)).toStringAsFixed(1))
    ));
  }

  return Report(
    projectName: p.name,
    intro: intro,
    legend: legend,
    columns: columns,
    rows: table,
    rowKinds: rows.map((w) => w.type).toList(),
    steps: steps,
    checks: checks,
  );
}
