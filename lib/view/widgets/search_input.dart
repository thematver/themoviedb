import 'package:flutter/material.dart';

class SearchInput extends StatefulWidget {
  final Function(String?) onEntered;
  const SearchInput({Key? key, required this.onEntered}) : super(key: key);

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  final TextEditingController _textEditingController = TextEditingController();
  bool shouldShowClearButton = false;

  @override
  void initState() {
    _textEditingController.addListener(
      () {
        if (_textEditingController.value.text.isNotEmpty !=
            shouldShowClearButton) {
          setState(
            () {
              shouldShowClearButton =
                  _textEditingController.value.text.isNotEmpty;
            },
          );
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      onChanged: widget.onEntered,
      decoration: InputDecoration(
        suffixIcon: shouldShowClearButton
            ? IconButton(
                icon: const Icon(
                  Icons.clear,
                ),
                highlightColor: Colors.transparent,
                onPressed: () {
                  _textEditingController.clear();
                  widget.onEntered("");
                },
              )
            : null,
        prefixIcon: Icon(
          Icons.search,
          color: Theme.of(context).iconTheme.color,
        ),
        hintText: "Поиск по названию фильма",
      ),
    );
  }
}
