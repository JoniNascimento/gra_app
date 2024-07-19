part of 'dashboard_bloc.dart';

abstract class DashboardEvent {}

class DashboardFetchYearsWinnersEvent extends DashboardEvent {
}

class DashboardFetchMoviesByYearEvent extends DashboardEvent {
  final String? year;

  DashboardFetchMoviesByYearEvent({this.year});
}
