import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:niveliri/app/settings.dart';
import 'package:niveliri/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ProviderContainer> pumpApp(WidgetTester tester) async {
  SharedPreferences.setMockInitialValues({});
  final prefs = await SharedPreferences.getInstance();
  tester.view.physicalSize = const Size(900, 2400);
  tester.view.devicePixelRatio = 1;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(ProviderScope(
    overrides: [prefsProvider.overrideWithValue(prefs)],
    child: const NiveliriApp(),
  ));
  await tester.pumpAndSettle();
  return ProviderScope.containerOf(tester.element(find.byType(NiveliriApp)));
}

void main() {
  testWidgets('example project shows computed heights and closing check', (tester) async {
    await pumpApp(tester);
    await tester.tap(find.text('მაგალითის ნახვა'));
    await tester.pumpAndSettle();
    expect(find.text('🎉 გაზომვა დასრულებულია'), findsOneWidget);
    expect(find.text('100.213 მ'), findsOneWidget);
    expect(find.text('99.781 მ'), findsOneWidget);
    expect(find.text('100.236 მ'), findsOneWidget);
    expect(find.textContaining('✔ გაზომვა ზუსტია'), findsOneWidget);
  });

  testWidgets('step-by-step flow: start, intermediate, move level, end', (tester) async {
    await pumpApp(tester);
    await tester.enterText(find.byType(TextField).first, 'ეზო');
    await tester.tap(find.textContaining('ახალი გაზომვა'));
    await tester.pumpAndSettle();
    expect(find.text('1️⃣ საწყისი წერტილი'), findsOneWidget);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), '100');
    await tester.enterText(fields.at(1), '1,523'); // comma decimal accepted
    await tester.pump();
    expect(find.text('ნიველირის ხედვის სიმაღლე: 101.523 მ'), findsOneWidget);
    await tester.tap(find.text('გაგრძელება →'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, '1.310');
    await tester.pump();
    expect(find.text('ამ წერტილის სიმაღლე: 100.213 მ'), findsOneWidget);
    await tester.tap(find.text('➕ კიდევ ერთი წერტილის გაზომვა'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, '1.742');
    await tester.tap(find.text('🔄 ნიველირი უნდა გადავიტანო'));
    await tester.pumpAndSettle();
    expect(find.text('🔄 ნიველირი გადაიტანეთ'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, '1.605');
    await tester.tap(find.text('გაგრძელება →'));
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).first, '1.150');
    await tester.tap(find.text('🏁 ეს ბოლო წერტილია'));
    await tester.pumpAndSettle();
    expect(find.text('🎉 გაზომვა დასრულებულია'), findsOneWidget);
    expect(find.text('100.236 მ'), findsOneWidget);

    await tester.tap(find.text('ბოლოს გაუქმება'));
    await tester.pumpAndSettle();
    expect(find.text('📏 შემდეგი წერტილი'), findsOneWidget);
  });
}
