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
  testWidgets('Pizza Genie app loads correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const PizzaGenieApp());

    // Verify that our app shows the Pizza Genie title
    expect(find.text('Pizza Genie'), findsWidgets);
    expect(find.text('Welcome to Pizza Genie!'), findsOneWidget);

    // Verify pizza icons are present (multiple icons expected)
    expect(find.byIcon(Icons.local_pizza), findsWidgets);
    
    // Verify key form elements are present
    expect(find.text('Pizza Diameter (inches)'), findsOneWidget);
    expect(find.text('Crust Thickness'), findsOneWidget);
  });
}
