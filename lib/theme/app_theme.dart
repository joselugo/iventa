import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.lightBlue;
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    //AppBar Theme
    appBarTheme: const AppBarTheme(color: primary, elevation: 0),
  );

  static SnackBar customSnackBarFailed(String message) {
    return SnackBar(
      content: Center(
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: Colors.red,
      duration: const Duration(seconds: 3),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
