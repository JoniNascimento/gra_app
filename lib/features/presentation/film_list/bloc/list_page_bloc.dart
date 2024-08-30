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
    try {
      final currentState = state;
      emit(ListPageLoadingState());
      int diferencesPagesApi = 0;
      int currentPages = 0;

      ///Joni Nascimento
      ///Ajuste necessário devido ao comportamento da api de não retornar dados
      ///se o numero de itens maximos passados for maior que o tamanho da lista
      if(event.page! > 1){
        if (currentState is ListPageLoadedState) {
        if (event.page == currentState.movieProfile.totalPages) {
          diferencesPagesApi = currentState.movieProfile.numberOfElements! ~/
              currentState.movieProfile.size!;

          currentPages = currentState.movieProfile.totalPages!;
        }
      }
      }
      final size = (event.year.isNotEmpty && event.winners == FilterWinners.sim) ? 1 : diferencesPagesApi > 0 ? diferencesPagesApi : 10;

      final movieProfile = await _awardsService.getAllMovies(
          winners: event.winners,
          size: size,
          page: event.page, year: event.year);


      emit(ListPageLoadedState(movieProfile: currentPages > 0 ?  movieProfile.copyWith(totalPages:currentPages ) : movieProfile));
    } catch (e) {
      emit(ListPageErrorState(message: e.toString()));
    }
  }
}
