import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/bloc/movies_bloc.dart';
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
    setState(() {
      searchTerm = term;
    });
    context.read<MoviesBloc>().add(SearchTermChanged(searchTerm: searchTerm));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesBloc, MoviesState>(
      builder: (context, state) {
        return SizedBox(
          height: widget.preferredSize.height,
          child: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            toolbarHeight: 150,
            title: Column(
              children: [
                SearchInput(onEntered: onSearch),
                state.status == MoviesStatus.loading && state.movies.isNotEmpty
                    ? const Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: LinearProgressIndicator(),
                      )
                    : Container(),
              ],
            ),
            elevation: searchTerm != null ? 4 : 0,
          ),
        );
      },
    );
  }
}
