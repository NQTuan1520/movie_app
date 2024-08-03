// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/review/entity/review_entity.dart';

part 'review_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ReviewResponse extends ReviewEntity {
  @override
  @JsonKey(name: 'author_details')
  final AuthorResponse? authorDetails;

  @override
  @JsonKey(name: 'created_at')
  final String? createdAt;

  @override
  @JsonKey(name: 'updated_at')
  final String? updatedAt;

  const ReviewResponse({
    super.author,
    this.authorDetails,
    super.content,
    this.createdAt,
    super.id,
    this.updatedAt,
    super.url,
  });

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => _$ReviewResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class AuthorResponse extends AuthorDetails {
  @override
  @JsonKey(name: 'avatar_path')
  final String? avatarPath;

  const AuthorResponse({
    super.name,
    super.username,
    this.avatarPath,
    super.rating,
  });

  factory AuthorResponse.fromJson(Map<String, dynamic> json) => _$AuthorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorResponseToJson(this);
}
