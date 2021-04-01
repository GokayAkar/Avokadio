import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String message) {
  Future.delayed(Duration(milliseconds: 300)).then(
    (_) => ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    ),
  );
}

final ThemeData appTheme = ThemeData(
  appBarTheme: AppBarTheme(brightness: Brightness.dark),
  primarySwatch: Colors.green,
  accentColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderSide: BorderSide(
        width: 3,
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
  ),
);
