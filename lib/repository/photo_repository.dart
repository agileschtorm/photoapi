import 'package:dio/dio.dart';
import 'package:logging/logging.dart';

import '/model/photo.dart';

abstract class _PhotoRepositoryException {
  static const String _defaultMessage = 'PhotoRepositoryException';
  final String? message;

  _PhotoRepositoryException(this.message);

  @override
  String toString() {
    return message ?? _defaultMessage;
  }
}

class ApiException extends _PhotoRepositoryException implements Exception {
  ApiException({String? message = 'Photo API error'}) : super(message);
}

class ConnectionException extends _PhotoRepositoryException implements Exception {
  ConnectionException({String? message = 'Connection error'}) : super(message);
}

class PhotoRepository {
  final Dio _dio;
  static const String _photosApiUrl = 'https://jsonplaceholder.typicode.com/albums/1/photos';
  static const String kPhotoRepositoryLoggerKey = 'PhotoRepository';

  PhotoRepository({Dio? dio}) : _dio = dio ?? Dio();
  final Logger _log = Logger(kPhotoRepositoryLoggerKey);

  /// Get the list of photos from the predefined API
  Future<List<Photo>> getPhotos() async {
    final List<Photo> result = [];
    try {
      final response = await _dio.get(_photosApiUrl);
      if (response.statusCode == 200) {
        _log.fine('PhotoApi answered 200 OK Response = ${response.data.toString().substring(0, 80)}');
        for (var element in (response.data as List)) {
          result.add(Photo.fromJson(element));
        }
        _log.info('Read the list of ${result.length} photo entries');
        return result;
      } else {
        final String _errorMessage = 'PhotoApi Connection error ${response.statusCode}';
        _log.severe(_errorMessage);
        throw ConnectionException(message: _errorMessage);
      }
    } catch (e) {
      final String _errorMessage = 'GetPhotos API error $e';
      _log.severe(_errorMessage);
      throw ApiException(message: _errorMessage);
    }
  }
}
