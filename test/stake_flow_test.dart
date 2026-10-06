import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'measure_flow_test.dart' show pumpApp;

void main() {
  testWidgets('stakeout: design height, rod reading and remove/fill verdict', (tester) async {
    await pumpApp(tester);
    await tester.enterText(find.byType(TextField).first, 'იატაკი');
    await tester.tap(find.textContaining('ახალი დაზუსტება'));
    await tester.pumpAndSettle();
    expect(find.textContaining('🎯 დაზუსტება'), findsOneWidget);

    var f = find.byType(TextFormField);
    await tester.enterText(f.at(0), '100'); // start height
    await tester.enterText(f.at(1), '100'); // design at start
    await tester.enterText(f.at(2), '0.5'); // slope %
    await tester.enterText(f.at(4), '1.500'); // rod reading
    await tester.pump();
    await tester.tap(find.text('გაგრძელება →'));
    await tester.pumpAndSettle();

    f = find.byType(TextFormField);
    await tester.enterText(f.at(0), '10'); // distance
    await tester.enterText(f.at(1), '1.480'); // rod reading
    await tester.pump();
    expect(find.text('საპროექტო სიმაღლე: 99.950 მ\nლარტყაზე უნდა ჩანდეს: 1.550'), findsOneWidget);
    expect(find.text('ფაქტიური სიმაღლე: 100.020 მ'), findsOneWidget);
    expect(find.text('⬇ ამოიღეთ 70 მმ'), findsOneWidget);

    // A reading that lands exactly on design: 101.5 - 99.95 = 1.550.
    await tester.enterText(f.at(1), '1.550');
    await tester.pump();
    expect(find.textContaining('✔ ზუსტია'), findsOneWidget);

    // Too low: reading 1.600 -> 99.900, 50 mm below design -> fill.
    await tester.enterText(f.at(1), '1.600');
    await tester.pump();
    expect(find.text('⬆ შეავსეთ 50 მმ'), findsOneWidget);

    await tester.enterText(f.at(1), '1.480');
    await tester.tap(find.text('➕ კიდევ ერთი წერტილის გაზომვა'));
    await tester.pumpAndSettle();
    expect(find.text('საპროექტო 99.950'), findsOneWidget);
    expect(find.text('⬇ ამოიღეთ 70 მმ'), findsOneWidget);
    expect(find.textContaining('(10 მ)'), findsOneWidget);
  });
}
