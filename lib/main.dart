import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phonetheft/pages/home.dart';
import 'package:phonetheft/pages/settings.dart';
void main() {
  runApp(MaterialApp(
    title: 'Anti Phone Theft',
    routes: {
      '/': (context) => PhoneTheft(),
      '/settings': (context) => Settings(),
    },
  ));
}