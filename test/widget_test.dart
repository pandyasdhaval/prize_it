import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:prize_it/main.dart';

void main() {
  testWidgets('FAB adds prize cards', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('PrizeIt'), findsOneWidget);
    expect(find.text('Clear All'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('Cost: '), findsOneWidget);
    expect(find.text('Units: '), findsOneWidget);
    expect(find.text('NA'), findsOneWidget);
  });

  testWidgets('Clear All', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('PrizeIt'), findsOneWidget);
    expect(find.text('Clear All'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.tap(find.byIcon(Icons.add));
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    expect(find.text('Cost: '), findsNWidgets(3));
    expect(find.text('Units: '), findsNWidgets(3));
    expect(find.text('NA'), findsNWidgets(3));

    await tester.tap(find.text('Clear All'));
    await tester.pump();

    expect(find.text('Cost: '), findsNothing);
    expect(find.text('Units: '), findsNothing);
    expect(find.text('NA'), findsNothing);
  });

  testWidgets('Valid Cost, Empty Units should have NA result', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    await tester.enterText(find.widgetWithText(TextField, 'Cost: '), '1');
    await tester.pump();

    expect(find.text('Cost: '), findsNothing);
    expect(find.text('Units: '), findsOneWidget);
    expect(find.text('NA'), findsOneWidget);
  });

  testWidgets('Empty Cost, Valid Units should have NA result', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    await tester.enterText(find.widgetWithText(TextField, 'Units: '), '1');
    await tester.pump();

    expect(find.text('Cost: '), findsOneWidget);
    expect(find.text('Units: '), findsNothing);
    expect(find.text('NA'), findsOneWidget);
  });

  testWidgets('0 Units should have NA result', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    await tester.enterText(find.widgetWithText(TextField, 'Units: '), '0');
    await tester.pump();

    expect(find.text('Cost: '), findsOneWidget);
    expect(find.text('Units: '), findsNothing);
    expect(find.text('NA'), findsOneWidget);
  });

  testWidgets('Valid calculation', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    await tester.enterText(find.widgetWithText(TextField, 'Cost: '), '1');
    await tester.enterText(find.widgetWithText(TextField, 'Units: '), '2');
    await tester.pump();

    expect(find.text('Cost: '), findsNothing);
    expect(find.text('Units: '), findsNothing);
    expect(find.text('0.5'), findsOneWidget);
  });
}
