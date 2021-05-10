import 'package:flutter/material.dart';
import 'package:phonetheft/pages/auth/register.dart';
import 'package:phonetheft/pages/auth/sign_in.dart';
import 'package:phonetheft/pages/auth/validate_user.dart';
import 'package:phonetheft/pages/home/home.dart';
import 'package:phonetheft/services/models/user.dart';
import 'package:phonetheft/shared/userSettings.dart';

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
      if (showLogin) {
        return SignIn(toggleView: toggleView);
      } else {
        return Register(toggleView: toggleView);
      }
    } else if (!motionWatchOn || !chargingWatchOn) {
      return ValidateUser();
    } else {
      return PhoneTheft();
    }
  }
}