import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:photoapi/bloc/likes_cubit.dart';
import 'package:photoapi/repository/likes_repository.dart';

import 'likes_cubit_test.mocks.dart';

@GenerateMocks([LikesRepository])
void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('LikesCubit', () {
    late LikesRepository mockLikesRepository;
    late LikesCubit likesCubit;
    const int key = 0;

    setUp(() async {
      mockLikesRepository = MockLikesRepository();
    });

    test('initial state', () {
      when(mockLikesRepository.isLiked(key: key)).thenReturn(true);
      when(mockLikesRepository.watchKeyIsLiked(key: key)).thenAnswer((_) => Stream.value(false));
      likesCubit = LikesCubit(likesRepository: mockLikesRepository, key: key);
      expect(likesCubit.state, true);
    });

    blocTest(
      'like',
      setUp: () {
        when(mockLikesRepository.isLiked(key: key)).thenReturn(false);
        when(mockLikesRepository.watchKeyIsLiked(key: key)).thenAnswer((_) => Stream.value(true));
      },
      build: () => LikesCubit(likesRepository: mockLikesRepository, key: key),
      act: (LikesCubit cubit) => cubit.like(),
      expect: () => [true],
    );

    blocTest(
      'unlike',
      setUp: () {
        when(mockLikesRepository.isLiked(key: key)).thenReturn(true);
        when(mockLikesRepository.watchKeyIsLiked(key: key)).thenAnswer((_) => Stream.value(false));
      },
      build: () => LikesCubit(likesRepository: mockLikesRepository, key: key),
      act: (LikesCubit cubit) => cubit.unlike(),
      expect: () => [false],
    );
  });
}
