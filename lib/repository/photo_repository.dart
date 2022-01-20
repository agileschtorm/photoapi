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

class ApiDataException extends _PhotoRepositoryException implements Exception {
  ApiDataException({String? message = 'Photo API Data error'}) : super(message);
}

class ApiResponseException extends _PhotoRepositoryException implements Exception {
  ApiResponseException({String? message = 'PhotoAPI Response error'}) : super(message);
}

class ConnectionException extends _PhotoRepositoryException implements Exception {
  ConnectionException({String? message = 'Connection error'}) : super(message);
}

class PhotoRepository {
  final Dio _dio;
  static const String kPhotosApiUrl = 'https://jsonplaceholder.typicode.com/album/1/photos';
  static const String kPhotoRepositoryLoggerKey = 'PhotoRepository';

  PhotoRepository({Dio? dio}) : _dio = dio ?? Dio();
  final Logger _log = Logger(kPhotoRepositoryLoggerKey);

  /// Get the list of photos from the predefined API
  Future<List<Photo>> getPhotos() async {
    final Response response;
    final List<Photo> result = [];
    try {
      response = await _dio.get(kPhotosApiUrl);
    } catch (e) {
      final String _errorMessage = 'PhotoApi Connection error $e';
      _log.severe(_errorMessage);
      throw ConnectionException(message: _errorMessage);
    }
    if (response.statusCode == 200) {
      _log.fine('PhotoApi answered 200 OK Response = ${response.data}');
      try {
        for (var element in (response.data as List)) {
          result.add(Photo.fromJson(element));
        }
        _log.info('Read the list of ${result.length} photo entries');
        return result;
      } catch (e) {
        final String _errorMessage = 'PhotoApi Data error ${response.statusCode}';
        _log.severe(_errorMessage);
        throw ApiDataException(message: _errorMessage);
      }
    } else {
      final String _errorMessage = 'PhotoApi Response error ${response.statusCode}';
      _log.severe(_errorMessage);
      throw ApiResponseException(message: _errorMessage);
    }
  }
}
