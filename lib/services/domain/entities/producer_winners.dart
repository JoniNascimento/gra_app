import 'package:equatable/equatable.dart';

class ProducerWinners extends Equatable {
  final String producer;
  final int interval;
  final int previousWin;
  final int followingWin;

  const ProducerWinners({
    required this.producer,
    required this.interval,
    required this.previousWin,
    required this.followingWin,
  });

  factory ProducerWinners.fromMap(Map<String, dynamic> json) {
    return ProducerWinners(
      producer: json['producer'],
      interval: json['interval'],
      previousWin: json['previousWin'],
      followingWin: json['followingWin'],
    );
  }

  Map<String, dynamic> toMap() => {
        'producer': producer,
        'interval': interval,
        'previousWin': previousWin,
        'followingWin': followingWin,
      };

  @override
  List<Object?> get props {
    return [
      producer,
      interval,
      previousWin,
      followingWin,
    ];
  }
}
