import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plants_world/theme/constants.dart';

class Camera extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
      color: AppConstants.lightPurple,
      height: size.height,
      width: double.infinity,
      alignment: Alignment.center,
      child: Container(
          width: 350,
          height: 420,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                    child: Center(
                        child: Text(
                      "RESİM",
                      style: TextStyle(color: Colors.white),
                    )),
                    width: 300,
                    height: 275,
                    decoration: BoxDecoration(
                        color: AppConstants.purple,
                        borderRadius: BorderRadius.all(Radius.circular(30.0)))),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: AppConstants.purple,
                        minimumSize: Size(300, 60),
                        primary: AppConstants.grey),
                    child: Text(
                      "Learn More",
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
