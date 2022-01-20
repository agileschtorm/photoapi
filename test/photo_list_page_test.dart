import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photoapi/ui/photo_list_page.dart';

void main() {
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

  group('PhotoListPage', () {
    testWidgets('Expected widgets are shown on photo list empty', (WidgetTester tester) async {
      await tester.pumpWidget(makeWidgetTestable(const PhotoListPage(photos: [])));
      expect(find.byKey(kGestureDetectorPhotoListPageKey), findsOneWidget);
      expect(find.text('No photos loaded! Tap to reload'), findsOneWidget);
    });
  });
}
