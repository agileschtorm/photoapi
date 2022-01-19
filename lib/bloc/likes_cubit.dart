import 'package:flutter_bloc/flutter_bloc.dart';

import '/repository/likes_repository.dart';

class LikesCubit extends Cubit<bool> {
  LikesCubit({
    required LikesRepository likesRepository,
    required this.key,
  })  : _likesRepository = likesRepository,
        super(likesRepository.isLiked(key: key)); //Init state with the hive value
  final int key;
  final LikesRepository _likesRepository;

  ///Like photo by ID and persist changes
  void like() {
    _likesRepository.like(key: key);
    emit(true);
  }

  ///Dislike photo by ID and persist changes
  void unlike() {
    _likesRepository.unlike(key: key);
    emit(false);
  }
}
