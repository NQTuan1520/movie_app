// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cast_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CastResponseObject<T> _$CastResponseObjectFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    CastResponseObject<T>(
      _$nullableGenericFromJson(json['cast'], fromJsonT),
    );

Map<String, dynamic> _$CastResponseObjectToJson<T>(
  CastResponseObject<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'cast': _$nullableGenericToJson(instance.cast, toJsonT),
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
