import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_world/theme/constants.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        color: AppConstants.lightPurple,
        height: size.height,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 150),
              child: SvgPicture.asset("assets/svg/Flowers-amico.svg",
                  width: 200, height: 200),
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
                    "Login",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.white,
                      minimumSize: Size(250, 50),
                      primary: AppConstants.grey),
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: AppConstants.purple),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signUp');
                  },
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
