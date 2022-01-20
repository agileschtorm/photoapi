import 'package:bloc_test/bloc_test.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:photoapi/bloc/connectivity_cubit.dart';

import 'connectivity_cubit_test.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
  });

  group('ConnectivityCubit', () {
    late Connectivity mockConnectivity;
    late ConnectivityCubit connectivityCubit;

    setUp(() async {
      mockConnectivity = MockConnectivity();
      when(mockConnectivity.onConnectivityChanged).thenAnswer((_) => Stream.value(ConnectivityResult.bluetooth));
    });

    test('initial state', () {
      connectivityCubit = ConnectivityCubit(connectivity: mockConnectivity);
      expect(connectivityCubit.state, isA<Connecting>());
    });

    blocTest(
      'Connected state',
      setUp: () =>
          when(mockConnectivity.onConnectivityChanged).thenAnswer((_) => Stream.value(ConnectivityResult.wifi)),
      build: () => ConnectivityCubit(connectivity: mockConnectivity),
      expect: () => [isA<Connected>()],
    );

    blocTest(
      'Disconnected state',
      setUp: () =>
          when(mockConnectivity.onConnectivityChanged).thenAnswer((_) => Stream.value(ConnectivityResult.none)),
      build: () => ConnectivityCubit(connectivity: mockConnectivity),
      expect: () => [isA<Disconnected>()],
    );
  });
}
