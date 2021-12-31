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
      cursorColor: Theme.of(context).iconTheme.color,
      decoration: InputDecoration(
        isDense: true,
        suffixIcon: shouldShowClearButton
            ? IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Theme.of(context).iconTheme.color,
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
