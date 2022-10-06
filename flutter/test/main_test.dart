import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:semaphoreci_flutter_demo/main.dart';

void main() {
  testWidgets('Main app should be deployed', (tester) async {
    // Define the test key.
    const testKey = ValueKey('Main App');

    // Build a MaterialApp with the testKey.
    await tester.pumpWidget(MyApp());

    // Find the MaterialApp widget using the testKey.
    expect(find.byKey(testKey), findsOneWidget);
  });
}
