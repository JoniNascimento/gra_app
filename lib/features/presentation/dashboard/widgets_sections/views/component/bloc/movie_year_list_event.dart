part of 'movie_year_list_bloc.dart';

abstract class ListPageEvent {}

class FetchWinnersMoviesEvent extends ListPageEvent {
  final String? year;

  FetchWinnersMoviesEvent(
      {this.year = ''});
}
