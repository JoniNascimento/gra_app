import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gra_app/services/domain/entities/movie_entity.dart';
import 'package:gra_app/services/domain/enums/winners_filter_enum.dart';
import 'package:gra_app/services/services/awards_service.dart';

part 'movie_year_list_event.dart';
part 'movie_year_list_state.dart';

class MovieListWidgetBloc extends Bloc<ListPageEvent, MovieListWidgetState> {
  final AwardsService _awardsService;

  MovieListWidgetBloc({required AwardsService awardsService})
      : _awardsService = awardsService,
        super(MovieListWidgetInitialState()) {
    on<FetchWinnersMoviesEvent>(_onFecthWinnersMovies);
  }

  Future<void> _onFecthWinnersMovies(
      FetchWinnersMoviesEvent event, Emitter<MovieListWidgetState> emit) async {
    emit(MovieListWidgetLoadingState());
    try {
      List<MovieEntity> movies = [];

      if (event.year!.isEmpty) {
        final movieProfile = await _awardsService.getAllMovies(
            winners: FilterWinners.sim);
        movies = movieProfile.movies ?? [];
      } else {
        movies = await _awardsService.getMovieWinnersByYear(year: event.year);
      }
      emit(MovieListWidgetLoadedState(movies: movies));
    } catch (e) {
      emit(MovieListWidgetErrorState(message: e.toString()));
    }
  }
}
