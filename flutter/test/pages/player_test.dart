import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:semaphoreci_flutter_demo/pages/player.dart';

void main() {
  testWidgets('Player app should be deployed', (tester) async {
    // Define the test key.
    const testKey = ValueKey('Player Key');
    const playerWidget = Player();

    // Build a MaterialApp with the testKey.
    await tester.pumpWidget(
      const MaterialApp(
        home: playerWidget,
      ),
    );

    // Find the MaterialApp widget using the testKey.
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('Should go to Home when Logout button pressed', (tester) async {
    // Define the test key.
    const homeKey = ValueKey('Home App');
    const playerWidget = Player();

    // Build a MaterialApp with the testKey.
    await tester.pumpWidget(
      const MaterialApp(
        home: playerWidget,
      ),
    );

    // Push logout button
    await tester.tap(find.byKey(const ValueKey('button.logout')));
    await tester.pumpAndSettle();

    // Find the Home App loaded
    expect(find.byKey(homeKey), findsOneWidget);
  });
}
