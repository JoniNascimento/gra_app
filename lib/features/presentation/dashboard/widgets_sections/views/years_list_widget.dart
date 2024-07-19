import 'package:flutter/material.dart';
import 'package:gra_app/services/domain/entities/year_winners.dart';

class YearsListWidget extends StatelessWidget {
  const YearsListWidget({super.key, required this.years});

  final List<YearWinners> years;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Lista de anos com mais de um vencedores',
                style: TextStyle(fontWeight: FontWeight.bold)),
            DataTable(
              columns: const [
                DataColumn(label: Text('Ano')),
                DataColumn(label: Text('Qtd. Vencedores')),
              ],
              rows: years
                  .map(
                    (yearWinters) => DataRow(cells: [
                      DataCell(Text('${yearWinters.year}')),
                      DataCell(Text('${yearWinters.winnerCount}')),
                    ]),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
