import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format.dart';
import '../../export/export_service.dart';
import '../../core/leveling.dart';
import '../../l10n/app_localizations.dart';
import '../projects/project.dart';
import '../projects/project_store.dart';
import 'edit_point_sheet.dart';
import 'widgets.dart';

enum _Phase { start, read, newBacksight, done }

_Phase _phaseOf(List<LevelRow> rows) {
  if (rows.isEmpty) return _Phase.start;
  final l = rows.last;
  if (l.type == PointType.end) return _Phase.done;
  if (l.type == PointType.turning && l.backsight == null) return _Phase.newBacksight;
  return _Phase.read;
}

class MeasureScreen extends ConsumerStatefulWidget {
  const MeasureScreen({super.key, required this.projectId});
  final String projectId;

  @override
  ConsumerState<MeasureScreen> createState() => _MeasureScreenState();
}

class _MeasureScreenState extends ConsumerState<MeasureScreen> {
  final _name = TextEditingController();
  final _height = TextEditingController();
  final _reading = TextEditingController();
  final _focus = FocusNode();

  // Stakeout mode inputs.
  final _chain = TextEditingController();
  final _design = TextEditingController();
  final _slope = TextEditingController(text: '0');
  final _stakeTol = TextEditingController(text: '5');
  int _slopeSign = -1;

  @override
  void dispose() {
    _chain.dispose();
    _design.dispose();
    _slope.dispose();
    _stakeTol.dispose();
    _name.dispose();
    _height.dispose();
    _reading.dispose();
    _focus.dispose();
    super.dispose();
  }

  ProjectsNotifier get _store => ref.read(projectsProvider.notifier);

  void _toast(String m) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

  void _clear() {
    _name.clear();
    _reading.clear();
    _chain.clear();
    _focus.requestFocus();
  }

  void _startGo(AppLocalizations t) {
    final h = parseNum(_height.text), x = parseNum(_reading.text);
    if (h == null || x == null) return _toast(t.fillHeightAndReading);
    final stake = ref.read(projectsProvider).firstWhere((p) => p.id == widget.projectId).mode ==
        LevelingMode.stake;
    final d0 = parseNum(_design.text);
    if (stake && d0 == null) return _toast(t.enterDesign);
    final name = _name.text.trim().isEmpty ? 'Rp1' : _name.text.trim();
    _store.edit(widget.projectId, (p) {
      p.settings = p.settings.copyWith(startName: name, startHeight: h);
      if (stake) {
        p.settings = p.settings.copyWith(
          designStart: d0,
          slopePercent: parseNum(_slope.text) ?? 0,
          slopeSign: _slopeSign,
          stakeToleranceMm: parseNum(_stakeTol.text) ?? 5,
        );
      }
      p.rows
        ..clear()
        ..add(LevelRow(name: name, type: PointType.start, backsight: x));
    });
    _clear();
  }

  void _addPoint(AppLocalizations t, PointType type) {
    final x = parseNum(_reading.text);
    if (x == null) return _toast(t.fillReading);
    _store.edit(widget.projectId, (p) {
      final tp = p.rows.where((r) => r.type == PointType.turning).length + 1;
      final def = switch (type) {
        PointType.turning => 'TP$tp',
        PointType.end => t.defaultEndName,
        _ => 'P${p.rows.length}',
      };
      final name = _name.text.trim().isEmpty ? def : _name.text.trim();
      p.rows.add(LevelRow(
        name: name,
        type: type,
        intermediate: type == PointType.intermediate ? x : null,
        foresight: type == PointType.intermediate ? null : x,
        chainage: p.mode == LevelingMode.stake ? parseNum(_chain.text) : null,
      ));
    });
    _clear();
  }

  void _newBacksight(AppLocalizations t) {
    final x = parseNum(_reading.text);
    if (x == null) return _toast(t.fillReading);
    _store.edit(widget.projectId, (p) => p.rows.last.backsight = x);
    _clear();
  }

  void _undo() {
    _store.edit(widget.projectId, (p) {
      if (p.rows.isEmpty) return;
      final l = p.rows.last;
      if (l.type == PointType.turning && l.backsight != null) {
        l.backsight = null;
      } else {
        p.rows.removeLast();
      }
    });
    _clear();
  }

