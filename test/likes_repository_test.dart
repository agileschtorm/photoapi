import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:photoapi/repository/likes_repository.dart';

import 'likes_repository_test.mocks.dart';

@GenerateMocks([Box])
void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('LikesRepository', () {
    late LikesRepository likesRepository;
    late Box mockHiveBox;

    setUp(() async {
      mockHiveBox = MockBox();
      likesRepository = LikesRepository(box: mockHiveBox);
    });

    test('check watch returns false for the item that is not in hive', () async {
      when(mockHiveBox.watch(key: 0)).thenAnswer((_) => Stream.value(BoxEvent(0, null, false)));
      expect(await likesRepository.watchKeyIsLiked(key: 0).first, false);
    });
  });
}
