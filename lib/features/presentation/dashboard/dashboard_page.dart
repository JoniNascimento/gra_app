import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gra_app/core/di/dependency_injection.dart';
import 'package:gra_app/features/presentation/dashboard/widgets_sections/bloc/dashboard_bloc.dart';
import 'package:gra_app/features/presentation/dashboard/widgets_sections/views/movie_year_list_widget.dart';
import 'package:gra_app/features/presentation/dashboard/widgets_sections/views/producers_list_widget.dart';
import 'package:gra_app/features/presentation/dashboard/widgets_sections/views/studios_list_widget.dart';
import 'package:gra_app/features/presentation/dashboard/widgets_sections/views/years_list_widget.dart';
import 'package:gra_app/features/presentation/film_list/bloc/list_page_bloc.dart';
import 'package:gra_app/services/services/awards_service.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            DashboardBloc(awardsService: inject.get<AwardsService>()),
        child: const _DashboardView());
  }
}

class _DashboardView extends StatefulWidget {
  const _DashboardView();

  @override
  State<_DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<_DashboardView> {
  late DashboardBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<DashboardBloc>();
    _bloc.add(DashboardFetchYearsWinnersEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DashboardLoadedState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                YearsListWidget(
                  years: state.yearWinners,
                ),
                const SizedBox(width: 26.0),
                StudiosListWidget(
                  studios: state.studioWinners,
                ),
                const SizedBox(height: 26.0),
                ProducersList(
                  producersInterval: state.awardsIntervalProducers,
                ),
                const SizedBox(height: 26.0),
                const MovieYearListWidget()
              ],
            );
          }
          if (state is DashboardErrorState) {
            return Center(
              child: Text(state.message),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
