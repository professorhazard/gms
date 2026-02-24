// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:gms/main.dart';
import 'package:gms/my_cases_screen.dart';
import 'package:gms/resolution_feedback.dart';

void main() {
  testWidgets('Respond to review opens feedback screen', (WidgetTester tester) async {
    // show MyCasesScreen inside a MaterialApp for navigation
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: const MyCasesScreen())));

    // ensure card with case GMS-8790 is present
    expect(find.text('GMS-8790'), findsOneWidget);

    // expand the card so button is visible
    await tester.tap(find.text('GMS-8790'));
    await tester.pumpAndSettle();

    // tap the Respond to Review button inside the opened card (second in list)
    await tester.tap(find.widgetWithText(ElevatedButton, 'Respond to Review').at(1));
    await tester.pumpAndSettle();

    // now the feedback screen should be shown
    expect(find.text('Resolution Feedback'), findsOneWidget);
    expect(find.textContaining('Case ID:'), findsOneWidget);
  });
}
