import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:photoapi/main.dart';

import 'widget_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  late Box mockBox;
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    mockBox = MockBox();
  });

  testWidgets('Photo Api App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(PhotoApiApp(box: mockBox));
    expect(find.text('Photo API Application'), findsOneWidget);
  });
}
