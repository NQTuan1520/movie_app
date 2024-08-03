// ignore_for_file: override_on_non_overriding_member, overridden_fields

import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/people/entity/actor_entity.dart';

part 'actor_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ActorResponse extends ActorEntity {
  @override
  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;

  @override
  @JsonKey(name: 'original_name')
  final String? originalName;

  @override
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  const ActorResponse({
    this.knownForDepartment,
    super.adult,
    super.gender,
    super.id,
    super.name,
    this.originalName,
    super.popularity,
    this.profilePath,
  }) : super(
          profilePath: profilePath,
        );

  factory ActorResponse.fromJson(Map<String, dynamic> json) => _$ActorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ActorResponseToJson(this);
}
