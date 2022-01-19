import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '/repository/likes_repository.dart';

class LikesCubit extends Cubit<bool> {
  final int key;
  final LikesRepository _likesRepository;
  late StreamSubscription _likesStreamSubscription;

  LikesCubit({
    required LikesRepository likesRepository,
    required this.key,
  })  : _likesRepository = likesRepository,
        super(
          //hive.watch does not return the initial value, so we need to get it on cubit's init
          //alternative solution is to use rxdart's startWith
          likesRepository.isLiked(key: key),
        ) {
    _likesStreamSubscription = _likesRepository.watchKeyIsLiked(key: key).listen((bool value) => emit(value));
  } //Init state with the hive value

  ///Like photo by ID and persist changes
  void like() {
    _likesRepository.like(key: key);
  }

  ///Dislike photo by ID and persist changes
  void unlike() {
    _likesRepository.unlike(key: key);
  }

  @override
  Future<void> close() {
    _likesStreamSubscription.cancel();
    return super.close();
  }
}
