import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gra_app/services/domain/entities/awards_interval_producers.dart';
import 'package:gra_app/services/domain/entities/movie_entity.dart';
import 'package:gra_app/services/domain/entities/studio_winners.dart';
import 'package:gra_app/services/domain/entities/year_winners.dart';
import 'package:gra_app/services/services/awards_service.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({required AwardsService awardsService})
      : _awardsService = awardsService,
        super(DashboardInitialState()) {
    on<DashboardFetchYearsWinnersEvent>(_onFecthWinners);
  }

  final AwardsService _awardsService;

  Future<void> _onFecthWinners(DashboardFetchYearsWinnersEvent event,
      Emitter<DashboardState> emit) async {
    emit(DashboardLoadingState());
    try {
      final List<YearWinners> yearWinners =
          await _awardsService.getYearWinners();
      final List<StudioWinners> studioWinners =
          await _awardsService.getStudioWinners();
      final AwardsIntervalProducers awardsIntervalProducers =
          await _awardsService.getIntervalAwards();
      emit(DashboardLoadedState(
          yearWinners: yearWinners,
          studioWinners: studioWinners,
          awardsIntervalProducers: awardsIntervalProducers));
    } catch (e) {
      emit(DashboardErrorState(message: e.toString()));
    }
  }
}
