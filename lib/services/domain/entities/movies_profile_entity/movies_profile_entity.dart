import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:gra_app/services/domain/entities/movie_entity.dart';

import 'pageable.dart';
import 'sort.dart';

class MoviesProfileEntity extends Equatable {
  final List<MovieEntity>? movies;
  final Pageable? pageable;
  final int? totalPages;
  final int? totalElements;
  final bool? last;
  final int? size;
  final int? number;
  final Sort? sort;
  final bool? first;
  final int? numberOfElements;
  final bool? empty;

  const MoviesProfileEntity({
    this.movies,
    this.pageable,
    this.totalPages,
    this.totalElements,
    this.last,
    this.size,
    this.number,
    this.sort,
    this.first,
    this.numberOfElements,
    this.empty,
  });

  factory MoviesProfileEntity.fromMap(Map<String, dynamic> data) {
    return MoviesProfileEntity(
      movies: (data['content'] as List<dynamic>?)
          ?.map((e) => MovieEntity.fromMap(e as Map<String, dynamic>))
          .toList(),
      pageable: data['pageable'] == null
          ? null
          : Pageable.fromMap(data['pageable'] as Map<String, dynamic>),
      totalPages: data['totalPages'] as int?,
      totalElements: data['totalElements'] as int?,
      last: data['last'] as bool?,
      size: data['size'] as int?,
      number: data['number'] as int?,
      sort: data['sort'] == null
          ? null
          : Sort.fromMap(data['sort'] as Map<String, dynamic>),
      first: data['first'] as bool?,
      numberOfElements: data['numberOfElements'] as int?,
      empty: data['empty'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
        'content': movies?.map((e) => e.toMap()).toList(),
        'pageable': pageable?.toMap(),
        'totalPages': totalPages,
        'totalElements': totalElements,
        'last': last,
        'size': size,
        'number': number,
        'sort': sort?.toMap(),
        'first': first,
        'numberOfElements': numberOfElements,
        'empty': empty,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MoviesProfileEntity].
  factory MoviesProfileEntity.fromJson(String data) {
    return MoviesProfileEntity.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MoviesProfileEntity] to a JSON string.
  String toJson() => json.encode(toMap());

  MoviesProfileEntity copyWith({
    List<MovieEntity>? content,
    Pageable? pageable,
    int? totalPages,
    int? totalElements,
    bool? last,
    int? size,
    int? number,
    Sort? sort,
    bool? first,
    int? numberOfElements,
    bool? empty,
  }) {
    return MoviesProfileEntity(
      movies: content ?? this.movies,
      pageable: pageable ?? this.pageable,
      totalPages: totalPages ?? this.totalPages,
      totalElements: totalElements ?? this.totalElements,
      last: last ?? this.last,
      size: size ?? this.size,
      number: number ?? this.number,
      sort: sort ?? this.sort,
      first: first ?? this.first,
      numberOfElements: numberOfElements ?? this.numberOfElements,
      empty: empty ?? this.empty,
    );
  }

  @override
  List<Object?> get props {
    return [
      movies,
      pageable,
      totalPages,
      totalElements,
      last,
      size,
      number,
      sort,
      first,
      numberOfElements,
      empty,
    ];
  }
}
