import '../../core/leveling.dart';

double? _n(num? x) => x == null || (x is double && x.isNaN) ? null : x.toDouble();
double _d(num? x) => x == null ? double.nan : x.toDouble();

Map<String, dynamic> settingsToJson(LevelingSettings s) => {
      'startName': s.startName,
      'startHeight': _n(s.startHeight),
      'knownEndHeight': _n(s.knownEndHeight),
      'toleranceMode': s.toleranceMode.name,
      'coefficient': s.coefficient,
      'lengthKm': _n(s.lengthKm),
      'fixedToleranceMm': s.fixedToleranceMm,
      'mode': s.mode.name,
      'designStart': _n(s.designStart),
      'slopePercent': s.slopePercent,
      'slopeSign': s.slopeSign,
      'stakeToleranceMm': s.stakeToleranceMm,
    };

LevelingSettings settingsFromJson(Map<String, dynamic> j) => LevelingSettings(
      startName: j['startName'] as String? ?? 'Rp1',
      startHeight: _d(j['startHeight'] as num?),
      knownEndHeight: _d(j['knownEndHeight'] as num?),
      toleranceMode: ToleranceMode.values.byName(j['toleranceMode'] as String? ?? 'formula'),
      coefficient: (j['coefficient'] as num?)?.toDouble() ?? 12,
      lengthKm: _d(j['lengthKm'] as num?),
      fixedToleranceMm: (j['fixedToleranceMm'] as num?)?.toDouble() ?? 10,
      mode: LevelingMode.values.byName(j['mode'] as String? ?? 'measure'),
      designStart: _d(j['designStart'] as num?),
      slopePercent: (j['slopePercent'] as num?)?.toDouble() ?? 0,
      slopeSign: (j['slopeSign'] as num?)?.toInt() ?? -1,
      stakeToleranceMm: (j['stakeToleranceMm'] as num?)?.toDouble() ?? 5,
    );

class Project {
  Project({
    required this.id,
    required this.name,
    required this.settings,
    List<LevelRow>? rows,
    DateTime? updated,
  })  : rows = rows ?? [],
        updated = updated ?? DateTime.now();

  final String id;
  String name;
  LevelingSettings settings;
  final List<LevelRow> rows;
  DateTime updated;

  LevelingMode get mode => settings.mode;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'settings': settingsToJson(settings),
        'rows': rows.map((r) => r.toJson()).toList(),
        'updated': updated.millisecondsSinceEpoch,
      };

  factory Project.fromJson(Map<String, dynamic> j) => Project(
        id: j['id'] as String,
        name: j['name'] as String,
        settings: settingsFromJson(Map<String, dynamic>.from(j['settings'] as Map)),
        rows: (j['rows'] as List)
            .map((e) => LevelRow.fromJson(Map<String, dynamic>.from(e as Map)))
            .toList(),
        updated: DateTime.fromMillisecondsSinceEpoch(j['updated'] as int),
      );
}
