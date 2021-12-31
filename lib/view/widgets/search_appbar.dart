import 'package:flutter/material.dart';
import 'package:themoviedb/view/widgets/widgets.dart';

class SearchAppBar extends StatefulWidget implements PreferredSizeWidget {
  const SearchAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(150);

  @override
  State<SearchAppBar> createState() => _SearchAppBarState();
}

class _SearchAppBarState extends State<SearchAppBar> {
  String? searchTerm = "";

  void onSearch(String? term) {
    setState(
      () {
        searchTerm = term;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.preferredSize.height,
      child: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        toolbarHeight: 150,
        title: SearchInput(onEntered: onSearch),
        elevation: searchTerm != null && searchTerm!.isNotEmpty ? 4 : 0,
      ),
    );
  }
}
