import 'package:flutter/material.dart';

ThemeData getApplicationTheme(context) {
  return ThemeData(
    primarySwatch: Colors.red,
    fontFamily: 'Raleway Regular',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 214, 1, 51),
        textStyle:
            const TextStyle(fontFamily: 'Raleway SemiBold', fontSize: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
            color: Color.fromARGB(255, 49, 49, 49),
            fontFamily: 'Raleway Regular'),
      ),
    ),
    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        color: Color.fromARGB(255, 49, 49, 49),
        fontSize: 16,
        fontFamily: 'Raleway Bold',
      ),
      headlineMedium: TextStyle(
        color: Color.fromARGB(255, 49, 49, 49),
        fontSize: 14,
        fontFamily: 'Raleway SemiBold',
      ),
      headlineSmall: TextStyle(
        color: Color.fromARGB(255, 49, 49, 49),
        fontSize: 12,
        fontFamily: 'Raleway Regular',
      ),
    ),
  );
}
