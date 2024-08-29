import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gra_app/core/di/dependency_injection.dart';
import 'package:gra_app/features/presentation/film_list/bloc/list_page_bloc.dart';
import 'package:gra_app/features/presentation/film_list/widgets/bottom_pagination_widget.dart';
import 'package:gra_app/services/domain/entities/movie_entity.dart';
import 'package:gra_app/services/domain/enums/winners_filter_enum.dart';
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
  FilterWinners dropdownValue = FilterWinners.todos;
  late ListPageBloc _bloc;
  final List<MovieEntity> _movies = [];

  @override
  void initState() {
    _bloc = context.read<ListPageBloc>();
    _bloc.add(ListPageFetchMoviesEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
                child: TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(4),
                  ],
                  keyboardType: TextInputType.number,
                  controller: _searchYearController,
                  decoration: const InputDecoration(
                    labelText: 'Filtrar pelo ano',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    if (value.length == 4 || value.isEmpty) {
                      _bloc.add(ListPageFetchMoviesEvent(
                          year: value, winners: dropdownValue));
                    }
                  },
                ),
              ),
              Column(
                children: [
                  const Text('Filtrar por ganhadores?'),
                  SizedBox(
                    width: 150,
                    child: DropdownButton<FilterWinners>(
                      isExpanded: true,
                      value: dropdownValue,
                      onChanged: (FilterWinners? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                          if (newValue == FilterWinners.todos) {
                            _searchYearController.text = '';
                          }
                        });
                        _bloc.add(ListPageFetchMoviesEvent(
                            year: _searchYearController.text,
                            winners: dropdownValue));
                      },
                      items: <FilterWinners>[
                        FilterWinners.todos,
                        FilterWinners.sim,
                        FilterWinners.nao
                      ].map<DropdownMenuItem<FilterWinners>>(
                          (FilterWinners value) {
                        return DropdownMenuItem<FilterWinners>(
                          value: value,
                          child: Text(value.name),
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
                if (state.movieProfile.movies!.isEmpty) {
                  return const Text(
                      'Nenhum filme encontrado para os filtros informados');
                }
                _movies.clear();
                _movies.addAll(state.movieProfile.movies as Iterable<MovieEntity>);

                return Expanded(
                    child: Scaffold(
                  bottomNavigationBar: BottomPaginationWidget(
                    itemsPerPage: state.movieProfile.size!,
                    listLength: state.movieProfile.size!,
                    totalPages: state.movieProfile.totalPages!,
                    onPageChanged: (selectedPage) {
                      _bloc.add(ListPageFetchMoviesEvent(page: selectedPage));
                    }, selectedPage: state.movieProfile.number!,
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: DataTable(
                            dataRowMaxHeight: double.infinity,
                            columnSpacing: 20.0,
                            columns: const [
                              DataColumn(label: Text('Código')),
                              DataColumn(label: Text('Ano')),
                              DataColumn(label: Text('Titulo')),
                              DataColumn(label: Text('Vencedor?')),
                            ],
                            rows: state.movieProfile.movies
                                !.map((movie) => DataRow(cells: [
                                      DataCell(Text(
                                        movie.id.toString(),
                                      )),
                                      DataCell(Text(movie.year.toString())),
                                      DataCell(Text(movie.title.toString())),
                                      DataCell(
                                          Text(movie.winner ? 'Sim' : 'Nao')),
                                    ]))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
              }

              if (state is ListPageErrorState) {
                return Center(
                  child: Text(state.message),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
