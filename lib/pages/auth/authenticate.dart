import 'package:phonetheft/pages/auth/register.dart';
// import 'package:phonetheft/pages/auth/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:phonetheft/pages/auth/validate_user.dart';
import 'package:phonetheft/services/models/user.dart';

class Authenticate extends StatefulWidget {
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
    if (currentuser.email == '') {
      // return SignIn(toggleView: toggleView);
      return Register(toggleView: toggleView);
    } else {
      return ValidateUser();
    }
  }
}