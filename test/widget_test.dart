// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:kuis/pages/dashboard.dart';

void main() {
  testWidgets('opens the selected culinary detail page', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: DashboardPage()));

    expect(find.text('Jelajahi cita rasa Nusantara'), findsOneWidget);
    expect(find.text('Rendang'), findsOneWidget);

    await tester.tap(find.text('Rendang'));
    await tester.pumpAndSettle();

    expect(find.text('Bahan utama'), findsOneWidget);
    expect(find.text('Daging sapi, santan, rempah'), findsOneWidget);
  });
}
