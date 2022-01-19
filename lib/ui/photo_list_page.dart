import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/photo_bloc/photo_bloc.dart';
import '/model/photo.dart';
import 'widget/photo_card.dart';

class PhotoListPage extends StatelessWidget {
  const PhotoListPage({Key? key, required this.photos}) : super(key: key);
  final List<Photo> photos;
  static const int kPageThreshold = 5;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (context, index) {
        if (index == photos.length - kPageThreshold) {
          context.read<PhotoBloc>().add(const LoadPhotoEvent());
        }
        return Column(
          children: [
            (index == 0) ? const SizedBox.shrink() : const Divider(),
            PhotoCard(photo: photos[index], storageKey: index),
          ],
        );
      },
    );
  }
}
