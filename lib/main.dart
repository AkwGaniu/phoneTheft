// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phonetheft/pages/wrapper.dart';
import 'package:phonetheft/pages/home/settings.dart';
// import 'package:android_alarm_manager/android_alarm_manager.dart';

import 'package:phonetheft/services/auth.dart';
import 'package:provider/provider.dart';
import './pages/splash.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await AndroidAlarmManager.initialize();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Phone Police',
    home: SplashScreen(),
    routes: {
      '/home': (context) => StreamProvider.value(
        value: AuthServices().user,
        child: Wrapper()
      ),
      '/settings': (context) => Settings(),
    },
  ));
}
