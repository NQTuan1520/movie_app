// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genres_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenresResult<T> _$GenresResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    GenresResult<T>(
      _$nullableGenericFromJson(json['genres'], fromJsonT),
    );

Map<String, dynamic> _$GenresResultToJson<T>(
  GenresResult<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'genres': _$nullableGenericToJson(instance.genres, toJsonT),
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
