import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Landing Page'),
      ),
      body: Center(
        child: Text(
          'Landing Screen',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
