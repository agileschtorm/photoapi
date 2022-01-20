import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/bloc/connectivity_cubit.dart';
import '/bloc/photo_bloc/photo_bloc.dart';
import 'error_page.dart';
import 'photo_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String kTitle = 'Photo API Application';
  static const String kDisconnectedError = 'Oops, no internet connection!';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(kTitle),
          centerTitle: true,
        ),
        body: BlocBuilder<ConnectivityCubit, ConnectivityState>(
          builder: (context, state) {
            if (state is Connected) {
              return BlocBuilder<PhotoBloc, PhotoState>(
                builder: (context, state) {
                  if (state is ErrorPhotoState) {
                    return ErrorPage(key: kErrorPageKey, error: state.error);
                  }
                  if (state is LoadedPhotoState) {
                    return PhotoListPage(photos: state.photos);
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              );
            }
            if (state is Disconnected) {
              return const Center(child: Text(kDisconnectedError));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
