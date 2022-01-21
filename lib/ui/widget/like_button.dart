import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/bloc/likes_cubit.dart';
import '/repository/likes_repository.dart';

const kLikeButtonTestableKey = Key('__like_button_testable_key__');
const kLikeGestureDetectorLikeButtonKey = Key('__like_gesture_detector_like_button_key__');
const kUnlikeGestureDetectorLikeButtonKey = Key('__unlike_gesture_detector_like_button_key__');

class LikeButton extends StatelessWidget {
  const LikeButton({Key? key, required this.storageKey}) : super(key: key);
  final int storageKey;

  @override
  Widget build(BuildContext context) {
    final likesCubit = LikesCubit(
      likesRepository: context.read<LikesRepository>(),
      key: storageKey,
    );
    return LikeButtonTestable(key: kLikeButtonTestableKey, storageKey: storageKey, likesCubit: likesCubit);
  }
}

class LikeButtonTestable extends StatelessWidget {
  const LikeButtonTestable({Key? key, required this.storageKey, required this.likesCubit}) : super(key: key);
  final int storageKey;
  final LikesCubit likesCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: likesCubit,
      child: BlocBuilder<LikesCubit, bool>(
        builder: (context, state) {
          final cubit = context.read<LikesCubit>();
          if (state) {
            return GestureDetector(
              key: kUnlikeGestureDetectorLikeButtonKey,
              onTap: () => cubit.unlike(),
              child: const Icon(Icons.thumb_up, color: Colors.blueAccent),
            );
          } else {
            return GestureDetector(
              key: kLikeGestureDetectorLikeButtonKey,
              onTap: () => cubit.like(),
              child: const Icon(Icons.thumb_up_alt_outlined, color: Colors.blueGrey),
            );
          }
        },
      ),
    );
  }
}
