import 'package:flutter/material.dart';
import 'view/view.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: TheMovieTheme.darkTheme,
      home: const MoviesScreen(),
    );
  }
}
