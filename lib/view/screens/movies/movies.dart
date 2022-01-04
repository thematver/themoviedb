import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/bloc/movies_bloc.dart';
import 'package:themoviedb/model/movie.dart';
import 'package:themoviedb/view/widgets/bottom_loader.dart';
import 'package:themoviedb/view/widgets/move_tile.dart';
import 'package:themoviedb/view/widgets/search_appbar.dart';
import 'package:themoviedb/view/widgets/widgets.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  @override
  void initState() {
    context.read<MoviesBloc>().add(MoviesFetched());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SearchAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: BlocConsumer<MoviesBloc, MoviesState>(
                  listener: (context, state) {
                    if (state.status == MoviesStatus.failure) {
                      var snackbar = const SnackBar(
                        content: Text(
                          "Проверьте ваше соединение с интернетом и попробуйте еще раз.",
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                    }
                  },
                  builder: (context, state) {
                    if (state.status == MoviesStatus.loading &&
                        state.movies.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state.movies.isEmpty) {
                      return Center(
                        child: NothingFoundStub(
                          searchTerm: state.searchTerm,
                        ),
                      );
                    }

                    return const _MoviesList();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MoviesList extends StatefulWidget {
  const _MoviesList({
    Key? key,
  }) : super(key: key);

  @override
  __MoviesListState createState() => __MoviesListState();
}

class __MoviesListState extends State<_MoviesList> {
  final ScrollController _scrollController = ScrollController();
  var percentage = 0.0;
  late MoviesBloc bloc;

  @override
  void initState() {
    _scrollController.addListener(_onScroll);
    bloc = context.read<MoviesBloc>();
    super.initState();
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;

    return currentScroll >= (maxScroll * 0.99);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) bloc.add(MoviesFetched());
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (_scrollController.hasClients) {
          percentage = _scrollController.position.pixels /
              _scrollController.position.maxScrollExtent;
          if (orientation == Orientation.landscape) {
            percentage /= 2;
            _scrollController.jumpTo(
              percentage * _scrollController.position.maxScrollExtent,
            );
          } else {
            percentage *= 2;
            _scrollController.jumpTo(
              percentage * _scrollController.position.maxScrollExtent,
            );
          }
        }

        return BlocBuilder<MoviesBloc, MoviesState>(
          builder: (context, state) {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: 20,
                mainAxisSpacing: 10,
                childAspectRatio: 5 / 3,
                crossAxisCount: (orientation == Orientation.portrait) ? 1 : 2,
              ),
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              shrinkWrap: true,
              itemCount: state.hasReachedMax || state.movies.length < 20
                  ? state.movies.length
                  : state.movies.length + 1,
              itemBuilder: (context, index) {
                return index >= state.movies.length
                    ? const BottomLoader()
                    : MovieTile(
                        movie: state.movies[index],
                        key: Key(
                          state.movies[index].id.toString(),
                        ),
                      );
              },
            );
          },
        );
      },
    );
  }
}
