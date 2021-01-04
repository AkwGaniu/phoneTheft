import 'package:flutter/material.dart';

const inputFieldDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.deepPurple, 
      width: 1.0,
    )
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.white, 
      width: 2.0,
    )
  ) 
);