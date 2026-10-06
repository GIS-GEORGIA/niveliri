import 'dart:math' as math;

/// Pure leveling math, ported from the original single-file HTML app
/// (idea and author: Gogita Shainidze). No Flutter imports on purpose,
/// so it stays unit-testable.

enum PointType { start, intermediate, turning, end }

enum ToleranceMode { formula, fixed }

enum LevelingMode { measure, stake }

class LevelRow {
  LevelRow({
    required this.name,
    required this.type,
    this.backsight,
    this.intermediate,
    this.foresight,
    this.chainage,
  });

  String name;
  final PointType type;

  /// BS: reading on a point of known height (start, or after moving the level).
  double? backsight;

  /// Reading on an intermediate point (level not moved).
  double? intermediate;

  /// FS: reading on a turning or end point.
  double? foresight;

  /// Distance from the start point in metres (stake mode only).
  double? chainage;

  Map<String, dynamic> toJson() => {
        'n': name,
        't': type.name,
        'bs': backsight,
        'is': intermediate,
        'fs': foresight,
        'ch': chainage,
      };

  factory LevelRow.fromJson(Map<String, dynamic> j) => LevelRow(
        name: j['n'] as String,
        type: PointType.values.byName(j['t'] as String),
        backsight: (j['bs'] as num?)?.toDouble(),
        intermediate: (j['is'] as num?)?.toDouble(),
        foresight: (j['fs'] as num?)?.toDouble(),
        chainage: (j['ch'] as num?)?.toDouble(),
      );
}

class LevelingSettings {
  const LevelingSettings({
    this.startName = 'Rp1',
    this.startHeight = double.nan,
    this.knownEndHeight = double.nan,
    this.toleranceMode = ToleranceMode.formula,
    this.coefficient = 12,
    this.lengthKm = double.nan,
    this.fixedToleranceMm = 10,
    this.mode = LevelingMode.measure,
    this.designStart = double.nan,
    this.slopePercent = 0,
    this.slopeSign = -1,
    this.stakeToleranceMm = 5,
  });

  final String startName;
  final double startHeight;
  final double knownEndHeight;
  final ToleranceMode toleranceMode;
  final double coefficient;
  final double lengthKm;
  final double fixedToleranceMm;
  final LevelingMode mode;
  final double designStart;
  final double slopePercent;

  /// -1 descending, +1 ascending.
  final int slopeSign;
  final double stakeToleranceMm;

  /// Allowed closing error in mm (NaN when it cannot be computed yet).
  double get allowedMm => toleranceMode == ToleranceMode.fixed
      ? fixedToleranceMm
      : coefficient * math.sqrt(lengthKm);

  double designAt(double? chainage) =>
      designStart +
      slopePercent * slopeSign * ((chainage ?? double.nan).isFinite ? chainage! : 0) / 100;

  LevelingSettings copyWith({
    String? startName,
    double? startHeight,
    double? knownEndHeight,
    ToleranceMode? toleranceMode,
    double? coefficient,
    double? lengthKm,
    double? fixedToleranceMm,
    LevelingMode? mode,
    double? designStart,
    double? slopePercent,
    int? slopeSign,
    double? stakeToleranceMm,
  }) =>
      LevelingSettings(
        startName: startName ?? this.startName,
        startHeight: startHeight ?? this.startHeight,
        knownEndHeight: knownEndHeight ?? this.knownEndHeight,
        toleranceMode: toleranceMode ?? this.toleranceMode,
        coefficient: coefficient ?? this.coefficient,
        lengthKm: lengthKm ?? this.lengthKm,
        fixedToleranceMm: fixedToleranceMm ?? this.fixedToleranceMm,
        mode: mode ?? this.mode,
        designStart: designStart ?? this.designStart,
        slopePercent: slopePercent ?? this.slopePercent,
        slopeSign: slopeSign ?? this.slopeSign,
        stakeToleranceMm: stakeToleranceMm ?? this.stakeToleranceMm,
      );
}

