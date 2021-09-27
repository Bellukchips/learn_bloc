import 'package:flutter/material.dart';

enum AppTheme { lightMode, darkMode }

final appThemeData = {
  AppTheme.lightMode: ThemeData(
      brightness: Brightness.light,
      textTheme: const TextTheme(
          button: TextStyle(color: Colors.white),
          headline1: TextStyle(
            color: Colors.green,
            fontSize: 35,
          )),
      scaffoldBackgroundColor: Colors.green.shade200,
      primaryColor: Colors.green),
  AppTheme.darkMode: ThemeData(brightness: Brightness.dark)
};
