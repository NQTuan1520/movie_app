// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page_result_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PageResponse<T> _$PageResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    PageResponse<T>(
      _$nullableGenericFromJson(json['results'], fromJsonT),
      (json['page'] as num?)?.toInt(),
      (json['totalPages'] as num?)?.toInt(),
      (json['totalResults'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PageResponseToJson<T>(
  PageResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'results': _$nullableGenericToJson(instance.results, toJsonT),
      'page': instance.page,
      'totalPages': instance.totalPages,
      'totalResults': instance.totalResults,
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
