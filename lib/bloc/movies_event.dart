part of 'movies_bloc.dart';

abstract class MoviesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class MoviesFetched extends MoviesEvent {}

class SearchTermChanged extends MoviesEvent {
  final String? searchTerm;

  SearchTermChanged({required this.searchTerm});
  @override
  List<Object> get props => [searchTerm ?? ""];
}
