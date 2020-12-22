import 'package:phonetheft/pages/home.dart';
import 'package:phonetheft/pages/auth/authenticate.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:phonetheft/shared/userSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() =>  _WrapperState();
}

class _WrapperState extends  State<Wrapper>  {
  // bool logggedIn = false;
  SharedPreferences prefs;

  @override
  void initState(){
    super.initState();
    _load();
   }

  _load() async {
    // prefs = await SharedPreferences.getInstance();
    print(prefs.getBool('loggedIn'));
  }

  Future<bool> logIn (username, password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String userPassword = pref.getString('password') ?? '';
    String userUsername = pref.getString('username') ?? '';
    if (userUsername == username && userPassword == password) {
      setState(() {
        pref.setBool('loggedIn', true);
      });
      return true;
    } else {
      setState(() {
        pref.setBool('loggedIn', false);
      });
      return false;
    }
  }
  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<User>(context);
    // Future<bool> loggedIn () async {
    //   prefs = await SharedPreferences.getInstance();
    //   bool logggedIn = prefs.getBool('loggedIn') ?? false;
    //   return logggedIn;
    // }

    // CHECK IF USER IS LOGGED IN AND SHOW THE RIGHT SCREEN
    // Future<bool> loggIn () async {
    //   prefs = await SharedPreferences.getInstance();
    //   return  prefs.getBool('loggedIn') ?? false;
    // }
    bool loggIn = true;
    
    if (!loggIn) {
        return Authenticate(logIn: logIn);
      } else {
        return PhoneTheft();
      }
  }
}