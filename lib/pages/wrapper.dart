import 'package:phonetheft/pages/home/home.dart';
import 'package:phonetheft/pages/auth/authenticate.dart';
import 'package:phonetheft/pages/auth/validate_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:phonetheft/services/models/user.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}
class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if(user != null) {
      current_user.email = user.email;
      if (current_user.currentAudioLoop != '') {
        current_user.currentAudioLoop.stop();
      }
      print({"uid": user.uid, "email": user.email});
    }
    if (user == null) {
      return Authenticate();
    } else {
      // return ValidateUser();
      return PhoneTheft();
    }
  }
}
