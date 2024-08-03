// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/shared/entity/shared_entity.dart';

part 'shared_response.g.dart';

@JsonSerializable(explicitToJson: true)
class SharedResponse extends SharedEntity {
  @override
  @JsonKey(name: 'id_movie')
  final int? idMovie;

  @override
  @JsonKey(name: 'title_shared')
  final String? titleShared;

  const SharedResponse(
      {super.id,
      super.uid,
      super.title,
      super.posterPath,
      this.idMovie,
      this.titleShared,
      super.email,
      super.avatar,
      super.like,
      super.username,
      super.isLike});

  factory SharedResponse.fromJson(Map<String, dynamic> json) => _$SharedResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SharedResponseToJson(this);

  @override
  List<Object?> get props => [id, uid, title, posterPath, idMovie, titleShared, email, avatar, like, isLike, username];
}
