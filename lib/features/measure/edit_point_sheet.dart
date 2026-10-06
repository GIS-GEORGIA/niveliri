import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format.dart';
import '../../core/leveling.dart';
import '../../l10n/app_localizations.dart';
import '../projects/project_store.dart';
import 'widgets.dart';

Future<void> showEditPointSheet(BuildContext context, String projectId, int index) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) => EditPointSheet(projectId: projectId, index: index),
  );
}

class EditPointSheet extends ConsumerWidget {
  const EditPointSheet({super.key, required this.projectId, required this.index});

  final String projectId;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context);
    final store = ref.read(projectsProvider.notifier);
    final project = ref.watch(projectsProvider).firstWhere((p) => p.id == projectId);
    if (index >= project.rows.length) return const SizedBox.shrink();
    final row = project.rows[index];
    final res = computeLeveling(project.rows, project.settings);
    final o = res.points[index];

    void editRow(void Function(LevelRow r) f) => store.edit(projectId, (p) => f(p.rows[index]));
    void editSettings(LevelingSettings Function(LevelingSettings s) f) =>
        store.edit(projectId, (p) => p.settings = f(p.settings));

    final fields = <Widget>[
      TextFormField(
        initialValue: row.name,
        decoration: InputDecoration(labelText: t.pointName),
        onChanged: (v) {
          editRow((r) => r.name = v);
          if (index == 0) editSettings((s) => s.copyWith(startName: v));
        },
      ),
    ];
    Widget gap(Widget w) => Padding(padding: const EdgeInsets.only(top: 12), child: w);

    switch (row.type) {
      case PointType.start:
        fields.add(gap(NumField(
          label: t.startBenchmarkHeight,
          value: project.settings.startHeight,
          onChanged: (v) => editSettings((s) => s.copyWith(startHeight: v ?? double.nan)),
        )));
        fields.add(gap(NumField(
          label: t.readingOnRod,
          value: row.backsight,
          onChanged: (v) => editRow((r) => r.backsight = v),
        )));
      case PointType.intermediate:
        fields.add(gap(NumField(
          label: t.readingOnRod,
          value: row.intermediate,
          onChanged: (v) => editRow((r) => r.intermediate = v),
        )));
      case PointType.turning:
        fields.add(gap(NumField(
          label: t.fsLabel,
          value: row.foresight,
          onChanged: (v) => editRow((r) => r.foresight = v),
        )));
        fields.add(gap(NumField(
          label: t.bsLabel,
          value: row.backsight,
          onChanged: (v) => editRow((r) => r.backsight = v),
        )));
      case PointType.end:
        fields.add(gap(NumField(
          label: t.readingOnRod,
          value: row.foresight,
          onChanged: (v) => editRow((r) => r.foresight = v),
        )));
        fields.add(gap(NumField(
          label: t.knownHeightOptional,
          value: project.settings.knownEndHeight,
          hint: t.skipHint,
          onChanged: (v) => editSettings((s) => s.copyWith(knownEndHeight: v ?? double.nan)),
        )));
    }

    if (project.mode == LevelingMode.stake && index > 0) {
      fields.add(gap(NumField(
        label: t.chainageLabel,
        value: row.chainage,
        onChanged: (v) => editRow((r) => r.chainage = v),
      )));
    }

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(16, 0, 16, 16 + MediaQuery.of(context).viewInsets.bottom),
        child: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(t.editPoint, style: Theme.of(context).textTheme.titleMedium),
            Text(t.editPointHint, style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 8),
            ...fields,
            const SizedBox(height: 12),
            Text(
              t.pointHeightIs(f3(o.height)) +
                  (o.instrumentHeight.isFinite &&
                          row.type != PointType.intermediate &&
                          row.type != PointType.end
                      ? '   ·   ${t.instrumentHeightIs(f3(o.instrumentHeight))}'
                      : ''),
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
            ),
            const SizedBox(height: 12),
            Row(children: [
              FilledButton(onPressed: () => Navigator.pop(context), child: Text(t.close)),
              if (row.type == PointType.intermediate) ...[
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  icon: const Icon(Icons.delete_outline),
                  label: Text(t.deletePoint),
                  onPressed: () async {
                    final ok = await showDialog<bool>(
                      context: context,
                      builder: (c) => AlertDialog(
                        content: Text(t.deletePointConfirm),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(c, false), child: Text(t.cancel)),
                          TextButton(onPressed: () => Navigator.pop(c, true), child: Text(t.delete)),
                        ],
                      ),
                    );
                    if (ok == true && context.mounted) {
                      store.edit(projectId, (p) => p.rows.removeAt(index));
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ]),
          ]),
        ),
      ),
    );
  }
}
