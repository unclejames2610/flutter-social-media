import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
  ),
  colorScheme: ColorScheme.light(
    background: Colors.grey[300]!,
    primary: Colors.grey[200]!,
    secondary: Colors.grey[300]!,
    tertiary: Colors.black,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: Colors.grey[800]!,
  ),
);
    


  //  theme: ThemeData(
  //       primaryColor: Colors.grey[900],
  //       appBarTheme: AppBarTheme(
  //           color: Colors.grey[900],
  //           titleTextStyle: const TextStyle(
  //             color: Colors.white,
  //             fontSize: 24,
  //           ),
  //           iconTheme: const IconThemeData(color: Colors.white)),
  //       colorScheme:
  //           ColorScheme.fromSwatch().copyWith(background: Colors.grey[300]),
  //       textSelectionTheme: const TextSelectionThemeData(
  //         cursorColor: Colors.black,
  //       ),
  //     ),