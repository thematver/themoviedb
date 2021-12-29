import 'package:flutter/material.dart';
import 'package:themoviedb/view/widgets/widgets.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: const [
          SearchInput(),
          Text("hello"),
        ],
      ),
    ));
  }
}
