import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gra_app/core/di/dependency_injection.dart';
import 'package:gra_app/features/presentation/film_list/bloc/list_page_bloc.dart';
import 'package:gra_app/features/presentation/film_list/widgets/bottom_pagination_widget.dart';
import 'package:gra_app/services/domain/entities/movie_entity.dart';
import 'package:gra_app/services/services/awards_service.dart';

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ListPageBloc(
        awardsService: inject.get<AwardsService>(),
      ),
      child: const _ListPageView(),
    );
  }
}

class _ListPageView extends StatefulWidget {
  const _ListPageView();

  @override
  State<_ListPageView> createState() => _ListPageViewState();
}

class _ListPageViewState extends State<_ListPageView> {
  final TextEditingController _searchYearController = TextEditingController();
  String dropdownValue = 'Sim';
  late ListPageBloc _bloc;
  final _movies = <MovieEntity>[];

  @override
  void initState() {
    _bloc = context.read<ListPageBloc>();
    _bloc.add(ListPageFetchMoviesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Lista de Filmes',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Flexible(
                    fit: FlexFit.loose,
                    child: TextField(
                      controller: _searchYearController,
                      decoration: const InputDecoration(
                        labelText: 'Filtrar pelo ano',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        if (value.length == 4) {
                          _bloc.add(ListPageFetchMoviesEvent(
                              year: value, winners: dropdownValue == 'Sim'));
                        }
                      },
                    ),
                  ),
                ),
                Column(
                  children: [
                    const Text('Filtrar por ganhadores?'),
                    SizedBox(
                      width: 150,
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: dropdownValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                          });
                          _bloc.add(ListPageFetchMoviesEvent(
                              year: _searchYearController.text,
                              winners: dropdownValue == 'Sim'));
                        },
                        items: <String>['Sim', 'Não']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            BlocBuilder<ListPageBloc, ListPageState>(
              builder: (context, state) {
                if (state is ListPageLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is ListPageLoadedState) {
                  if (state.movies.isEmpty) {
                    return const Text(
                        'Nenhum filme encontrado para o ano informado');
                  }
                  _movies.clear();
                  _movies.addAll(state.movies);

                  return Expanded(
                    child: DataTable(
                      columnSpacing: 20.0,
                      columns: const [
                        DataColumn(label: Text('Código')),
                        DataColumn(label: Text('Ano')),
                        DataColumn(label: Text('Titulo')),
                        DataColumn(label: Text('Vencedor?')),
                      ],
                      rows: state.movies
                          .map((movie) => DataRow(cells: [
                                DataCell(Text(movie.id.toString())),
                                DataCell(Text(movie.year.toString())),
                                DataCell(Text(movie.title.toString())),
                                DataCell(Text(movie.winner ? 'Sim' : 'Nao')),
                              ]))
                          .toList(),
                    ),
                  );
                }
                if (state is ListPageErrorState) {
                  return Center(
                    child: Text(state.message),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
      bottomNavigationBar: BottomPaginationWidget(
          listLength: _movies.length, onPageChanged: (selectedPage) {}),
    );
  }
}
