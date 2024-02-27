import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gimix/first_game/first_game_screen.dart';

void main() {
  testWidgets('Test if FirstGameScreen initializes correctly', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: FirstGameScreen(),
    ));

    // Verify that the score starts from 0.
    expect(find.text('Score: 0'), findsOneWidget);

    // Verify that the game starts not being over.
    expect(find.text('Game Over'), findsNothing);

    // You can add more tests based on your specific requirements.
  });

  // Add more tests as needed.
}