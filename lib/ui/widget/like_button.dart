import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/likes_cubit.dart';
import '/repository/likes_repository.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({Key? key, required this.storageKey}) : super(key: key);
  final int storageKey;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LikesCubit>(
      create: (BuildContext context) => LikesCubit(
        likesRepository: context.read<LikesRepository>(),
        key: storageKey,
      ),
      child: BlocBuilder<LikesCubit, bool>(
        builder: (context, state) {
          final cubit = context.read<LikesCubit>();
          if (state) {
            return GestureDetector(
              onTap: () => cubit.unlike(),
              child: const Icon(Icons.thumb_up, color: Colors.blueAccent),
            );
          } else {
            return GestureDetector(
              onTap: () => cubit.like(),
              child: const Icon(Icons.thumb_up_alt_outlined, color: Colors.blueGrey),
            );
          }
        },
      ),
    );
  }
}
