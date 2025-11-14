// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pizza_genie/main.dart';

void main() {
  testWidgets('Pizza Genie compact app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PizzaGenieApp());

    // Verify that our app shows the Pizza Genie title
    expect(find.text('Pizza Genie'), findsWidgets);
    
    // Verify the compact interface elements are present
    expect(find.text('Pizza Size'), findsOneWidget);
    expect(find.text('Crust Style'), findsOneWidget);
    expect(find.text('Proving Time'), findsOneWidget);
    expect(find.text('Quantity'), findsOneWidget);
    
    // Verify pizza icons are present
    expect(find.byIcon(Icons.local_pizza), findsWidgets);
    
    // Verify key UI components
    expect(find.text('Calculate'), findsOneWidget);
  });
}
