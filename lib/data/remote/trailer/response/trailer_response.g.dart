// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trailer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrailerResponse _$TrailerResponseFromJson(Map<String, dynamic> json) =>
    TrailerResponse(
      iso6391: json['iso_639_1'] as String?,
      iso31661: json['iso_3166_1'] as String?,
      name: json['name'] as String?,
      key: json['key'] as String?,
      site: json['site'] as String?,
      size: (json['size'] as num?)?.toInt(),
      type: json['type'] as String?,
      official: json['official'] as bool?,
      publishedAt: json['published_at'] as String?,
      id: json['id'] as String?,
    );

Map<String, dynamic> _$TrailerResponseToJson(TrailerResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'key': instance.key,
      'site': instance.site,
      'size': instance.size,
      'type': instance.type,
      'official': instance.official,
      'id': instance.id,
      'iso_639_1': instance.iso6391,
      'iso_3166_1': instance.iso31661,
      'published_at': instance.publishedAt,
    };
