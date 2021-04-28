import 'package:flutter/material.dart';
import 'landing-page.dart';
// import 'bottom-navigation-bar/navigation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext conte) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Welcome to Flutter",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LandingPage(),
    );
  }
}
