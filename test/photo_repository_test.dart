import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:photoapi/model/photo.dart';
import 'package:photoapi/repository/photo_repository.dart';

import 'photo_repository_test.mocks.dart';

@GenerateMocks([Dio])
const List<Map<String, dynamic>> fakeDioResponseData = [
  {
    'albumId': 1,
    'id': 1,
    'title': 'title1',
    'url': 'https://via.placeholder.com/600/92c952',
    'thumbnailUrl': 'https://via.placeholder.com/150/92c952'
  },
  {
    'albumId': 1,
    'id': 2,
    'title': 'title2',
    'url': 'https://via.placeholder.com/600/92c952',
    'thumbnailUrl': 'https://via.placeholder.com/150/92c952'
  },
];

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('PhotoRepository', () {
    late PhotoRepository photoRepository;
    late Dio mockDio;

    setUp(() {
      mockDio = MockDio();
      photoRepository = PhotoRepository(dio: mockDio);
    });

    test('getPhotos returns valid answer', () async {
      when(mockDio.get(PhotoRepository.kPhotosApiUrl)).thenAnswer((_) => Future.value(Response(
            data: fakeDioResponseData,
            statusCode: 200,
            requestOptions: RequestOptions(path: PhotoRepository.kPhotosApiUrl),
          )));
      final List<Photo> testPhotos = await photoRepository.getPhotos();
      expect(testPhotos.length, 2);
      expect(testPhotos.first, Photo.fromJson(fakeDioResponseData.first));
    });

    test('getPhotos Connection Exception', () async {
      when(mockDio.get(PhotoRepository.kPhotosApiUrl)).thenThrow(DioErrorType.response);
      try {
        await photoRepository.getPhotos();
      } catch (e) {
        expect(e, isInstanceOf<ConnectionException>());
      }
    });

    test('getPhotos Api Response Exception', () async {
      when(mockDio.get(PhotoRepository.kPhotosApiUrl)).thenAnswer((_) => Future.value(Response(
            data: 'Forward',
            statusCode: 302,
            requestOptions: RequestOptions(path: PhotoRepository.kPhotosApiUrl),
          )));
      try {
        await photoRepository.getPhotos();
      } catch (e) {
        expect(e, isInstanceOf<ApiResponseException>());
      }
    });

    test('getPhotos Data Response Exception', () async {
      when(mockDio.get(PhotoRepository.kPhotosApiUrl)).thenAnswer((_) => Future.value(Response(
            data: 'Broken Data',
            statusCode: 200,
            requestOptions: RequestOptions(path: PhotoRepository.kPhotosApiUrl),
          )));
      try {
        await photoRepository.getPhotos();
      } catch (e) {
        expect(e, isInstanceOf<ApiDataException>());
      }
    });
  });
}
