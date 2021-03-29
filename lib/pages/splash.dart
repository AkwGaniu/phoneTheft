import 'dart:async';

import 'package:flutter/material.dart';
// import 'package:flutkart/utils/flutkart.dart';
import '../utils/my_navigator.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5), () => MyNavigator.goToHome(context));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      body:Center(
        child: Image(
          image: AssetImage('assets/images/logo.png'),
          height: 250.0,
        ),
      ),
    );
  }
}
