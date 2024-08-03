// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_person_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailPersonResponse _$DetailPersonResponseFromJson(
        Map<String, dynamic> json) =>
    DetailPersonResponse(
      adult: json['adult'] as bool?,
      alsoKnownAs: (json['also_known_as'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      biography: json['biography'] as String?,
      birthday: json['birthday'] as String?,
      deathday: json['deathday'] as String?,
      gender: (json['gender'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      homepage: json['homepage'] as String?,
      knownForDepartment: json['known_for_department'] as String?,
      placeOfBirth: json['place_of_birth'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      imdbId: json['imdbId'] as String?,
      profilePath: json['profile_path'] as String?,
    );

Map<String, dynamic> _$DetailPersonResponseToJson(
        DetailPersonResponse instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'biography': instance.biography,
      'birthday': instance.birthday,
      'deathday': instance.deathday,
      'gender': instance.gender,
      'homepage': instance.homepage,
      'id': instance.id,
      'imdbId': instance.imdbId,
      'name': instance.name,
      'popularity': instance.popularity,
      'also_known_as': instance.alsoKnownAs,
      'known_for_department': instance.knownForDepartment,
      'place_of_birth': instance.placeOfBirth,
      'profile_path': instance.profilePath,
    };
