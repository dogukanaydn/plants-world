import 'dart:html';
import 'package:flutter/material.dart';
import 'package:plants_world/theme/constants.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Center(
      child: Container(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Text(
              "Log In",
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 120, right: 120),
            child: Container(
              height: 50,
              child: TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: AppConstants.searchGrey,
                    prefixIcon: Icon(Icons.mail),
                    hintText: "Email",
                    border: OutlineInputBorder()),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 120, right: 120),
            child: Container(
              height: 50,
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  suffix: TextButton(
                      child: Text(
                    "show",
                    style: TextStyle(color: AppConstants.purple),
                  )),
                  filled: true,
                  fillColor: AppConstants.searchGrey,
                  prefixIcon: Icon(Icons.lock),
                  hintText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: AppConstants.purple,
                    minimumSize: Size(250, 50),
                    primary: AppConstants.grey),
                child: Text(
                  "Log In",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ),
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                "Forgot your password?",
                style: TextStyle(color: AppConstants.purple),
              ))
        ],
      )),
    ));
  }
}
