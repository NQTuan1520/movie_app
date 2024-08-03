// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharedResponse _$SharedResponseFromJson(Map<String, dynamic> json) =>
    SharedResponse(
      id: json['id'] as String?,
      uid: json['uid'] as String?,
      title: json['title'] as String?,
      posterPath: json['posterPath'] as String?,
      idMovie: (json['id_movie'] as num?)?.toInt(),
      titleShared: json['title_shared'] as String?,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      like: (json['like'] as num?)?.toInt(),
      username: json['username'] as String?,
      isLike: json['isLike'] as bool?,
    );

Map<String, dynamic> _$SharedResponseToJson(SharedResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'title': instance.title,
      'posterPath': instance.posterPath,
      'email': instance.email,
      'avatar': instance.avatar,
      'like': instance.like,
      'isLike': instance.isLike,
      'username': instance.username,
      'id_movie': instance.idMovie,
      'title_shared': instance.titleShared,
    };
