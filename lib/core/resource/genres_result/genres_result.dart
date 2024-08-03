

import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genres_result.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class GenresResult<T> extends Equatable {
  final T? genres;

  const GenresResult(this.genres);

  factory GenresResult.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$GenresResultFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$GenresResultToJson(this, toJsonT);

  @override
  List<Object?> get props => [genres];

  GenresResult<T> copyWith({
    T? genres,
  }) {
    return GenresResult<T>(
      genres ?? this.genres,
    );
  }

  @override
  String toString() {
    return 'GenresResult{genres: $genres}';
  }
}