import 'package:demo_project/providers/states/home_screen_state.dart';
import 'package:demo_project/views/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import './routes.dart';
import './utility.dart' as utility;
import './views/start_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.green,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  runApp(
    MultiProvider(
      providers: [
        Provider<FirebaseAuth>.value(value: auth),
        Provider<FirebaseFirestore>.value(value: firestore),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("builded");
    return MaterialApp(
      theme: utility.appTheme,
      home: context.read<FirebaseAuth>().currentUser == null
          ? StartScreen()
          : ChangeNotifierProvider<HomeScreenState>(
              create: (context) => HomeScreenState(
                context.read<FirebaseFirestore>(),
                context.read<FirebaseAuth>(),
                context,
              ),
              child: HomeScreen(),
            ),
      routes: routes,
    );
  }
}
