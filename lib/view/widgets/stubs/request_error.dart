import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/bloc/movies_bloc.dart';
import 'package:themoviedb/view/view.dart';

class RequestErrorStub extends StatelessWidget {
  const RequestErrorStub({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(24.0),
          child: Icon(Icons.warning_amber_rounded, size: 124),
        ),
        const Text(
          'Нам не удалось обработать ваш запрос. Попробуйте еще раз.',
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        const Spacer(),
        RetryButton(
          onPressed: () {},
        ),
      ],
    );
  }
}
