

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:semaphoreci_flutter_demo/main.dart';
import 'package:semaphoreci_flutter_demo/pages/home.dart';
import 'package:spotify_sdk/spotify_sdk.dart';

void main() {
  testWidgets('Home app should be deployed', (tester) async {
    // Define the test key.
    const testKey = ValueKey('Home App');
    const homeWidget = Home();

    // Build a MaterialApp with the testKey.
    await tester.pumpWidget(
      const MaterialApp(
        home: homeWidget,
      ),
    );

    // Find the MaterialApp widget using the testKey.
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('Home app press login button', (tester) async {
    // Define the test key.
    await dotenv.load();

    const testKey = ValueKey('button.login');
    const homeWidget = Home();

    // Build a MaterialApp with the testKey.
    await tester.pumpWidget(
      const MaterialApp(
        home: homeWidget,
      ),
    );

    // Tap Login button
    await tester.tap(find.byKey(testKey));
    await tester.pumpAndSettle();

    // Find the MaterialApp widget using the testKey.
    // expect(find.byKey(testKey), findsOneWidget);
  });
}