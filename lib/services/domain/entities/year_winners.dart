import 'package:equatable/equatable.dart';

class YearWinners extends Equatable {
  final int year;
  final int winnerCount;

  const YearWinners({required this.year, required this.winnerCount});

  factory YearWinners.fromMap(Map<String, dynamic> json) => YearWinners(
        year: json['year'],
        winnerCount: json['winnerCount'],
      );

  Map<String, dynamic> toMap() => {
        'year': year,
        'winnerCount': winnerCount,
      };

  @override
  List<Object?> get props => [year, winnerCount];
}
