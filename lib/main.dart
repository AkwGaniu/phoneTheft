import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phonetheft/pages/wrapper.dart';
import 'package:phonetheft/pages/settings.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
void main() async {
  await AndroidAlarmManager.initialize();
  await AndroidAlarmManager.periodic(Duration(seconds: 10), 0, callBack);

  runApp(MaterialApp(
    title: 'Anti Phone Theft',
    routes: {
      '/': (context) => Wrapper(),
      '/settings': (context) => Settings(),
    },
  ));
}


void callBack () {
  print('HI BACKGROUND SERVICES');
}