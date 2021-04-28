import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Text(
          'Home Screen',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
