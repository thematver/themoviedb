import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/model/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:themoviedb/repository/movies_repository.dart';
import 'package:rxdart/rxdart.dart';

part 'movies_event.dart';
part 'movies_state.dart';

const throttleDuration = Duration(seconds: 1);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final MoviesRepository moviesRepository;

  MoviesBloc({required this.moviesRepository}) : super(const MoviesState()) {
    on<MoviesFetched>(
      _onMoviesFetched,
      transformer: debounce(throttleDuration),
    );

    on<SearchTermChanged>(
      _onSearchTermChanged,
      transformer: debounce(throttleDuration),
    );
  }

  Future<void> _onSearchTermChanged(
    SearchTermChanged event,
    Emitter<MoviesState> emit,
  ) async {
    if (event.searchTerm == "" || event.searchTerm == null) {
      emit(
        state.copyWith(
          status: MoviesStatus.initial,
          searchTerm: null,
        ),
      );

      return add(MoviesFetched());
    }

    emit(state.copyWith(status: MoviesStatus.loading));
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
            page: 1,
          ),
        );
      }
      var _movies = state.searchTerm != null && state.searchTerm != ""
          ? await moviesRepository.search(
              page: state.page,
              query: state.searchTerm,
            )
          : await moviesRepository.fetchDiscovery(page: state.page);
      _movies.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: MoviesStatus.success,
                movies: List.of(state.movies)..addAll(_movies),
                hasReachedMax: false,
                page: state.page + 1,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: MoviesStatus.failure));
    }
  }
}
