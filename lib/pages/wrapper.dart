// import 'package:phonetheft/main.dart';
// import 'package:phonetheft/pages/home/camera.dart';
import 'package:phonetheft/pages/home/home.dart';
import 'package:phonetheft/pages/auth/authenticate.dart';
// import 'package:phonetheft/pages/auth/validate_user.dart';
import 'package:flutter/material.dart';
import 'package:phonetheft/shared/userSettings.dart';
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
      currentuser.email = user.email;
      if (currentuser.currentAudioLoop != '') {
        currentuser.currentAudioLoop.stop();
        setState(() {
          motionWatchOn = false;
          chargingWatchOn = false;
        });
      }
      // print({"uid": user.uid, "email": user.email});
    }
    if (user == null) {
      return Authenticate();
    } else {
      return PhoneTheft();
    }
  }
}
