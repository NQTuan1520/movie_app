// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/like_post/entity/like_post_entity.dart';

part 'like_post_request.g.dart';

@JsonSerializable(explicitToJson: true)
class LikePostRequest extends LikePostEntity {
  @override
  @JsonKey(name: 'postId')
  final String? idPost;

  @override
  @JsonKey(name: 'uid')
  final String? idUser;

  const LikePostRequest({
    this.idPost,
    this.idUser,
  });

  factory LikePostRequest.fromJson(Map<String, dynamic> json) => _$LikePostRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LikePostRequestToJson(this);
}
