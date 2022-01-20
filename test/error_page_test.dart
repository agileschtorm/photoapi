import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photoapi/ui/error_page.dart';

void main() {
  const tErrorText = 'TestError';

  Widget makeWidgetTestable(Widget child) {
    return MaterialApp(
      home: Material(
        child: child,
      ),
    );
  }

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('ErrorPage', () {
    testWidgets('Expected widgets are shown', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(const ErrorPage()));
      expect(find.byKey(kGestureDetectorErrorPageKey), findsOneWidget);
      expect(find.byIcon(Icons.error), findsOneWidget);
      expect(find.text('Oops, something went wrong!\nError: ${null}'), findsOneWidget);
      expect(find.text('Press here to reload'), findsOneWidget);
    });
    testWidgets('Error text populated', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(const ErrorPage(error: tErrorText)));
      expect(find.text('Oops, something went wrong!\nError: $tErrorText'), findsOneWidget);
    });
    testWidgets('Error text populated', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(const ErrorPage(error: tErrorText)));
      expect(find.text('Oops, something went wrong!\nError: $tErrorText'), findsOneWidget);
    });
  });
}
