import 'package:flutter/material.dart';
import 'package:trip_planner/firebase_options.dart';
import 'package:trip_planner/screens/auth_screen/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trip_planner/screens/bottomNav.dart';
import 'package:trip_planner/screens/postDetails.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
 late Size mq;
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Trip Planner',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SignUp(),
    );
  }
}

