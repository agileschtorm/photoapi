import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/bloc/photo_bloc/photo_bloc.dart';
import '/model/photo.dart';
import 'widget/photo_card.dart';

const kPhotoListPageKey = Key('__photo_list_page_key__');
const kGestureDetectorPhotoListPageKey = Key('__gesture_detector_photo_list_page_key__');

class PhotoListPage extends StatelessWidget {
  const PhotoListPage({Key? key, required this.photos, this.pageThreshold = kPageThreshold})
      : assert(pageThreshold > 0),
        super(key: key);
  final List<Photo> photos;
  final int pageThreshold;
  static const int kPageThreshold = 5;

  @override
  Widget build(BuildContext context) {
    if (photos.isEmpty) {
      return SizedBox.expand(
        child: GestureDetector(
          key: kGestureDetectorPhotoListPageKey,
          onTap: () => context.read<PhotoBloc>().add(const LoadPhotoEvent()),
          child: const Center(
            child: Text('No photos loaded! Tap to reload'),
          ),
        ),
      );
    }
    return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (context, index) {
        if ((index == photos.length - pageThreshold && photos.length > pageThreshold * 2) ||
            (index == photos.length && photos.length <= pageThreshold * 2)) {
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
