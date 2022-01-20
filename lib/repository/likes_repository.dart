import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LikesRepository {
  static const String kLikesBoxName = 'likes';
  static const String kLikesRepositoryLoggerKey = 'LikesRepository';
  final Box box;

  LikesRepository({required this.box});

  /// Hive box initializer; opens the hive box with the liked photo
  @visibleForTesting
  static Future<Box> openHiveBox() async => await Hive.openBox(LikesRepository.kLikesBoxName);

  /// Stream of liked values per key
  Stream<bool> watchKeyIsLiked({required int key}) {
    return box.watch(key: key).map((likeBoxEvent) => (likeBoxEvent.value == null) ? false : likeBoxEvent.value);
  }

  /// Check if photo with this key is liked; fall backs to false if the key was not found
  bool isLiked({required int key}) {
    return box.get(key, defaultValue: false);
  }

  /// Stores information about the liked photo in Hive
  void like({required int key}) {
    box.put(key, true);
  }

  /// Stores information about the unliked photo in Hive
  void unlike({required int key}) {
    box.put(key, false);
  }
}
