import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gra_app/core/di/dependency_injection.dart';
import 'package:gra_app/features/presentation/dashboard/widgets_sections/views/component/bloc/movie_year_list_bloc.dart';
import 'package:gra_app/features/presentation/film_list/bloc/list_page_bloc.dart';
import 'package:gra_app/services/domain/enums/winners_filter_enum.dart';
import 'package:gra_app/services/services/awards_service.dart';

class MovieYearListWidget extends StatelessWidget {
  const MovieYearListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) =>
            MovieListWidgetBloc(awardsService: inject.get<AwardsService>()),
        child: const _MovieYearListView());
  }
}

class _MovieYearListView extends StatefulWidget {
  const _MovieYearListView();

  @override
  State<_MovieYearListView> createState() => _MovieYearListViewtState();
}

class _MovieYearListViewtState extends State<_MovieYearListView> {
  final TextEditingController _searchYearController = TextEditingController();

  @override
  void initState() {
    context.read<MovieListWidgetBloc>().add(FetchWinnersMoviesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Lista de filmes vencedores por ano',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(4),
                    ],
                    keyboardType: TextInputType.number,
                    controller: _searchYearController,
                    decoration: const InputDecoration(
                      labelText: 'Buscar pelo ano',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    context.read<MovieListWidgetBloc>().add(FetchWinnersMoviesEvent(
                        year: _searchYearController.text));
                  },
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            BlocBuilder<MovieListWidgetBloc, MovieListWidgetState>(
              builder: (context, state) {
                if (state is MovieListWidgetLoadingState) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is MovieListWidgetErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                if (state is MovieListWidgetLoadedState) {
                  return DataTable(
                    dataRowMaxHeight: double.infinity,
                    columns: const [
                      DataColumn(label: Text('Código')),
                      DataColumn(label: Text('Ano')),
                      DataColumn(label: Text('Título')),
                    ],
                    rows: state.movies
                        .map((movie) => DataRow(cells: [
                              DataCell(Text('${movie.id}')),
                              DataCell(Text('${movie.year}')),
                              DataCell(Text(movie.title)),
                            ]))
                        .toList(),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }
}
