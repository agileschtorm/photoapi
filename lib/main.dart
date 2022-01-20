import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';

import 'bloc/connectivity_cubit.dart';
import 'bloc/photo_bloc/photo_bloc.dart';
import 'repository/likes_repository.dart';
import 'repository/photo_repository.dart';
import 'ui/home_page.dart';

Future<void> main() async {
  await initialize();
  final likesBox = await initializeHive();
  runApp(PhotoApiApp(box: likesBox));
}

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Init Logger
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    //ignore: avoid_print
    print('[${record.loggerName}] ${record.level.name}: ${record.message}');
    if (record.error != null) {
      //ignore: avoid_print
      print('ERROR: ${record.error}, ${record.stackTrace}');
    }
  });
}

Future<Box> initializeHive() async {
  await Hive.initFlutter();
  return await LikesRepository.openHiveBox();
}

class PhotoApiApp extends StatelessWidget {
  const PhotoApiApp({Key? key, required this.box}) : super(key: key);
  final Box box;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => PhotoRepository()),
          RepositoryProvider(create: (context) => LikesRepository(box: box)),
          RepositoryProvider(create: (context) => Connectivity()),
        ],
        child: MultiBlocProvider(
            providers: [
              BlocProvider<PhotoBloc>(
                create: (BuildContext context) => PhotoBloc(
                  photoRepository: context.read<PhotoRepository>(),
                )..add(const LoadPhotoEvent()),
              ),
              BlocProvider(
                  create: (BuildContext context) => ConnectivityCubit(
                        connectivity: context.read<Connectivity>(),
                      ))
            ],
            child: const MaterialApp(
              title: 'Photo API',
              home: HomePage(),
            )));
  }
}
