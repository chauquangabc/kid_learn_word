import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lingo_bamboo/presentation/navigation/app_router.dart';
import 'package:lingo_bamboo/presentation/view_model/voice_setting/voice_setting_cubit.dart';
import 'package:path_provider/path_provider.dart';

import 'data/local/voice_setting_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => VoiceSettingCubit(VoiceSettingStorage())),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> _ensureInitialized() async {
  final WidgetsBinding widgetsBinding =
      WidgetsFlutterBinding.ensureInitialized();
  final directory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(directory.path);

  await Future.wait([VoiceSettingStorage().init()]);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      ),
      routerConfig: appRouter,
    );
  }
}
