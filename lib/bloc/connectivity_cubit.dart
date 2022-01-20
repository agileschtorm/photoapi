import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ConnectivityState extends Equatable {
  const ConnectivityState();

  @override
  List<Object> get props => [];
}

class Connecting extends ConnectivityState {
  const Connecting();
}

class Connected extends ConnectivityState {
  const Connected();
}

class Disconnected extends ConnectivityState {
  const Disconnected();
}

class ConnectivityCubit extends Cubit<ConnectivityState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSubscription;
  ConnectivityCubit({required this.connectivity}) : super(const Connecting()) {
    connectivityStreamSubscription = connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult == ConnectivityResult.wifi ||
          connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.ethernet ||
          connectivityResult == ConnectivityResult.bluetooth) {
        emit(const Connected());
      } else if (connectivityResult == ConnectivityResult.none) {
        emit(const Disconnected());
      }
    });
  }

  @override
  Future<void> close() {
    connectivityStreamSubscription.cancel();
    return super.close();
  }
}
