import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plants_world/auth/auth.dart';
import 'package:plants_world/auth/login_page.dart';
import 'auth/root_page.dart';

import 'landing-screen/landing-page.dart';
import 'login/login.dart';
import 'pages/camera.dart';
import 'pages/details.dart';
import 'pages/home.dart';
import 'pages/notifications.dart';
import 'pages/profile.dart';
import 'pages/search.dart';
import 'signUp/signUp.dart';
import 'tflite/tflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Welcome to Flutter",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // initialRoute: '/tflite',
      // routes: {
      //   '/': (context) => LandingPage(),
      //   '/login': (context) => Login(),
      //   '/signUp': (context) => SignUp(),
      //   '/home': (context) => Home(),
      //   '/search': (context) => Search(),
      //   '/tflite': (context) => TFLite(),
      //   '/notification': (context) => Notifications(),
      //   '/profile': (context) => Profile(),
      //   '/camera': (context) => Camera(),
      //   '/details': (context) => Details()
      // },
      home: RootPage(
        auth: Auth(),
      ),
    );
  }
}
