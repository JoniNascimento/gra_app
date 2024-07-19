import 'package:flutter/material.dart';
import 'package:gra_app/services/domain/entities/studio_winners.dart';

class StudiosListWidget extends StatelessWidget {
  const StudiosListWidget({super.key, required this.studios});

  final List<StudioWinners> studios;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding:  EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Top 3 studios com vencedores',
                style: TextStyle(fontWeight: FontWeight.bold)),
            DataTable(
              columnSpacing: 20,
              columns: const [
                DataColumn(label: Text('Nome')),
                DataColumn(label: Text('Qtd. Vencedores')),
              ],
              rows: studios
                  .map(
                    (studioWinters) => DataRow(cells: [
                      DataCell(Text(studioWinters.name)),
                      DataCell(Text('${studioWinters.winCount}')),
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
