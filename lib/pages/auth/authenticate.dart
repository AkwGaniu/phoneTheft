import 'package:phonetheft/pages/auth/register.dart';
import 'package:phonetheft/pages/auth/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  final Function logIn;
  Authenticate({this.logIn});
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showLogin = true;
  void toggleView() {
    setState(() => showLogin = !showLogin);
  }
  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return SignIn(toggleView: toggleView, logIn: widget.logIn,);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}