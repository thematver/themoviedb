import 'package:flutter/material.dart';

class TheMovieTheme {
  static ThemeData get darkTheme => ThemeData(
        textTheme: const TextTheme(
          subtitle1: TextStyle(color: Colors.black),
        ),
        iconTheme: const IconThemeData(color: Colors.blueAccent),
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
        colorScheme: const ColorScheme.dark(),
      );
}
