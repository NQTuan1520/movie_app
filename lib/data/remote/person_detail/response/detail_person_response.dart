// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/detail_people/entity/detail_person_entity.dart';

part 'detail_person_response.g.dart';

@JsonSerializable(explicitToJson: true)
class DetailPersonResponse extends PersonDetail {
  @override
  @JsonKey(name: 'also_known_as')
  final List<String>? alsoKnownAs;

  @override
  @JsonKey(name: "known_for_department")
  final String? knownForDepartment;

  @override
  @JsonKey(name: "place_of_birth")
  final String? placeOfBirth;

  @override
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  const DetailPersonResponse({
    super.adult,
    this.alsoKnownAs,
    super.biography,
    super.birthday,
    super.deathday,
    super.gender,
    super.id,
    super.name,
    super.homepage,
    this.knownForDepartment,
    this.placeOfBirth,
    super.popularity,
    super.imdbId,
    this.profilePath,
  });
  factory DetailPersonResponse.fromJson(Map<String, dynamic> json) => _$DetailPersonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DetailPersonResponseToJson(this);

  @override
  List<Object?> get props => [
        alsoKnownAs,
        knownForDepartment,
        placeOfBirth,
        profilePath,
      ];
}
