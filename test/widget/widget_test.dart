import 'package:flutter_test/flutter_test.dart';
import 'package:media_recommender/my_app.dart';

void main() {
  testWidgets('MyApp loads MyHomePage with correct title',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify if 'Media Recommender' is in the app bar title.
    expect(find.text('Media Recommender'), findsOneWidget);
  });
}
