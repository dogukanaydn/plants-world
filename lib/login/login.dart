import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_world/auth/auth.dart';
import 'package:plants_world/theme/constants.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum AuthStatus {
  notSignedIn,
  signedIn,
}

enum FormType { login, register }

class _LoginState extends State<Login> {
  Auth auth;

  AuthStatus authStatus = AuthStatus.notSignedIn;

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  }

  final formKey = GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void validateAndSubmit() async {
    print("validateAndSubmit metodu");
    if (validateAndSave()) {
      String userId = await auth.signInWithEmailAndPassword(_email, _password);

      print('Sign in: $userId');

      _signedIn();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppConstants.lightPurple,
          width: double.infinity,
          height: size.height,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "LOGIN",
                      style: CustomTextHeadline.headLine5,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/svg/Blooming-amico.svg",
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: TextFormField(
                      cursorColor: AppConstants.purple,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: AppConstants.purple,
                        ),
                        hintText: "Your Email",
                        border: InputBorder.none,
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Email can\'t be empty' : null,
                      onSaved: (value) => _email = value,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: TextFormField(
                      cursorColor: AppConstants.purple,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: AppConstants.purple,
                        ),
                        hintText: "Your Password",
                        border: InputBorder.none,
                      ),
                      validator: (value) =>
                          value.isEmpty ? 'Password can\'t be empty' : null,
                      onSaved: (value) => _password = value,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: size.width * 0.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(29),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 40),
                          primary: AppConstants.purple,
                        ),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: validateAndSubmit,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final Function press;
  const AlreadyHaveAnAccountCheck({
    Key key,
    this.login = true,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? ",
          style: TextStyle(color: Colors.black),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