class PointResult {
  PointResult({
    required this.height,
    required this.instrumentHeight,
    required this.setup,
  });

  /// Computed height of the point (original `rr`).
  final double height;

  /// Height of the instrument line of sight (original `h`).
  final double instrumentHeight;

  /// Instrument setup number this point belongs to.
  final int setup;

  /// Height after closing-error distribution (NaN when no known end height).
  double corrected = double.nan;

  // Stake mode.
  double design = double.nan;
  double rodShouldRead = double.nan;

  /// Actual minus design, in mm. Positive means remove material.
  double deviationMm = double.nan;
}

class LevelingResult {
  LevelingResult({
    required this.points,
    required this.sumBacksight,
    required this.sumForesight,
    required this.diffSums,
    required this.diffEnds,
    required this.closingError,
    required this.setups,
    required this.allowedMm,
  });

  final List<PointResult> points;
  final double sumBacksight;
  final double sumForesight;

  /// ΣBS − ΣFS.
  final double diffSums;

  /// Last turning/end height minus start height.
  final double diffEnds;

  /// Computed end height minus known end height (metres), NaN if unknown.
  final double closingError;
  final int setups;
  final double allowedMm;

  bool get hasClosing => closingError.isFinite;

  bool get closingOk =>
      hasClosing && allowedMm > 0 && closingError.abs() * 1000 <= allowedMm;
}

LevelingResult computeLeveling(List<LevelRow> rows, LevelingSettings s) {
  final start = s.startHeight;
  double hi = double.nan;
  double sumB = 0, sumF = 0, lastRL = double.nan;
  int k = 1;
  final res = <PointResult>[];

  double nz(double? x) => x ?? double.nan;

  for (final r in rows) {
    final b = nz(r.backsight), i2 = nz(r.intermediate), f = nz(r.foresight);
    double rr = double.nan, h = double.nan;
    final setup = k;
    switch (r.type) {
      case PointType.start:
        rr = start;
        hi = start + b;
        h = hi;
        if (b.isFinite) sumB += b;
      case PointType.intermediate:
        rr = hi - i2;
        h = hi;
      case PointType.turning:
        rr = hi - f;
        if (f.isFinite) sumF += f;
        hi = rr + b;
        h = hi;
        if (b.isFinite) sumB += b;
        lastRL = rr;
        k++;
      case PointType.end:
        rr = hi - f;
        if (f.isFinite) sumF += f;
        lastRL = rr;
        k++;
    }
    if (!rr.isFinite && r.type != PointType.intermediate) hi = double.nan;
    res.add(PointResult(height: rr, instrumentHeight: h, setup: setup));
  }

  final n = k - 1;
  final ei = rows.lastIndexWhere((r) => r.type == PointType.end);
  double e = double.nan;
  if (ei >= 0 && s.knownEndHeight.isFinite && res[ei].height.isFinite) {
    e = res[ei].height - s.knownEndHeight;
  }

  for (var i = 0; i < res.length; i++) {
    final o = res[i];
    if (e.isFinite && i > 0 && o.height.isFinite) {
      o.corrected = o.height - e * o.setup / n;
    } else if (i == 0 && e.isFinite) {
      o.corrected = start;
    }
    if (s.mode == LevelingMode.stake) {
      o.design = s.designAt(rows[i].chainage);
      if (i > 0) o.rodShouldRead = res[i - 1].instrumentHeight - o.design;
      o.deviationMm = (o.height - o.design) * 1000;
    }
  }

  return LevelingResult(
    points: res,
    sumBacksight: sumB,
    sumForesight: sumF,
    diffSums: sumB - sumF,
    diffEnds: lastRL - start,
    closingError: e,
    setups: n,
    allowedMm: s.allowedMm,
  );
}

enum StakeAction { exact, remove, fill }

/// Positive deviation: actual is above design, so material must be removed.
StakeAction stakeAction(double deviationMm, double toleranceMm) {
  if (deviationMm.abs() <= toleranceMm) return StakeAction.exact;
  return deviationMm > 0 ? StakeAction.remove : StakeAction.fill;
}
