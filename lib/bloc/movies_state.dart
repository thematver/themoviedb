part of 'movies_bloc.dart';

enum MoviesStatus { initial, success, loading, failure }

class MoviesState extends Equatable {
  const MoviesState({
    this.status = MoviesStatus.initial,
    this.movies = const <Movie>[],
    this.hasReachedMax = false,
    this.page = 1,
    this.searchTerm,
  });

  final MoviesStatus status;
  final List<Movie> movies;
  final bool hasReachedMax;
  final int page;
  final String? searchTerm;

  MoviesState copyWith({
    MoviesStatus? status,
    List<Movie>? movies,
    bool? hasReachedMax,
    int? page,
    String? searchTerm,
  }) {
    return MoviesState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }

  @override
  String toString() {
    return '''MoviesState { status: $status, hasReachedMax: $hasReachedMax, movies: ${movies.length}, page: $page, searchTerm: $searchTerm }''';
  }

  @override
  List<Object> get props =>
      [status, movies, hasReachedMax, page, searchTerm ?? ""];
}
