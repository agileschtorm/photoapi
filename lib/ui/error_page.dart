import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/bloc/photo_bloc/photo_bloc.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key, this.error}) : super(key: key);
  final String? error;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: GestureDetector(
        onTap: () => context.read<PhotoBloc>().add(const LoadPhotoEvent()),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Icon(Icons.error, color: Colors.redAccent, size: MediaQuery.of(context).size.width * 0.4),
                Text(
                  'Oops, something went wrong!\nError: $error',
                  maxLines: 5,
                ),
                const Text('Press here to reload'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
