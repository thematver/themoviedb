import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/model/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:themoviedb/repository/movies_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'movies_event.dart';
part 'movies_state.dart';

const debounceDuration = Duration(seconds: 1);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository moviesRepository;

  MoviesBloc({required this.moviesRepository}) : super(const MoviesState()) {
    on<MoviesFetched>(
      _onMoviesFetched,
      transformer: debounce(debounceDuration),
    );

    on<SearchTermChanged>(_onSearchTermChanged);

    on<SearchQuery>(
      _onSearchQuery,
      transformer: debounce(debounceDuration),
    );

    on<Refresh>(_onRefresh);
  }

  Future<void> _onRefresh(
    Refresh event,
    Emitter<MoviesState> emit,
  ) async {
    emit(
      state.copyWith(
        status: MoviesStatus.loading,
        movies: [],
        searchTerm: state.searchTerm,
        hasReachedMax: false,
        page: 1,
      ),
    );

    add(MoviesFetched());
  }

  Future<void> _onSearchTermChanged(
    SearchTermChanged event,
    Emitter<MoviesState> emit,
  ) async {
    if (event.searchTerm == "" || event.searchTerm == null) {
      emit(
        state.copyWith(
          status: MoviesStatus.initial,
          movies: null,
          searchTerm: null,
          hasReachedMax: false,
          page: 1,
        ),
      );

      return add(MoviesFetched());
    }

    emit(state.copyWith(status: MoviesStatus.loading));

    return add(SearchQuery(searchTerm: event.searchTerm));
  }

  Future<void> _onSearchQuery(
    SearchQuery event,
    Emitter<MoviesState> emit,
  ) async {
    final _movies =
        await moviesRepository.search(page: 1, query: event.searchTerm);

    return emit(
      state.copyWith(
        status: MoviesStatus.success,
        movies: _movies,
        hasReachedMax: false,
        page: 1,
        searchTerm: event.searchTerm,
      ),
    );
  }

  Future<void> _onMoviesFetched(
    MoviesFetched event,
    Emitter<MoviesState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == MoviesStatus.initial) {
        emit(state.copyWith(status: MoviesStatus.loading));
        var _movies = await moviesRepository.fetchDiscovery(page: state.page);

        return emit(
          state.copyWith(
            status: MoviesStatus.success,
            movies: _movies,
            hasReachedMax: false,
            page: state.page + 1,
          ),
        );
      }
      var _movies = state.searchTerm != null && state.searchTerm != ""
          ? await moviesRepository.search(
              page: state.page,
              query: state.searchTerm,
            )
          : await moviesRepository.fetchDiscovery(page: state.page);
      _movies.isEmpty || _movies.length < 20
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: MoviesStatus.success,
                movies: List.of(state.movies)..addAll(_movies),
                hasReachedMax: false,
                page: state.page + 1,
                searchTerm: state.searchTerm,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: MoviesStatus.failure));
    }
  }
}
