import 'dart:convert';

import 'package:equatable/equatable.dart';

class Sort extends Equatable {
  final bool? unsorted;
  final bool? sorted;
  final bool? empty;

  const Sort({this.unsorted, this.sorted, this.empty});

  factory Sort.fromMap(Map<String, dynamic> data) => Sort(
        unsorted: data['unsorted'] as bool?,
        sorted: data['sorted'] as bool?,
        empty: data['empty'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'unsorted': unsorted,
        'sorted': sorted,
        'empty': empty,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Sort].
  factory Sort.fromJson(String data) {
    return Sort.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Sort] to a JSON string.
  String toJson() => json.encode(toMap());

  Sort copyWith({
    bool? unsorted,
    bool? sorted,
    bool? empty,
  }) {
    return Sort(
      unsorted: unsorted ?? this.unsorted,
      sorted: sorted ?? this.sorted,
      empty: empty ?? this.empty,
    );
  }

  @override
  List<Object?> get props => [unsorted, sorted, empty];
}
