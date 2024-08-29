part of 'list_page_bloc.dart';

abstract class ListPageState {}

class ListPageInitialState extends ListPageState {}

class ListPageLoadingState extends ListPageState {}

class ListPageErrorState extends ListPageState {
  final String message;

  ListPageErrorState({required this.message});
}

class ListPageLoadedState extends ListPageState {
  final MoviesProfileEntity movieProfile;

  ListPageLoadedState({required this.movieProfile});
}
