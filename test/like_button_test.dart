import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:photoapi/bloc/likes_cubit.dart';
import 'package:photoapi/ui/widget/like_button.dart';

import 'like_button_test.mocks.dart';

@GenerateMocks([LikesCubit])
void main() {
  const int key = 0;
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  Widget makeWidgetTestable(Widget child) {
    return MaterialApp(
      home: Material(
        child: child,
      ),
    );
  }

  group('LikesCubit', () {
    late LikesCubit mockLikesCubit;

    setUp(() async {
      mockLikesCubit = MockLikesCubit();
    });

    testWidgets('unliked state widget', (WidgetTester tester) async {
      when(mockLikesCubit.stream).thenAnswer((_) => Stream.value(true));
      when(mockLikesCubit.state).thenReturn(false);
      await tester.pumpWidget(makeWidgetTestable(LikeButtonTestable(
        storageKey: key,
        likesCubit: mockLikesCubit,
      )));
      final likeButton = find.byKey(kLikeGestureDetectorLikeButtonKey);
      expect(likeButton, findsOneWidget);
      expect(find.byIcon(Icons.thumb_up_alt_outlined), findsOneWidget);
      await tester.tap(likeButton);
      await tester.pumpAndSettle();
      expect(find.byKey(kUnlikeGestureDetectorLikeButtonKey), findsOneWidget);
    });

    testWidgets('liked state widget', (WidgetTester tester) async {
      when(mockLikesCubit.stream).thenAnswer((_) => Stream.value(false));
      when(mockLikesCubit.state).thenReturn(true);
      await tester.pumpWidget(makeWidgetTestable(LikeButtonTestable(
        storageKey: key,
        likesCubit: mockLikesCubit,
      )));
      final unlikeButton = find.byKey(kUnlikeGestureDetectorLikeButtonKey);
      expect(unlikeButton, findsOneWidget);
      expect(find.byIcon(Icons.thumb_up), findsOneWidget);
      await tester.tap(unlikeButton);
      await tester.pumpAndSettle();
      expect(find.byKey(kLikeGestureDetectorLikeButtonKey), findsOneWidget);
    });
  });
}
