// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/cast/entity/cast_entity.dart';

part 'cast_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CastResponse extends CastEntity {
  @override
  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;

  @override
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  @override
  @JsonKey(name: 'original_name')
  final String? originalName;

  @override
  @JsonKey(name: 'cast_id')
  final int? castId;

  @override
  @JsonKey(name: 'credit_id')
  final String? creditId;

  const CastResponse({
    super.adult,
    super.gender,
    super.id,
    this.knownForDepartment,
    super.name,
    this.originalName,
    super.popularity,
    this.profilePath,
    this.castId,
    super.character,
    this.creditId,
    super.order,
  });

  factory CastResponse.fromJson(Map<String, dynamic> json) => _$CastResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CastResponseToJson(this);
}
