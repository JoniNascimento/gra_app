import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gra_app/services/domain/entities/movie_entity.dart';
import 'package:gra_app/services/domain/entities/movies_profile_entity/movies_profile_entity.dart';
import 'package:gra_app/services/domain/enums/winners_filter_enum.dart';
import 'package:gra_app/services/services/awards_service.dart';

part 'list_page_event.dart';
part 'list_page_state.dart';

class ListPageBloc extends Bloc<ListPageEvent, ListPageState> {
  final AwardsService _awardsService;

  ListPageBloc({required AwardsService awardsService})
      : _awardsService = awardsService,
        super(ListPageInitialState()) {
    on<ListPageFetchMoviesEvent>(_onFecthMovies);
  }

  Future<void> _onFecthMovies(
      ListPageFetchMoviesEvent event, Emitter<ListPageState> emit) async {
    emit(ListPageLoadingState());
    try {
      final movieProfile =
          await _awardsService.getAllMovies(winners: event.winners, size: 20, page: event.page);
     
      emit(ListPageLoadedState(movieProfile: movieProfile));
    } catch (e) {
      emit(ListPageErrorState(message: e.toString()));
    }
  }
}
