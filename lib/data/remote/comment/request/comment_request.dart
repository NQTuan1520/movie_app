// ignore_for_file: overridden_fields, annotate_overrides

import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/comment/entity/comment_entity.dart';

part 'comment_request.g.dart';

@JsonSerializable(explicitToJson: true)
class CommentRequest extends CommentEntity {
  @override
  @JsonKey(name: "postId")
  final String? postId;

  @override
  @JsonKey(name: "parentId")
  final String? parentId;

  @override
  @JsonKey(name: "timestamp")
  final String? timestamp;

  @override
  @JsonKey(name: "username")
  final String? username;

  const CommentRequest({
    super.id,
    this.postId,
    super.uid,
    super.email,
    super.avatar,
    super.content,
    this.timestamp,
    this.parentId,
    this.username,
  });

  factory CommentRequest.fromJson(Map<String, dynamic> json) => _$CommentRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CommentRequestToJson(this);
}
