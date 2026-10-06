import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/settings.dart';
import '../../core/leveling.dart';
import '../../l10n/app_localizations.dart';
import '../about/about_screen.dart';
import '../measure/measure_screen.dart';
import '../projects/project.dart';
import '../projects/project_store.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _name = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  void _open(String id) =>
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => MeasureScreen(projectId: id)));

  void _create(AppLocalizations t, LevelingMode mode) {
    final n = _name.text.trim();
    if (n.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(t.enterProjectName)));
      return;
    }
    final id = ref.read(projectsProvider.notifier).create(n, mode);
    _name.clear();
    _open(id);
  }

  void _example(AppLocalizations t) {
    final store = ref.read(projectsProvider.notifier);
    final id = store.create(t.exampleName, LevelingMode.measure);
    store.edit(id, (p) {
      p.settings = p.settings.copyWith(
          startName: 'Rp1', startHeight: 100, knownEndHeight: 100.240, lengthKm: 0.2);
      p.rows.addAll([
        LevelRow(name: 'Rp1', type: PointType.start, backsight: 1.523),
        LevelRow(name: 'P1', type: PointType.intermediate, intermediate: 1.310),
        LevelRow(name: 'TP1', type: PointType.turning, foresight: 1.742, backsight: 1.605),
        LevelRow(name: 'P2', type: PointType.intermediate, intermediate: 0.987),
        LevelRow(name: 'Rp2', type: PointType.end, foresight: 1.150),
      ]);
    });
    _open(id);
  }

  Future<void> _delete(AppLocalizations t, Project p) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        content: Text(t.deleteProjectConfirm(p.name)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: Text(t.cancel)),
          TextButton(onPressed: () => Navigator.pop(c, true), child: Text(t.delete)),
        ],
      ),
    );
    if (ok == true) ref.read(projectsProvider.notifier).delete(p.id);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final th = Theme.of(context);
    final s = ref.watch(settingsProvider);
    final n = ref.read(settingsProvider.notifier);
    final projects = [...ref.watch(projectsProvider)]..sort((a, b) => b.updated.compareTo(a.updated));
    final loc = s.locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        title: Text('📐 ${t.appTitle}'),
        actions: [
          TextButton(
            onPressed: () => n.setLocale(Locale(loc == 'ka' ? 'en' : 'ka')),
            child: Text(loc == 'ka' ? 'EN' : 'ქარ'),
          ),
          PopupMenuButton<ThemeMode>(
            icon: const Icon(Icons.brightness_6),
            tooltip: t.theme,
            initialValue: s.themeMode,
            onSelected: n.setTheme,
            itemBuilder: (_) => [
              PopupMenuItem(value: ThemeMode.system, child: Text(t.themeSystem)),
              PopupMenuItem(value: ThemeMode.light, child: Text(t.themeLight)),
              PopupMenuItem(value: ThemeMode.dark, child: Text(t.themeDark)),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.info_outline),
            tooltip: t.about,
            onPressed: () => Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => const AboutScreen())),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(t.appTagline, style: th.textTheme.bodyMedium),
              TextButton(
                  onPressed: () => _example(t),
                  style: TextButton.styleFrom(alignment: Alignment.centerLeft, padding: EdgeInsets.zero),
                  child: Text(t.loadExample)),
              const SizedBox(height: 8),
              TextField(
                controller: _name,
                decoration: InputDecoration(labelText: t.newProjectName, hintText: t.projectNameHint),
                onSubmitted: (_) => _create(t, LevelingMode.measure),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () => _create(t, LevelingMode.measure),
                icon: const Icon(Icons.straighten),
                label: Text('${t.newMeasurement} · ${t.newMeasurementHint}'),
              ),
              const SizedBox(height: 8),
              FilledButton.tonalIcon(
                onPressed: () => _create(t, LevelingMode.stake),
                icon: const Icon(Icons.flag_outlined),
                label: Text('${t.newStakeout} · ${t.newStakeoutHint}'),
              ),
              const SizedBox(height: 24),
              Text(t.projects, style: th.textTheme.titleLarge),
              const SizedBox(height: 8),
              if (projects.isEmpty) Text(t.noProjects),
              for (final p in projects)
                Card(
                  child: ListTile(
                    leading: Icon(p.mode == LevelingMode.stake ? Icons.flag_outlined : Icons.straighten),
                    title: Text(p.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        '${MaterialLocalizations.of(context).formatShortDate(p.updated)} · ${t.pointsCount(p.rows.length)}'),
                    onTap: () => _open(p.id),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      tooltip: t.delete,
                      onPressed: () => _delete(t, p),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
