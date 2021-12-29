import 'package:flutter/material.dart';

class TheMovieTheme {
  static ThemeData get darkTheme => ThemeData(
        iconTheme: const IconThemeData(color: Colors.blueAccent),
        inputDecorationTheme: InputDecorationTheme(
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
