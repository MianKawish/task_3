import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task_3/bloc/api/api_bloc.dart';
import 'package:task_3/bloc/firebase/firebase_bloc.dart';
import 'package:task_3/bloc/hive/hive_bloc.dart';
import 'package:task_3/bloc/home/home_bloc.dart';
import 'package:task_3/services/api/api_services.dart';
import 'package:task_3/services/firebase_services/firebase_services.dart';
import 'package:task_3/services/hive/hive_services.dart';
import 'package:task_3/view/home/home_view.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  await Hive.openBox("userText");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeBloc(),
          ),
          BlocProvider(
            create: (context) => FirebaseBloc(FirebaseServices()),
          ),
          BlocProvider(
            create: (context) => ApiBloc(ApiServices()),
          ),
          BlocProvider(
            create: (context) => HiveBloc(HiveServices()),
          ),
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeView(),
        ));
  }
}
