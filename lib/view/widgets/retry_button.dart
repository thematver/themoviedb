import 'package:flutter/material.dart';

class RetryButton extends StatelessWidget {
  final VoidCallback onPressed;
  const RetryButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      padding: const EdgeInsets.all(24),
      color: Colors.blue,
      child: const Icon(
        Icons.update,
        color: Colors.white,
      ),
    );
  }
}
