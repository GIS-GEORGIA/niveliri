import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/settings.dart';
import '../../core/leveling.dart';
import 'project.dart';

const _key = 'niv_projects_v1';

class ProjectsNotifier extends Notifier<List<Project>> {
  @override
  List<Project> build() {
    final raw = ref.read(prefsProvider).getString(_key);
    if (raw == null) return [];
    try {
      return (jsonDecode(raw) as List)
          .map((e) => Project.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList();
    } catch (_) {
      return [];
    }
  }

  void _persist() {
    ref.read(prefsProvider).setString(_key, jsonEncode(state.map((p) => p.toJson()).toList()));
  }

  String create(String name, LevelingMode mode) {
    final id = DateTime.now().microsecondsSinceEpoch.toRadixString(36);
    final p = Project(id: id, name: name, settings: LevelingSettings(mode: mode));
    state = [...state, p];
    _persist();
    return id;
  }

  /// Applies [change] to the project and publishes a new list so listeners rebuild.
  void edit(String id, void Function(Project p) change) {
    final p = state.firstWhere((x) => x.id == id);
    change(p);
    p.updated = DateTime.now();
    state = [...state];
    _persist();
  }

  void delete(String id) {
    state = state.where((p) => p.id != id).toList();
    _persist();
  }
}

final projectsProvider = NotifierProvider<ProjectsNotifier, List<Project>>(ProjectsNotifier.new);
