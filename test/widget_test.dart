import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:media_recommender/main.dart';

void main() {
  testWidgets('Search for a song and verify results or error', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.enterText(find.byType(TextField), 'pokemon');
    await tester.pump();

    await tester.tap(find.widgetWithText(ElevatedButton, 'Submit'));
    await tester.pumpAndSettle();

    final displayedTextFinder = find.byWidgetPredicate((Widget widget) =>
    widget is Text &&
        (widget.data!.startsWith("1.") || widget.data!.startsWith("No tracks found.") || widget.data!.startsWith("An error occurred:")));
    expect(displayedTextFinder, findsOneWidget);
  });
}
