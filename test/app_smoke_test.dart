import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:niveliri/app/settings.dart';
import 'package:niveliri/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('home shows Georgian title, switches to English, credits keep original author',
      (tester) async {
    SharedPreferences.setMockInitialValues({});
    final prefs = await SharedPreferences.getInstance();
    await tester.pumpWidget(ProviderScope(
      overrides: [prefsProvider.overrideWithValue(prefs)],
      child: const NiveliriApp(),
    ));
    await tester.pumpAndSettle();
    expect(find.textContaining('ნიველირის კალკულატორი'), findsOneWidget);

    await tester.tap(find.text('EN'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Leveling Calculator'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.info_outline));
    await tester.pumpAndSettle();
    expect(find.text('Gogita Shainidze'), findsOneWidget);
    expect(find.text('593 55 10 10'), findsOneWidget);
  });
}
