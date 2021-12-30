import 'package:flutter/material.dart';

class NothingFoundStub extends StatelessWidget {
  final String? searchTerm;

  const NothingFoundStub({Key? key, required this.searchTerm})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(24.0),
          child: Icon(Icons.search_off, size: 86),
        ),
        Text(
          'По запросу "$searchTerm" ничего не найдено.',
          maxLines: 2,
        ),
      ],
    );
  }
}
