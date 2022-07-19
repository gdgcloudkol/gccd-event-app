import 'package:flutter/material.dart';
import 'package:ccd2022app/utils/constants.dart';

final ThemeData darkTheme = ThemeData.dark().copyWith(
  scaffoldBackgroundColor: const Color(0xFF212121),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Color(0x57FFFFFF)),
    bodyText2: TextStyle(
      color: Color(0xFFF9F9F9),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    labelStyle: TextStyle(
      color: Colors.white,
    ),
  ),
);

final ThemeData lightTheme = ThemeData.light().copyWith(
  scaffoldBackgroundColor: kScaffoldLightBg,
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.black),
    bodyText2: TextStyle(
      color: Colors.black87,
      // color: Colors.black87,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFF9F9F9),
      ),
    ),
    labelStyle: TextStyle(
      color: Color(0xFFF1F1F1),
    ),
  ),
);
