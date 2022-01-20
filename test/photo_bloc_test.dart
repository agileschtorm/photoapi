import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:photoapi/bloc/photo_bloc/photo_bloc.dart';
import 'package:photoapi/model/photo.dart';
import 'package:photoapi/repository/photo_repository.dart';

import 'photo_bloc_test.mocks.dart';

@GenerateMocks([PhotoRepository])
void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('PhotoBloc', () {
    late PhotoRepository mockPhotoRepository;
    late PhotoBloc photoBloc;
    const Photo photo = Photo(id: 1, albumId: 1, title: 'a', thumbnailUrl: 'url', url: 'url');

    setUp(() async {
      mockPhotoRepository = MockPhotoRepository();
    });

    test('initial state', () {
      photoBloc = PhotoBloc(photoRepository: mockPhotoRepository);
      expect(photoBloc.state, const LoadingPhotoState());
    });

    blocTest(
      'loadPhoto success',
      setUp: () {
        when(mockPhotoRepository.getPhotos()).thenAnswer((_) => Future.value([photo]));
      },
      build: () => PhotoBloc(photoRepository: mockPhotoRepository),
      act: (PhotoBloc bloc) => bloc.add(const LoadPhotoEvent()),
      expect: () => [
        const LoadedPhotoState(photos: [photo])
      ],
    );

    blocTest(
      'loadPhoto fails',
      setUp: () {
        when(mockPhotoRepository.getPhotos()).thenThrow(Exception);
      },
      build: () => PhotoBloc(photoRepository: mockPhotoRepository),
      act: (PhotoBloc bloc) => bloc.add(const LoadPhotoEvent()),
      expect: () => [isA<ErrorPhotoState>()],
    );
  });
}
