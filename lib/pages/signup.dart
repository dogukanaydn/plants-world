import 'dart:html';
import 'package:flutter/material.dart';
import 'package:plants_world/theme/constants.dart';
import 'package:plants_world/pages/login.dart';

class SignUp extends StatelessWidget {
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    icon: Icon(Icons.close_sharp),
                    onPressed: () {
                      Navigator.pop(context, true);
                    }),
                Text(
                  "Sign Up",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(color: AppConstants.purple),
                    ))
              ],
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
                    prefixIcon: Icon(Icons.person),
                    hintText: "Name",
                    border: OutlineInputBorder()),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 120, right: 120),
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
                  "Sign Up",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ),
          ),
        ],
      )),
    ));
  }
}
