import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final int year;
  final String title;
  final List<String> studios;
  final List<String> producers;
  final bool winner;

  const MovieEntity({
    required this.id,
    required this.year,
    required this.title,
    required this.studios,
    required this.producers,
    required this.winner,
  });

  factory MovieEntity.fromMap(Map<String, dynamic> json) {
  
  return MovieEntity(
        id: json['id'],
        year: json['year'],
        title: json['title'],
        studios: List.generate(json['studios'].length, (index) => json['studios'][index]),
        producers: List.generate(json['producers'].length, (index) => json['producers'][index]),
        winner: json['winner'],
      );
}

  Map<String, dynamic> toMap() => {
        'id': id,
        'year': year,
        'title': title,
        'studios': studios,
        'producers': producers,
        'winner': winner,
      };

  @override
  List<Object?> get props {
    return [
      id,
    ];
  }
}