  Future<void> _reset(AppLocalizations t) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        content: Text(t.resetConfirm),
        actions: [
          TextButton(onPressed: () => Navigator.pop(c, false), child: Text(t.cancel)),
          TextButton(onPressed: () => Navigator.pop(c, true), child: Text(t.resetAll)),
        ],
      ),
    );
    if (ok != true) return;
    _store.edit(widget.projectId, (p) {
      p.rows.clear();
      p.settings = p.settings.copyWith(startHeight: double.nan, knownEndHeight: double.nan);
    });
    _height.clear();
    _clear();
  }

  /// Stakeout verdict for a deviation in mm (positive: remove, negative: fill).
  (String, bool) _verdict(AppLocalizations t, double devMm, double tol) {
    if (!devMm.isFinite) return ('—', true);
    final a = devMm.abs();
    return switch (stakeAction(devMm, tol)) {
      StakeAction.exact => (t.verdictExact(devMm.toStringAsFixed(1)), true),
      StakeAction.remove => (t.verdictRemove(a.toStringAsFixed(0)), false),
      StakeAction.fill => (t.verdictFill(a.toStringAsFixed(0)), false),
    };
  }

  /// Height difference to a reference, as a short sentence (null when unknown).
  String _cmp(AppLocalizations t, double h, double ref) {
    final d = h - ref;
    if (!d.isFinite) return '';
    final cm = (d * 100).abs();
    if (cm < 0.05) return t.sameLevel;
    final v = cm.toStringAsFixed(1);
    return d > 0 ? t.cmUp(v) : t.cmDown(v);
  }

  String _refs(AppLocalizations t, Project p, LevelingResult res, int idx, double h) {
    if (!h.isFinite) return '';
    final a = <String>[];
    final st = p.settings.startHeight, k = p.settings.knownEndHeight;
    if (idx > 0 && st.isFinite) a.add(t.vsStart(_cmp(t, h, st)));
    for (var q = idx - 1; q > 0; q--) {
      if (p.rows[q].type == PointType.turning) {
        a.add(t.vsTurn(p.rows[q].name, _cmp(t, h, res.points[q].height)));
        break;
      }
    }
    if (k.isFinite) a.add(t.vsEnd(_cmp(t, h, k)));
    return a.join('\n');
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final projects = ref.watch(projectsProvider);
    final i = projects.indexWhere((p) => p.id == widget.projectId);
    if (i < 0) return const Scaffold();
    final p = projects[i];
    final res = computeLeveling(p.rows, p.settings);
    final phase = _phaseOf(p.rows);
    final th = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(p.name)),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: switch (phase) {
                    _Phase.start => _startCard(t, th, p),
                    _Phase.read => _readCard(t, th, p, res),
                    _Phase.newBacksight => _newBsCard(t, th, p, res),
                    _Phase.done => _doneCard(t, th, p, res),
                  },
                ),
              ),
              if (p.rows.isNotEmpty) ...[
                const SizedBox(height: 12),
                _paramsCard(t, p),
                const SizedBox(height: 12),
                _listCard(t, th, p, res),
                if (p.rows.length > 1) ...[
                  const SizedBox(height: 12),
                  _exportCard(t, p),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(ThemeData th, String s) =>
      Padding(padding: const EdgeInsets.only(bottom: 8), child: Text(s, style: th.textTheme.titleLarge));

  Widget _preview(ThemeData th, String s) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(s,
            style: th.textTheme.titleMedium
                ?.copyWith(color: th.colorScheme.primary, fontWeight: FontWeight.bold)),
      );

  Widget _stakeStartFields(AppLocalizations t, ThemeData th) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: th.colorScheme.primary.withValues(alpha: 0.08),
          border: Border(left: BorderSide(color: th.colorScheme.primary, width: 3)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(t.stakeTip),
      ),
      const SizedBox(height: 12),
      NumField(label: t.designStartLabel, controller: _design, big: true, hint: '100.000'),
      const SizedBox(height: 12),
      Row(children: [
        Expanded(child: NumField(label: t.slopePercent, controller: _slope)),
        const SizedBox(width: 12),
        Expanded(
          child: DropdownButtonFormField<int>(
            initialValue: _slopeSign,
            decoration: InputDecoration(labelText: t.slopeDirection),
            items: [
              DropdownMenuItem(value: -1, child: Text(t.descending)),
              DropdownMenuItem(value: 1, child: Text(t.ascending)),
            ],
            onChanged: (v) => setState(() => _slopeSign = v ?? -1),
          ),
        ),
      ]),
      Padding(
          padding: const EdgeInsets.only(top: 4), child: Text(t.slopeNote, style: th.textTheme.bodySmall)),
      const SizedBox(height: 12),
      NumField(label: t.stakeToleranceLabel, controller: _stakeTol),
      const SizedBox(height: 12),
    ]);
  }

  Widget _startCard(AppLocalizations t, ThemeData th, Project p) {
    final h = parseNum(_height.text), x = parseNum(_reading.text);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _title(th, t.step1Title),
      Text(t.step1Text),
      const SizedBox(height: 12),
      TextField(controller: _name, decoration: InputDecoration(labelText: t.pointName, hintText: 'Rp1')),
      const SizedBox(height: 12),
      NumField(
          label: t.startHeightLabel,
          controller: _height,
          big: true,
          hint: '100',
          onChanged: (_) => setState(() {})),
      const SizedBox(height: 12),
      if (p.mode == LevelingMode.stake) _stakeStartFields(t, th),
      Text(t.rodReadingFirst),
      const SizedBox(height: 8),
      NumField(
          label: t.rodNumber,
          controller: _reading,
          big: true,
          hint: '1.500',
          onChanged: (_) => setState(() {})),
      _preview(th, h != null && x != null ? t.instrumentHeightIs(f3(h + x)) : ''),
      BigChoice(title: t.continueBtn, onPressed: () => _startGo(t)),
    ]);
  }

  Widget _readCard(AppLocalizations t, ThemeData th, Project p, LevelingResult res) {
    final last = p.rows.length - 1;
    final hi = res.points[last].instrumentHeight;
    final x = parseNum(_reading.text);
    final pointH = x == null ? double.nan : hi - x;
    final refs = _refs(t, p, res, p.rows.length, pointH);
    final stake = p.mode == LevelingMode.stake;
    final design = p.settings.designAt(parseNum(_chain.text));
    final verdict = _verdict(t, (pointH - design) * 1000, p.settings.stakeToleranceMm);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _title(th, t.nextPointTitle),
      Text(t.nextPointText),
      const SizedBox(height: 12),
      TextField(controller: _name, decoration: InputDecoration(labelText: t.pointNameOptional, hintText: 'P${p.rows.length}')),
      if (stake) ...[
        const SizedBox(height: 12),
        NumField(
            label: p.settings.slopePercent != 0 ? t.chainageLabel : t.chainageLabelOptional,
            controller: _chain,
            hint: '12.5',
            onChanged: (_) => setState(() {})),
      ],
      const SizedBox(height: 12),
      NumField(
          label: t.rodNumber,
          controller: _reading,
          big: true,
          hint: '1.850',
          autofocus: true,
          onChanged: (_) => setState(() {})),
      if (stake) ...[
        _preview(th, '${t.designHeightIs(f3(design))}\n${t.rodShouldShow(f3(hi - design))}'),
        if (x != null) ...[
          Text(t.actualHeightIs(f3(pointH))),
          Text(verdict.$1,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: verdict.$2 ? th.colorScheme.primary : th.colorScheme.error)),
        ],
      ] else
        _preview(th, x != null ? t.pointHeightIs(f3(pointH)) : ''),
      if (refs.isNotEmpty) Text(refs, style: th.textTheme.bodyMedium?.copyWith(height: 1.6)),
      const SizedBox(height: 8),
      Text(t.whatNow, style: const TextStyle(fontWeight: FontWeight.bold)),
      BigChoice(
          title: t.addIntermediate,
          subtitle: t.addIntermediateHint,
          onPressed: () => _addPoint(t, PointType.intermediate)),
      BigChoice(
          title: t.moveLevel,
          subtitle: t.moveLevelHint,
          color: const Color(0xFF2F6FB3),
          onPressed: () => _addPoint(t, PointType.turning)),
      BigChoice(
          title: t.lastPoint,
          color: const Color(0xFF7A5A1E),
          onPressed: () => _addPoint(t, PointType.end)),
      const SizedBox(height: 8),
      Text(t.currentInstrumentNote(f3(hi)), style: th.textTheme.bodySmall),
    ]);
  }

  Widget _newBsCard(AppLocalizations t, ThemeData th, Project p, LevelingResult res) {
    final last = p.rows.length - 1;
    final x = parseNum(_reading.text);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _title(th, t.moveTitle),
      Text(t.moveText(p.rows[last].name, f3(res.points[last].height))),
      const SizedBox(height: 12),
      NumField(
          label: t.rodNumber,
          controller: _reading,
          big: true,
          hint: '1.200',
          autofocus: true,
          onChanged: (_) => setState(() {})),
      _preview(th, x != null ? t.newInstrumentHeightIs(f3(res.points[last].height + x)) : ''),
      BigChoice(title: t.continueBtn, onPressed: () => _newBacksight(t)),
      const SizedBox(height: 8),
      Text(t.moveNote, style: th.textTheme.bodySmall),
    ]);
  }

  Widget _doneCard(AppLocalizations t, ThemeData th, Project p, LevelingResult res) {
    final s = p.settings;
    final e = res.closingError;
    Widget body;
    if (!e.isFinite) {
      body = Text(t.noKnownEnd);
    } else if (!(res.allowedMm > 0)) {
      body = Text('${t.closingDiffOnly((e * 1000).toStringAsFixed(1))}\n'
          '${s.toleranceMode == ToleranceMode.fixed ? t.needTolerance : t.needLength}');
    } else {
      final ok = res.closingOk;
      body = Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(t.closingDiff((e * 1000).toStringAsFixed(1), res.allowedMm.toStringAsFixed(1))),
        Text(ok ? t.closingOk : t.closingBad,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: ok ? th.colorScheme.primary : th.colorScheme.error)),
      ]);
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      _title(th, t.doneTitle),
      Text(t.doneText),
      const SizedBox(height: 12),
      Text(t.closingCheck, style: const TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 4),
      body,
    ]);
  }

  Widget _paramsCard(AppLocalizations t, Project p) {
    final s = p.settings;
    void set(LevelingSettings Function(LevelingSettings s) f) =>
        _store.edit(widget.projectId, (x) => x.settings = f(x.settings));
    final fixed = s.toleranceMode == ToleranceMode.fixed;
    Widget gap(Widget w) => Padding(padding: const EdgeInsets.only(top: 12), child: w);
    return Card(
      child: ExpansionTile(
        shape: const Border(),
        collapsedShape: const Border(),
        title: Text(t.paramsTitle),
        subtitle: Text(t.paramsSubtitle),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          Row(children: [
            Expanded(
              child: TextFormField(
                initialValue: s.startName,
                decoration: InputDecoration(labelText: t.startBenchmarkName),
                onChanged: (v) => _store.edit(widget.projectId, (x) {
                  x.settings = x.settings.copyWith(startName: v);
                  if (x.rows.isNotEmpty) x.rows.first.name = v;
                }),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: NumField(
                  label: t.startBenchmarkHeight,
                  value: s.startHeight,
                  onChanged: (v) => set((s) => s.copyWith(startHeight: v ?? double.nan))),
            ),
          ]),
          gap(NumField(
            label: t.endKnownHeight,
            value: s.knownEndHeight,
            hint: t.skipHint,
            onChanged: (v) => set((s) => s.copyWith(knownEndHeight: v ?? double.nan)),
          )),
          if (s.mode == LevelingMode.stake) ...[
            gap(Text(t.stakeParams, style: const TextStyle(fontWeight: FontWeight.bold))),
            gap(NumField(
              key: const ValueKey('design0'),
              label: t.designStartLabel,
              value: s.designStart,
              onChanged: (v) => set((s) => s.copyWith(designStart: v ?? double.nan)),
            )),
            gap(Row(children: [
              Expanded(
                child: NumField(
                  key: const ValueKey('slope'),
                  label: t.slopePercent,
                  value: s.slopePercent,
                  onChanged: (v) => set((s) => s.copyWith(slopePercent: v ?? 0)),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: DropdownButtonFormField<int>(
                  initialValue: s.slopeSign,
                  decoration: InputDecoration(labelText: t.slopeDirection),
                  items: [
                    DropdownMenuItem(value: -1, child: Text(t.descending)),
                    DropdownMenuItem(value: 1, child: Text(t.ascending)),
                  ],
                  onChanged: (v) => set((s) => s.copyWith(slopeSign: v)),
                ),
              ),
            ])),
            gap(NumField(
              key: const ValueKey('staketol'),
              label: t.stakeToleranceLabel,
              value: s.stakeToleranceMm,
              onChanged: (v) => set((s) => s.copyWith(stakeToleranceMm: v ?? 5)),
            )),
          ],
          gap(DropdownButtonFormField<ToleranceMode>(
            initialValue: s.toleranceMode,
            decoration: InputDecoration(labelText: t.toleranceTitle),
            items: [
              DropdownMenuItem(value: ToleranceMode.formula, child: Text(t.tolFormula)),
              DropdownMenuItem(value: ToleranceMode.fixed, child: Text(t.tolFixed)),
            ],
            onChanged: (m) => set((s) => s.copyWith(toleranceMode: m)),
          )),
          if (fixed)
            gap(NumField(
              key: const ValueKey('tolfixed'),
              label: t.allowedMm,
              value: s.fixedToleranceMm,
              onChanged: (v) => set((s) => s.copyWith(fixedToleranceMm: v ?? double.nan)),
            ))
          else ...[
            gap(Row(children: [
              Expanded(
                child: NumField(
                    key: const ValueKey('c'),
                    label: t.coefficientC,
                    value: s.coefficient,
                    onChanged: (v) => set((s) => s.copyWith(coefficient: v ?? double.nan))),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: NumField(
                    key: const ValueKey('l'),
                    label: t.lengthKm,
                    value: s.lengthKm,
                    hint: '0.3',
                    onChanged: (v) => set((s) => s.copyWith(lengthKm: v ?? double.nan))),
              ),
            ])),
            gap(Text(t.tolFormulaNote, style: Theme.of(context).textTheme.bodySmall)),
          ],
        ],
      ),
    );
  }

  Future<void> _export(AppLocalizations t, Project p, ExportFormat f, bool share) async {
    try {
      final (outcome, name) = await exportProject(p, t, f, share: share);
      if (!mounted) return;
      _toast(outcome == ExportOutcome.saved ? t.exportSaved(name) : t.exportShared);
    } catch (e) {
      if (mounted) _toast(t.exportError('$e'));
    }
  }

  Widget _exportCard(AppLocalizations t, Project p) {
    Widget row(ExportFormat f, String label, IconData icon) => Row(children: [
          Expanded(
            child: FilledButton.icon(
              onPressed: () => _export(t, p, f, false),
              icon: Icon(icon),
              label: Text(label),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _export(t, p, f, true),
              icon: const Icon(Icons.ios_share),
              label: Text('$label · ${t.exportShare}'),
            ),
          ),
        ]);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(t.exportTitle, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          row(ExportFormat.pdf, t.exportPdf, Icons.picture_as_pdf_outlined),
          const SizedBox(height: 8),
          row(ExportFormat.xlsx, t.exportXlsx, Icons.table_chart_outlined),
          const SizedBox(height: 8),
          Text(t.exportNote, style: Theme.of(context).textTheme.bodySmall),
        ]),
      ),
    );
  }

  Widget _listCard(AppLocalizations t, ThemeData th, Project p, LevelingResult res) {
    const icons = {
      PointType.start: '📍',
      PointType.intermediate: '•',
      PointType.turning: '🔄',
      PointType.end: '🏁',
    };
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(t.pointsAndHeights, style: const TextStyle(fontWeight: FontWeight.bold)),
          for (var i = 0; i < p.rows.length; i++) ...[
            const Divider(height: 16),
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              IconButton(
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.edit_outlined, size: 20),
                onPressed: () => showEditPointSheet(context, p.id, i),
              ),
              Expanded(
                  child: Text('${icons[p.rows[i].type]} ${p.rows[i].name}'
                      '${p.rows[i].chainage != null ? '  (${numText(p.rows[i].chainage)} ${t.metersShort})' : ''}')),
              Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text('${f3(res.points[i].height)} ${t.metersShort}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontFeatures: [FontFeature.tabularFigures()])),
                if (p.mode == LevelingMode.stake && i > 0) ...[
                  Text(t.designShort(f3(res.points[i].design)), style: th.textTheme.bodySmall),
                  Builder(builder: (_) {
                    final v = _verdict(t, res.points[i].deviationMm, p.settings.stakeToleranceMm);
                    return Text(v.$1,
                        style: th.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: v.$2 ? th.colorScheme.primary : th.colorScheme.error));
                  }),
                ],
                if (i > 0 && _refs(t, p, res, i, res.points[i].height).isNotEmpty)
                  Text(_refs(t, p, res, i, res.points[i].height),
                      textAlign: TextAlign.end, style: th.textTheme.bodySmall),
                if (res.points[i].corrected.isFinite)
                  Text(t.correctedHeight(f3(res.points[i].corrected)),
                      style: th.textTheme.bodySmall?.copyWith(color: th.hintColor)),
              ]),
            ]),
          ],
          const SizedBox(height: 8),
          Wrap(spacing: 8, children: [
            OutlinedButton.icon(
                onPressed: _undo, icon: const Icon(Icons.undo), label: Text(t.undoLast)),
            OutlinedButton.icon(
                onPressed: () => _reset(t),
                icon: const Icon(Icons.delete_outline),
                label: Text(t.resetAll)),
          ]),
        ]),
      ),
    );
  }
}
