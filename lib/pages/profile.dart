import 'package:flutter/material.dart';
import 'package:plants_world/theme/constants.dart';
import 'package:plants_world/auth/auth.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({this.auth, this.onSignedOut});
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
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text('Profile', style: CustomTextHeadline.headLine5),
        actions: [],
      ),
      body: ListView(
        children: [
          profileImageSection(_signOut),
          profileNameSection,
          // favoritesSection,
          favoritesSection("My Favorites"),
          favoritesSection("User Informations"),
          favoritesSection("Settings"),
        ],
      ),
    );
  }

  Widget profileImageSection(_signOut) => Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          Container(
            height: 245,
            color: AppConstants.purple,
          ),
          Positioned(
            bottom: -50,
            child: CircleAvatar(
              radius: 100,
              backgroundColor: Colors.cyan,
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1619451831105-599f9b2b94f3?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=700&q=80"),
            ),
          ),
          Positioned(
            right: 10,
            top: 0,
            child: ElevatedButton(onPressed: _signOut, child: Text("Logout")),
          ),
        ],
      );

  Widget profileNameSection = Container(
    margin: EdgeInsets.only(top: 60),
    child: Text(
      "Elif Yalçın",
      style: CustomTextHeadline.headLine5,
      textAlign: TextAlign.center,
    ),
  );

  Widget favoritesSection(String name) => Container(
        margin: EdgeInsets.all(15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            primary: AppConstants.purple,
            textStyle: CustomTextHeadline.headLine5,
            alignment: Alignment.centerLeft,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(),
            ),
          ),
          onPressed: () {},
        ),
      );
}
