import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FavoriteButton extends StatefulWidget {
  final bool isFavorite;
  final Function(bool) onFavoriteChanged;
  const FavoriteButton({
    Key? key,
    this.isFavorite = false,
    required this.onFavoriteChanged,
  }) : super(key: key);

  @override
  _FavoriteButtonState createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  late bool isFavorite;

  @override
  void initState() {
    isFavorite = widget.isFavorite;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        HapticFeedback.lightImpact();
        setState(() {
          isFavorite = !isFavorite;
        });
        widget.onFavoriteChanged(isFavorite);
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Icon(
          isFavorite ? Icons.favorite : Icons.favorite_border,
          key: ValueKey<bool>(isFavorite),
        ),
      ),
    );
  }
}
