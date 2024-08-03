// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_object_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageResponseObject<T> _$ImageResponseObjectFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    ImageResponseObject<T>(
      _$nullableGenericFromJson(json['backdrops'], fromJsonT),
    );

Map<String, dynamic> _$ImageResponseObjectToJson<T>(
  ImageResponseObject<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'backdrops': _$nullableGenericToJson(instance.backdrops, toJsonT),
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
