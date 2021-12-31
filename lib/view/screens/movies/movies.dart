import 'package:flutter/material.dart';
import 'package:themoviedb/model/movie.dart';
import 'package:themoviedb/services/network_client.dart';
import 'package:themoviedb/view/widgets/move_tile.dart';
import 'package:themoviedb/view/widgets/search_appbar.dart';
import 'package:themoviedb/view/widgets/widgets.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen> {
  String? searchTerm = "";
  List<Movie> movies = [];

  @override
  void initState() {
    NetworkClient client = NetworkClient();
    super.initState();
    client.fetchDiscover(
      onSuccess: (moviesList) {
        if (moviesList != null) {
          movies = moviesList;
        }
      },
      onError: (error) {
        debugPrint("$error");
      },
    );
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
                child: _MoviesList(
                  movies: movies,
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
  final List<Movie> movies;
  const _MoviesList({Key? key, required this.movies}) : super(key: key);

  @override
  __MoviesListState createState() => __MoviesListState();
}

class __MoviesListState extends State<_MoviesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.movies.length,
      itemBuilder: (context, index) => MovieTile(
        movie: widget.movies[index],
      ),
    );
  }
}
