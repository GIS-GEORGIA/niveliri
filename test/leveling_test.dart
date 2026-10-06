import 'package:flutter_test/flutter_test.dart';
import 'package:niveliri/core/leveling.dart';

// Same data as the original app's example().
List<LevelRow> exampleRows() => [
      LevelRow(name: 'Rp1', type: PointType.start, backsight: 1.523),
      LevelRow(name: 'P1', type: PointType.intermediate, intermediate: 1.310),
      LevelRow(
          name: 'TP1',
          type: PointType.turning,
          foresight: 1.742,
          backsight: 1.605),
      LevelRow(name: 'P2', type: PointType.intermediate, intermediate: 0.987),
      LevelRow(name: 'Rp2', type: PointType.end, foresight: 1.150),
    ];

const exampleSettings = LevelingSettings(
  startHeight: 100,
  knownEndHeight: 100.240,
  lengthKm: 0.2,
);

void main() {
  test('heights match the original example', () {
    final r = computeLeveling(exampleRows(), exampleSettings);
    expect(r.points[0].height, closeTo(100.000, 1e-9));
    expect(r.points[0].instrumentHeight, closeTo(101.523, 1e-9));
    expect(r.points[1].height, closeTo(100.213, 1e-9));
    expect(r.points[2].height, closeTo(99.781, 1e-9));
    expect(r.points[2].instrumentHeight, closeTo(101.386, 1e-9));
    expect(r.points[3].height, closeTo(100.399, 1e-9));
    expect(r.points[4].height, closeTo(100.236, 1e-9));
  });

  test('control sums agree', () {
    final r = computeLeveling(exampleRows(), exampleSettings);
    expect(r.sumBacksight, closeTo(3.128, 1e-9));
    expect(r.sumForesight, closeTo(2.892, 1e-9));
    expect(r.diffSums, closeTo(0.236, 1e-9));
    expect(r.diffEnds, closeTo(0.236, 1e-9));
    expect(r.setups, 2);
  });

  test('closing error, tolerance and correction', () {
    final r = computeLeveling(exampleRows(), exampleSettings);
    expect(r.closingError, closeTo(-0.004, 1e-9));
    expect(r.allowedMm, closeTo(12 * 0.4472135955, 1e-6));
    expect(r.closingOk, isTrue);
    expect(r.points[2].corrected, closeTo(99.783, 1e-9));
    expect(r.points[4].corrected, closeTo(100.240, 1e-9));
  });

  test('no known end height means no closing check', () {
    final r = computeLeveling(
        exampleRows(), exampleSettings.copyWith(knownEndHeight: double.nan));
    expect(r.hasClosing, isFalse);
    expect(r.points[2].corrected.isNaN, isTrue);
  });

  test('fixed tolerance mode', () {
    final s = exampleSettings.copyWith(
        toleranceMode: ToleranceMode.fixed, fixedToleranceMm: 3);
    final r = computeLeveling(exampleRows(), s);
    expect(r.allowedMm, 3);
    expect(r.closingOk, isFalse);
  });

  test('stake mode: design height, rod reading and deviation', () {
    final rows = [
      LevelRow(name: 'A', type: PointType.start, backsight: 1.500),
      LevelRow(
          name: 'B', type: PointType.intermediate, intermediate: 1.480, chainage: 10),
    ];
    final s = const LevelingSettings(
      startHeight: 100,
      mode: LevelingMode.stake,
      designStart: 100,
      slopePercent: 0.5,
      slopeSign: -1,
    );
    final r = computeLeveling(rows, s);
    // design at 10 m: 100 - 0.5% * 10 = 99.95
    expect(r.points[1].design, closeTo(99.95, 1e-9));
    expect(r.points[1].rodShouldRead, closeTo(101.5 - 99.95, 1e-9));
    // actual 100.020, design 99.950 -> +70 mm, remove
    expect(r.points[1].deviationMm, closeTo(70, 1e-6));
    expect(stakeAction(70, 5), StakeAction.remove);
    expect(stakeAction(-70, 5), StakeAction.fill);
    expect(stakeAction(3, 5), StakeAction.exact);
  });

  test('row JSON round trip', () {
    final r = LevelRow(
        name: 'TP1', type: PointType.turning, foresight: 1.7, backsight: 1.6, chainage: 5);
    final back = LevelRow.fromJson(r.toJson());
    expect(back.name, 'TP1');
    expect(back.type, PointType.turning);
    expect(back.foresight, 1.7);
    expect(back.chainage, 5);
  });
}
