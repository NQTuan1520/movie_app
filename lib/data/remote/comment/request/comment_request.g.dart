// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CommentRequest _$CommentRequestFromJson(Map<String, dynamic> json) =>
    CommentRequest(
      id: json['id'] as String?,
      postId: json['postId'] as String?,
      uid: json['uid'] as String?,
      email: json['email'] as String?,
      avatar: json['avatar'] as String?,
      content: json['content'] as String?,
      timestamp: json['timestamp'] as String?,
      parentId: json['parentId'] as String?,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$CommentRequestToJson(CommentRequest instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uid': instance.uid,
      'email': instance.email,
      'avatar': instance.avatar,
      'content': instance.content,
      'postId': instance.postId,
      'parentId': instance.parentId,
      'timestamp': instance.timestamp,
      'username': instance.username,
    };
