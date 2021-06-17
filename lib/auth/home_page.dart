import 'package:flutter/material.dart';
import 'package:plants_world/auth/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;

  void _signOut() async {
    try {
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Page"),
        actions: [
          ElevatedButton(onPressed: _signOut, child: Text("Logout")),
        ],
      ),
      body: Container(
        child: Center(
          child: Text("Welcome buddy"),
        ),
      ),
    );
  }
}
