import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.purple,
        title: Text("Flutter Login"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: buildInputs() + buildSubmitButtons(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildInputs() {
    return [
      TextFormField(
        decoration: InputDecoration(labelText: 'Email'),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
        onSaved: (value) => _email = value,
      ),
      TextFormField(
        obscureText: true,
        decoration: InputDecoration(labelText: 'Password'),
        validator: (value) => value.isEmpty ? 'Password can\'t be empty' : null,
        onSaved: (value) => _password = value,
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        ElevatedButton(
          child: Text("Login"),
          onPressed: validateAndSubmit,
        ),
        ElevatedButton(
          child: Text('Create an account'),
          onPressed: moveToRegister,
        ),
      ];
    } else {
      return [
        ElevatedButton(
          child: Text("Create an account"),
          onPressed: validateAndSubmit,
        ),
        ElevatedButton(
          child: Text('Have a account? Login'),
          onPressed: moveToLogin,
        ),
      ];
    }
  }
}
