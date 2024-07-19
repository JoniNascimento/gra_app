part of 'dashboard_bloc.dart';

abstract class DashboardState {}

class DashboardInitialState extends DashboardState {}

class DashboardLoadingState extends DashboardState {}

class DashboardLoadedState extends DashboardState {
  final List<YearWinners> yearWinners;
  final List<StudioWinners> studioWinners;
  final AwardsIntervalProducers awardsIntervalProducers;

  DashboardLoadedState({
    required this.studioWinners,
    required this.yearWinners,
    required this.awardsIntervalProducers,
  });
}

class DashboardErrorState extends DashboardState {
  final String message;

  DashboardErrorState({required this.message});
}
