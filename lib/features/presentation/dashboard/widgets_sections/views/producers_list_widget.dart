import 'package:flutter/material.dart';
import 'package:gra_app/services/domain/entities/awards_interval_producers.dart';

class ProducersList extends StatelessWidget {
  const ProducersList({super.key, required this.producersInterval});

  final AwardsIntervalProducers producersInterval;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
                'Produtores com intervalos minimos e máximos de vencedores',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            const Text('Maximum',
                style: TextStyle(fontWeight: FontWeight.bold)),
            DataTable(
              columnSpacing: 15,
              columns: const [
                DataColumn(label: Text('Produtor')),
                DataColumn(label: Text('Intervalo')),
                DataColumn(label: Text('Anterior')),
                DataColumn(label: Text('Seguinte')),
              ],
              rows: producersInterval.max
                  .map(
                    (maxInterval) => DataRow(cells: [
                      DataCell(Text(maxInterval.producer)),
                      DataCell(Text('${maxInterval.interval}')),
                      DataCell(Text('${maxInterval.previousWin}')),
                      DataCell(Text('${maxInterval.followingWin}')),
                    ]),
                  )
                  .toList(),
            ),
            const SizedBox(height: 8.0),
            const Text('Minimo',
                style: TextStyle(fontWeight: FontWeight.bold)),
            DataTable(
              columnSpacing: 15,
              columns: const [
                DataColumn(label: Text('Produtor')),
                DataColumn(label: Text('Intervalo')),
                DataColumn(label: Text('Anterior')),
                DataColumn(label: Text('Seguinte')),
              ],
              rows: producersInterval.min
                  .map(
                    (minInterval) => DataRow(cells: [
                      DataCell(Text(minInterval.producer)),
                      DataCell(Text('${minInterval.interval}')),
                      DataCell(Text('${minInterval.previousWin}')),
                      DataCell(Text('${minInterval.followingWin}')),
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
