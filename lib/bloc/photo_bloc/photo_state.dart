part of 'photo_bloc.dart';

abstract class PhotoState extends Equatable {
  const PhotoState();

  @override
  List<Object> get props => [];
}

class LoadingPhotoState extends PhotoState {
  const LoadingPhotoState();
}

class LoadedPhotoState extends PhotoState {
  final List<Photo> photos;
  const LoadedPhotoState({required this.photos});

  @override
  List<Object> get props => [photos];
}

class ErrorPhotoState extends PhotoState {
  final String error;
  const ErrorPhotoState({this.error = 'Photo Error!'});

  @override
  List<Object> get props => [error];
}
