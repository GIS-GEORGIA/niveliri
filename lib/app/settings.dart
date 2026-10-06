import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSettings {
  const AppSettings({this.themeMode = ThemeMode.system, this.locale = const Locale('ka')});
  final ThemeMode themeMode;
  final Locale locale;
}

final prefsProvider = Provider<SharedPreferences>((_) => throw UnimplementedError());

class SettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() {
    final p = ref.read(prefsProvider);
    final theme = ThemeMode.values.byName(p.getString('theme') ?? 'system');
    return AppSettings(themeMode: theme, locale: Locale(p.getString('lang') ?? 'ka'));
  }

  void setTheme(ThemeMode m) {
    ref.read(prefsProvider).setString('theme', m.name);
    state = AppSettings(themeMode: m, locale: state.locale);
  }

  void setLocale(Locale l) {
    ref.read(prefsProvider).setString('lang', l.languageCode);
    state = AppSettings(themeMode: state.themeMode, locale: l);
  }
}

final settingsProvider = NotifierProvider<SettingsNotifier, AppSettings>(SettingsNotifier.new);
