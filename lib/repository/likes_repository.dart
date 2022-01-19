import 'package:hive_flutter/hive_flutter.dart';

class LikesRepository {
  static const String kLikesBoxName = 'likes';
  static const String kLikesRepositoryLoggerKey = 'LikesRepository';

  LikesRepository();

  /// Hive box initializer; opens the hive box with the liked photo
  static Future<Box> openHiveBox() async => await Hive.openBox(LikesRepository.kLikesBoxName);

  /// Check if photo with this key is liked; fall backs to false if the key was not found
  bool isLiked({required int key}) {
    return Hive.box(kLikesBoxName).get(key, defaultValue: false);
  }

  /// Stores information about the liked photo in Hive
  void like({required int key}) {
    Hive.box(kLikesBoxName).put(key, true);
  }

  /// Stores information about the unliked photo in Hive
  void unlike({required int key}) {
    Hive.box(kLikesBoxName).put(key, false);
  }
}
