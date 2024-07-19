import 'package:equatable/equatable.dart';

class StudioWinners extends Equatable {
  final String name;
  final int winCount;

  const StudioWinners({required this.name, required this.winCount});

  factory StudioWinners.fromMap(Map<String, dynamic> json) => StudioWinners(
        name: json['name'],
        winCount: json['winCount'],
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'winCount': winCount,
      };

  @override
  List<Object?> get props => [name, winCount];
}
