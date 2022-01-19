import 'package:flutter/material.dart';
import 'like_button.dart';
import '/model/photo.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({Key? key, required this.photo, required this.storageKey}) : super(key: key);
  final Photo photo;
  final int storageKey;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                photo.title,
                textAlign: TextAlign.center,
              ),
            ),
            GestureDetector(
              onTap: () => showDialog(
                  context: context,
                  builder: (context) => GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Image.network(photo.url),
                      )),
              child: SizedBox.square(
                dimension: 150.0,
                child: Image.network(
                  photo.thumbnailUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LikeButton(storageKey: storageKey),
            ),
          ],
        ),
      ),
    );
  }
}
