/// Three decimals, or an em dash for NaN/infinity.
String f3(double x) => x.isFinite ? x.toStringAsFixed(3) : '—';

/// Parses user input; accepts a comma as the decimal separator.
double? parseNum(String s) {
  final t = s.trim().replaceAll(',', '.');
  if (t.isEmpty) return null;
  final v = double.tryParse(t);
  return v != null && v.isFinite ? v : null;
}

String numText(double? v) =>
    v == null || !v.isFinite ? '' : (v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString());
