part of 'movie_year_list_bloc.dart';

abstract class MovieListWidgetState {}

class MovieListWidgetInitialState extends MovieListWidgetState {}

class MovieListWidgetLoadingState extends MovieListWidgetState {}

class MovieListWidgetErrorState extends MovieListWidgetState {
  final String message;

  MovieListWidgetErrorState({required this.message});
}

class MovieListWidgetLoadedState extends MovieListWidgetState {
  final List<MovieEntity> movies;

  MovieListWidgetLoadedState({required this.movies});
}
