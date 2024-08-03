// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'like_post_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LikePostRequest _$LikePostRequestFromJson(Map<String, dynamic> json) =>
    LikePostRequest(
      idPost: json['postId'] as String?,
      idUser: json['uid'] as String?,
    );

Map<String, dynamic> _$LikePostRequestToJson(LikePostRequest instance) =>
    <String, dynamic>{
      'postId': instance.idPost,
      'uid': instance.idUser,
    };
