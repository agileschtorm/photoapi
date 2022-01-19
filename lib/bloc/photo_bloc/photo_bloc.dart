import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/model/photo.dart';
import '/repository/photo_repository.dart';

part 'photo_event.dart';
part 'photo_state.dart';

class PhotoBloc extends Bloc<PhotoEvent, PhotoState> {
  PhotoBloc({
    required PhotoRepository photoRepository,
  })  : _photoRepository = photoRepository,
        super(const LoadingPhotoState()) {
    on<LoadPhotoEvent>(_onLoad);
  }

  final PhotoRepository _photoRepository;
  List<Photo> _photosState = [];

  Future<void> _onLoad(
    LoadPhotoEvent event,
    Emitter<PhotoState> emit,
  ) async {
    try {
      _photosState = [..._photosState, ...await _photoRepository.getPhotos()];
      emit(LoadedPhotoState(photos: _photosState));
    } catch (e) {
      emit(ErrorPhotoState(error: e.toString()));
    }
  }
}
