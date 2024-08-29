part of 'list_page_bloc.dart';

abstract class ListPageEvent {}

class ListPageFetchMoviesEvent extends ListPageEvent {
  final String? year;
  final FilterWinners? winners;
  final int? page;

  ListPageFetchMoviesEvent(
      {this.winners = FilterWinners.todos, this.year = '', this.page = 1});
}
