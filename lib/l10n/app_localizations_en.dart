// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Leveling Calculator';

  @override
  String get appTagline =>
      'Just answer the questions. The app calculates the heights for you.';

  @override
  String get projects => 'Projects';

  @override
  String get noProjects => 'You have no projects yet. Create the first one.';

  @override
  String get newMeasurement => 'New measurement';

  @override
  String get newMeasurementHint => 'Measure heights of points';

  @override
  String get newStakeout => 'New stakeout';

  @override
  String get newStakeoutHint =>
      'Screed, trench, sewer, road: how much to remove or fill';

  @override
  String get settings => 'Settings';

  @override
  String get theme => 'Theme';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get language => 'Language';

  @override
  String get about => 'Credits';

  @override
  String get copyright => '© All rights reserved';

  @override
  String get originalAuthorTitle => 'Idea author and original developer';

  @override
  String get originalAuthorName => 'Gogita Shainidze';

  @override
  String get phone => 'Phone';

  @override
  String get facebook => 'Facebook';

  @override
  String get feedbackNote =>
      'To suggest improvements or report a problem, please contact the number above.';

  @override
  String get usedWithPermission =>
      'Ported to Flutter with the permission of the original author.';

  @override
  String get developerTitle => 'Flutter port and development';

  @override
  String get version => 'Version';

  @override
  String get newProjectName => 'New project name';

  @override
  String get projectNameHint => 'e.g. Yard, 5 Main St';

  @override
  String get enterProjectName => 'Enter a project name.';

  @override
  String get open => 'Open';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String deleteProjectConfirm(String name) {
    return 'Delete project \"$name\" permanently?';
  }

  @override
  String pointsCount(int count) {
    return '$count points';
  }

  @override
  String get loadExample => 'Load example';

  @override
  String get exampleName => 'Example';

  @override
  String get backToProjects => 'Projects';

  @override
  String get step1Title => '1️⃣ Start point';

  @override
  String get step1Text =>
      'Pick a point whose height you already know (a benchmark). Place the rod on it.';

  @override
  String get pointName => 'Point name';

  @override
  String get pointNameOptional => 'Point name (optional)';

  @override
  String get startHeightLabel => 'Its height (metres)';

  @override
  String get rodReadingFirst =>
      'What number do you see on the rod through the level?';

  @override
  String instrumentHeightIs(String v) {
    return 'Instrument height: $v m';
  }

  @override
  String get continueBtn => 'Continue →';

  @override
  String get fillHeightAndReading => 'Enter the height and the rod reading.';

  @override
  String get fillReading => 'Enter the number shown on the rod.';

  @override
  String get nextPointTitle => '📏 Next point';

  @override
  String get nextPointText =>
      'Move the rod to the next point. Do not move the level yet. What number do you see?';

  @override
  String get rodNumber => 'Number on the rod (metres)';

  @override
  String pointHeightIs(String v) {
    return 'Height of this point: $v m';
  }

  @override
  String get whatNow => 'What now?';

  @override
  String get addIntermediate => '➕ Measure another point';

  @override
  String get addIntermediateHint => 'The level stays here';

  @override
  String get moveLevel => '🔄 I need to move the level';

  @override
  String get moveLevelHint => 'The rod stays on this point!';

  @override
  String get lastPoint => '🏁 This is the last point';

  @override
  String currentInstrumentNote(String v) {
    return 'Instrument height now: $v m (calculated automatically)';
  }

  @override
  String get moveTitle => '🔄 Move the level';

  @override
  String moveText(String name, String v) {
    return 'The rod stays on $name ($v m). Set up the level at a new place. What number do you see on the same rod now?';
  }

  @override
  String newInstrumentHeightIs(String v) {
    return 'New instrument height: $v m';
  }

  @override
  String get moveNote => 'After that, take the rod to the next point.';

  @override
  String get doneTitle => '🎉 Measurement complete';

  @override
  String get doneText => 'All point heights are listed below.';

  @override
  String get closingCheck => 'Closing check';

  @override
  String get noKnownEnd =>
      'The end benchmark height is not set, so the closing check is skipped.';

  @override
  String get needLength =>
      'Enter the distance travelled (km) to compare with the allowed error.';

  @override
  String get needTolerance => 'Enter the allowed error (mm).';

  @override
  String closingDiff(String mm, String allowed) {
    return 'Difference: $mm mm (allowed $allowed mm)';
  }

  @override
  String closingDiffOnly(String mm) {
    return 'Difference: $mm mm';
  }

  @override
  String get closingOk => '✔ Measurement is accurate';

  @override
  String get closingBad => '✘ Error is too large – repeat the measurement';

  @override
  String get editClosing => '✏ Change end benchmark or tolerance';

  @override
  String get pointsAndHeights => 'Points and their heights';

  @override
  String get undoLast => 'Undo last';

  @override
  String get resetAll => 'Start over';

  @override
  String get resetConfirm => 'Delete everything and start over?';

  @override
  String get paramsTitle => '⚙ Parameters';

  @override
  String get paramsSubtitle => 'Benchmarks and tolerance';

  @override
  String get startBenchmarkName => 'Start benchmark name';

  @override
  String get startBenchmarkHeight => 'Start benchmark height (m)';

  @override
  String get endKnownHeight =>
      'Known height of the end benchmark (m) – optional';

  @override
  String get skip => 'Skip';

  @override
  String get skipHint => 'Can be skipped';

  @override
  String get toleranceTitle => 'Allowed error';

  @override
  String get tolFormula => 'By formula: c × √L';

  @override
  String get tolFixed => 'Fixed value (mm)';

  @override
  String get coefficientC => 'Coefficient c (mm)';

  @override
  String get lengthKm => 'Route length L (km)';

  @override
  String get allowedMm => 'Allowed error (mm)';

  @override
  String get tolFormulaNote =>
      'Allowed error = c × √L. E.g. c = 10, 12, 20 or 50, depending on your standard.';

  @override
  String correctedHeight(String v) {
    return 'Adjusted: $v';
  }

  @override
  String get editPoint => '✏ Edit point';

  @override
  String get editPointHint => 'Changes are recalculated everywhere instantly';

  @override
  String get readingOnRod => 'Rod reading (m)';

  @override
  String get knownHeightOptional => 'Known height of this point (m) – optional';

  @override
  String get fsLabel => 'Foresight – rod on this point, from the old setup (m)';

  @override
  String get bsLabel => 'Backsight – same rod, from the new setup (m)';

  @override
  String get deletePoint => 'Delete point';

  @override
  String get deletePointConfirm => 'Delete this intermediate point?';

  @override
  String get close => 'Close';

  @override
  String get sameLevel => '🎯 At the same height';

  @override
  String cmUp(String v) {
    return '⬆ $v cm higher';
  }

  @override
  String cmDown(String v) {
    return '⬇ $v cm lower';
  }

  @override
  String vsStart(String c) {
    return 'vs start benchmark: $c';
  }

  @override
  String vsTurn(String name, String c) {
    return 'vs turning point $name: $c';
  }

  @override
  String vsEnd(String c) {
    return 'vs end benchmark: $c';
  }

  @override
  String get defaultEndName => 'End';

  @override
  String get metersShort => 'm';

  @override
  String get stakeTip =>
      '🎯 Stakeout: enter the height the start point should have and the slope along the distance. For a floor leave the slope at 0.';

  @override
  String get designStartLabel => 'Design height at the start point (m)';

  @override
  String get slopePercent => 'Slope (%)';

  @override
  String get slopeDirection => 'Direction';

  @override
  String get descending => 'Descending (−)';

  @override
  String get ascending => 'Ascending (+)';

  @override
  String get slopeNote => '0.5% = 5 mm per 1 metre.';

  @override
  String get stakeToleranceLabel => 'Allowed deviation (mm)';

  @override
  String get enterDesign => 'Enter the design height.';

  @override
  String get chainageLabel => 'Distance from the start point (m)';

  @override
  String get chainageLabelOptional =>
      'Distance from the start point (m) – optional';

  @override
  String designHeightIs(String v) {
    return 'Design height: $v m';
  }

  @override
  String rodShouldShow(String v) {
    return 'The rod should read: $v';
  }

  @override
  String actualHeightIs(String v) {
    return 'Actual height: $v m';
  }

  @override
  String verdictExact(String mm) {
    return '✔ Exact ($mm mm)';
  }

  @override
  String verdictRemove(String mm) {
    return '⬇ Remove $mm mm';
  }

  @override
  String verdictFill(String mm) {
    return '⬆ Fill $mm mm';
  }

  @override
  String designShort(String v) {
    return 'Design $v';
  }

  @override
  String get stakeParams => 'Stakeout parameters';

  @override
  String get exportTitle => 'Save';

  @override
  String get exportPdf => 'PDF';

  @override
  String get exportXlsx => 'Excel';

  @override
  String get exportShare => 'Share';

  @override
  String get exportNote =>
      'Use Share to send the file directly via WhatsApp, Viber, Telegram, email and other apps.';

  @override
  String exportSaved(String name) {
    return 'File saved: $name';
  }

  @override
  String get exportShared => 'The share sheet was opened.';

  @override
  String exportError(String e) {
    return 'Error: $e';
  }

  @override
  String reportProject(String name) {
    return 'Project: $name';
  }

  @override
  String get reportJournal => 'Leveling journal';

  @override
  String get reportDate => 'Date';

  @override
  String get reportStartPoint => 'Start point (benchmark)';

  @override
  String get reportHeightM => 'Height (m)';

  @override
  String get reportDesignAtStart => 'Design height at the start point';

  @override
  String get reportSlope => 'Slope (%)';

  @override
  String get reportTolerance => 'Allowed deviation (mm)';

  @override
  String get legendTitle => 'Legend';

  @override
  String get howCalculated => 'How it was calculated';

  @override
  String get howCalculatedPerPoint => 'How it was calculated (each point)';

  @override
  String get controlTitle => 'Control (how it was checked)';

  @override
  String get typeStart => 'Start point (benchmark)';

  @override
  String get typeIntermediate => 'Intermediate point';

  @override
  String get typeTurning => 'Turning point (level moved here)';

  @override
  String get typeEnd => 'End point';

  @override
  String get colNo => '#';

  @override
  String get colPoint => 'Point';

  @override
  String get colType => 'Type';

  @override
  String get colBacksight => 'Backsight (BS)';

  @override
  String get colIntermediate => 'Intermediate reading';

  @override
  String get colForesight => 'Foresight (FS)';

  @override
  String get colInstrument => 'Instrument height';

  @override
  String get colPointHeight => 'Point height (m)';

  @override
  String get colAdjusted => 'Adjusted height (m)';

  @override
  String get colChainage => 'Distance from start (m)';

  @override
  String get colRodReading => 'Rod reading';

  @override
  String get colActualHeight => 'Actual height (m)';

  @override
  String get colDesignHeight => 'Design height (m)';

  @override
  String get colShouldRead => 'Rod should read';

  @override
  String get colDeviation => 'Deviation (mm): + remove, − fill';

  @override
  String get colAction => 'Action';

  @override
  String get actExact => 'Exact';

  @override
  String get actRemove => 'Remove';

  @override
  String get actFill => 'Fill';

  @override
  String get legendM1 =>
      'Start – a point of known height (benchmark) where the measurement begins.';

  @override
  String get legendM2 =>
      'Intermediate – an ordinary point; the level was not moved.';

  @override
  String get legendM3 =>
      'Turning – a point where the rod stayed and the level was moved.';

  @override
  String get legendM4 => 'End – the last point of the measurement.';

  @override
  String get legendM5 =>
      'Backsight (BS) – the rod reading when the rod stands on a point of known height.';

  @override
  String get legendM6 =>
      'Intermediate reading – the rod reading on an intermediate point; the level was not moved.';

  @override
  String get legendM7 =>
      'Foresight (FS) – the rod reading on a turning or end point.';

  @override
  String get legendM8 =>
      'Instrument height – the height of the line of sight (point height + backsight).';

  @override
  String get legendM9 =>
      'Point height (m) – the calculated height of the point in metres.';

  @override
  String get legendM10 =>
      'Adjusted height (m) – the height after distributing the closing error. Shown only when the end benchmark height is set.';

  @override
  String get legendS1 =>
      'Distance from start (m) – distance from the start point, in metres.';

  @override
  String get legendS2 =>
      'Rod reading – the number that was visible on the rod.';

  @override
  String get legendS3 =>
      'Actual height (m) – the height you actually measured.';

  @override
  String get legendS4 =>
      'Design height (m) – the height it should be (start height and slope × distance).';

  @override
  String get legendS5 =>
      'Rod should read – the number the rod should show if the point is at design height.';

  @override
  String get legendS6 =>
      'Deviation (mm) – actual minus design height. Plus (+): actual is above design, remove. Minus (−): below, fill.';

  @override
  String get legendS7 => 'Action – what to do: remove, fill, or exact.';

  @override
  String stepStart(String pn, String start, String bs, String hi) {
    return '$pn: height is known = $start. Instrument height = $start + $bs (backsight) = $hi';
  }

  @override
  String stepIntermediate(String pn, String hp, String r, String rr) {
    return '$pn: height = $hp (instrument height) − $r (reading) = $rr';
  }

  @override
  String stepTurning(
    String pn,
    String hp,
    String fs,
    String rr,
    String bs,
    String hi,
  ) {
    return '$pn: height = $hp (instrument height) − $fs (foresight) = $rr. The level was moved. New instrument height = $rr + $bs (backsight) = $hi';
  }

  @override
  String stepEnd(String pn, String hp, String fs, String rr) {
    return '$pn: height = $hp (instrument height) − $fs (foresight) = $rr';
  }

  @override
  String stepAdjusted(
    String rr,
    String e,
    String setup,
    String cnt,
    String cor,
  ) {
    return 'Adjusted = $rr − ($e × $setup/$cnt) = $cor';
  }

  @override
  String stepDesign(String d0, String slope, String ch, String d) {
    return 'Design = $d0 + ($slope% × $ch m) = $d';
  }

  @override
  String stepStake(
    String hp,
    String d,
    String need,
    String rr,
    String dev,
    String act,
  ) {
    return 'Rod should read = $hp − $d = $need. Deviation = $rr − $d = $dev mm ($act)';
  }

  @override
  String get chkSumBs => 'ΣBS (sum of backsights)';

  @override
  String get chkSumFs => 'ΣFS (sum of foresights)';

  @override
  String get chkDiffSums => 'Difference ΣBS − ΣFS';

  @override
  String get chkEndMinusStart => 'End point − start point';

  @override
  String get chkVerify => 'Verification';

  @override
  String get chkVerifyOk =>
      'Both differences are equal, the calculation is correct';

  @override
  String get chkVerifyBad => 'The differences do not match, check the entries';

  @override
  String get chkKnownEnd => 'Known height of the end point';

  @override
  String get chkError => 'Error';

  @override
  String chkErrorValue(String calc, String known, String e, String mm) {
    return '$calc (calculated) − $known (known) = $e m = $mm mm';
  }

  @override
  String get chkAllowed => 'Allowed error';

  @override
  String chkAllowedFormula(String c, String l, String a) {
    return '$c × √$l = $a mm';
  }

  @override
  String chkAllowedFixed(String a) {
    return '$a mm (fixed)';
  }

  @override
  String get chkConclusion => 'Conclusion';

  @override
  String get chkConclOk => 'The error is acceptable';

  @override
  String get chkConclBad =>
      'The error exceeds the allowed value, repeat the measurement';

  @override
  String get chkAdjust => 'Adjustment';

  @override
  String chkAdjustValue(String n, String mm) {
    return 'The error is distributed evenly over $n setups: $mm mm per setup';
  }
}
