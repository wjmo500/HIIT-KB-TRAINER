import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout_timer/main.dart';

void main() {
  testWidgets('App starts and shows HIIT KB TRAINER', (WidgetTester tester) async {
    await tester.pumpWidget(const HIITKBTrainerApp());
    expect(find.text('HIIT'), findsOneWidget);
  });
}
