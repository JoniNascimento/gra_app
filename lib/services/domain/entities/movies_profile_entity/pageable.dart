import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'sort.dart';

class Pageable extends Equatable {
  final Sort? sort;
  final int? offset;
  final int? pageSize;
  final int? pageNumber;
  final bool? paged;
  final bool? unpaged;

  const Pageable({
    this.sort,
    this.offset,
    this.pageSize,
    this.pageNumber,
    this.paged,
    this.unpaged,
  });

  factory Pageable.fromMap(Map<String, dynamic> data) => Pageable(
        sort: data['sort'] == null
            ? null
            : Sort.fromMap(data['sort'] as Map<String, dynamic>),
        offset: data['offset'] as int?,
        pageSize: data['pageSize'] as int?,
        pageNumber: data['pageNumber'] as int?,
        paged: data['paged'] as bool?,
        unpaged: data['unpaged'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'sort': sort?.toMap(),
        'offset': offset,
        'pageSize': pageSize,
        'pageNumber': pageNumber,
        'paged': paged,
        'unpaged': unpaged,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Pageable].
  factory Pageable.fromJson(String data) {
    return Pageable.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Pageable] to a JSON string.
  String toJson() => json.encode(toMap());

  Pageable copyWith({
    Sort? sort,
    int? offset,
    int? pageSize,
    int? pageNumber,
    bool? paged,
    bool? unpaged,
  }) {
    return Pageable(
      sort: sort ?? this.sort,
      offset: offset ?? this.offset,
      pageSize: pageSize ?? this.pageSize,
      pageNumber: pageNumber ?? this.pageNumber,
      paged: paged ?? this.paged,
      unpaged: unpaged ?? this.unpaged,
    );
  }

  @override
  List<Object?> get props {
    return [
      sort,
      offset,
      pageSize,
      pageNumber,
      paged,
      unpaged,
    ];
  }
}
