import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:semaphoreci_flutter_demo/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Should find one instance of main app',
      (WidgetTester tester) async {
    // Arrange
    app.main();
    await tester.pumpAndSettle();
    final mainAppWidget = find.byKey(const ValueKey('Main App'));

    // Act

    // Assert
    expect(mainAppWidget, findsOneWidget);
  });
}
