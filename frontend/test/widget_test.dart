// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:labubu_flutter_app/main.dart';

void main() {
  testWidgets('App widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const LabubuApp());

    // Verify that the app loads
    await tester.pumpAndSettle();
    
    // The app should show some UI - we can check for the presence of basic widgets
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
