import 'package:flutter/material.dart';

import 'colors.dart';

class TheMovieTheme {
  static ThemeData get darkTheme => ThemeData(
        textTheme: const TextTheme(
          subtitle1: TextStyle(color: Colors.black),
          caption: TextStyle(
            color: Colors.grey,
          ),
        ),
        iconTheme: IconThemeData(color: CustomColors.blue),
        inputDecorationTheme: InputDecorationTheme(
          floatingLabelStyle: const TextStyle(color: Colors.black),
          labelStyle: const TextStyle(color: Colors.black),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          filled: true,
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
        colorScheme:
            const ColorScheme.dark().copyWith(primary: CustomColors.blue),
      );
}
