import 'package:equatable/equatable.dart';
import 'package:gra_app/services/domain/entities/producer_winners.dart';

class AwardsIntervalProducers extends Equatable {
  final List<ProducerWinners> min;
  final List<ProducerWinners> max;

  const AwardsIntervalProducers({required this.min, required this.max});

  factory AwardsIntervalProducers.fromMap(Map<String, dynamic> json) {
    return AwardsIntervalProducers(
      min: List<ProducerWinners>.from(
          json['min'].map((x) => ProducerWinners.fromMap(x))).toList(),
      max: List<ProducerWinners>.from(
          json['max'].map((x) => ProducerWinners.fromMap(x))).toList(),
    );
  }

  @override
  List<Object?> get props => [min, max];
}
