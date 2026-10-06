import 'package:flutter/material.dart';

// Palette taken from the original app (green accent on light / dark surfaces).
ThemeData buildTheme(Brightness b) {
  final dark = b == Brightness.dark;
  final scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF0B6E4F),
    brightness: b,
  ).copyWith(
    primary: dark ? const Color(0xFF3ECF9B) : const Color(0xFF0B6E4F),
    surface: dark ? const Color(0xFF1B2129) : Colors.white,
    error: dark ? const Color(0xFFFF7B6B) : const Color(0xFFC0392B),
  );
  return ThemeData(
    useMaterial3: true,
    fontFamily: 'NotoSansGeorgian',
    colorScheme: scheme,
    scaffoldBackgroundColor: dark ? const Color(0xFF12161B) : const Color(0xFFF6F7F9),
    cardTheme: CardThemeData(
      elevation: 0,
      color: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: dark ? const Color(0xFF2E3742) : const Color(0xFFD8DDE4)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
