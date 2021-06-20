import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:plants_world/theme/constants.dart';
import 'auth.dart';

class LoginPageDemo extends StatefulWidget {
  LoginPageDemo({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;

  @override
  _LoginPageDemoState createState() => _LoginPageDemoState();
}

enum FormType { login, register }

class _LoginPageDemoState extends State<LoginPageDemo> {
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
    if (validateAndSave()) {
      try {
        if (_formType == FormType.login) {
          String userId =
              await widget.auth.signInWithEmailAndPassword(_email, _password);

          print('Sign in: $userId');
        } else {
          String userId = await widget.auth
              .createUserWithEmailAndPassword(_email, _password);

          print('Registered user: $userId');
        }

        widget.onSignedIn();
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();
    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.login;
    });
  }

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.purple,
        title: Text("Login & SignUp"),
        centerTitle: true,
      ),
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
                children: buildInputs(_isObscure) + buildSubmitButtons(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs(bool isObscure) {
    Size size = MediaQuery.of(context).size;

    return [
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
              Icons.email,
              color: AppConstants.purple,
            ),
            hintText: "Your Email",
            border: InputBorder.none,
          ),
          validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
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
          obscureText: isObscure,
          cursorColor: AppConstants.purple,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(_isObscure ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure;
                });
              },
            ),
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
    ];
  }

  List<Widget> buildSubmitButtons() {
    Size size = MediaQuery.of(context).size;

    if (_formType == FormType.login) {
      return [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: size.width * 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                primary: AppConstants.purple,
              ),
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: validateAndSubmit,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: size.width * 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                primary: Colors.white,
              ),
              child: Text(
                "Create an account",
                style: TextStyle(color: AppConstants.purple),
              ),
              onPressed: moveToRegister,
            ),
          ),
        ),
      ];
    } else {
      return [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: size.width * 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                primary: AppConstants.purple,
              ),
              child: Text(
                "Create an account",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: validateAndSubmit,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          width: size.width * 0.8,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(29),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                primary: Colors.white,
              ),
              child: Text(
                "Have a account? Login",
                style: TextStyle(color: AppConstants.purple),
              ),
              onPressed: moveToLogin,
            ),
          ),
        ),
      ];
    }
  }
}
