import 'package:flutter/material.dart';

class AppTheme {
  static const Color mainColor = Color(0xfff25723);
  static final ThemeData theme = ThemeData.light().copyWith(
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: const TextStyle(
        fontSize: 18,
        color: Color.fromARGB(255, 129, 129, 129),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: Color.fromARGB(255, 204, 204, 204), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: Color.fromARGB(255, 81, 167, 247), width: 2),
        borderRadius: BorderRadius.circular(5),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: mainColor,
        textStyle: const TextStyle(color: Colors.white),
        minimumSize: const Size.fromHeight(55),
        elevation: 0,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: mainColor,
      ),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: mainColor,
      elevation: 0,
    ),
  );
}
