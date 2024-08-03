// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'keyword_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KeywordResponse _$KeywordResponseFromJson(Map<String, dynamic> json) =>
    KeywordResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$KeywordResponseToJson(KeywordResponse instance) =>
    <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
    };
