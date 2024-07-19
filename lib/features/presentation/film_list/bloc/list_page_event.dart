part of 'list_page_bloc.dart';

abstract class ListPageEvent {}

class ListPageFetchMoviesEvent extends ListPageEvent {
  final String? year;
  final bool winners;

  ListPageFetchMoviesEvent({this.winners = true, this.year});
}