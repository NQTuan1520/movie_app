// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreditResponse _$CreditResponseFromJson(Map<String, dynamic> json) =>
    CreditResponse(
      creditEntityType: json['credit_type'] as String?,
      department: json['department'] as String?,
      job: json['job'] as String?,
      media: CreditResponse._fromJsonMedia(json['media']),
      mediaType: json['media_type'] as String?,
      id: json['id'] as String?,
      person: json['person'] == null
          ? null
          : PersonResponse.fromJson(json['person'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreditResponseToJson(CreditResponse instance) =>
    <String, dynamic>{
      'department': instance.department,
      'job': instance.job,
      'id': instance.id,
      'credit_type': instance.creditEntityType,
      'media_type': instance.mediaType,
      'person': instance.person?.toJson(),
      'media': CreditResponse._toJsonMedia(instance.media),
    };

PersonResponse _$PersonResponseFromJson(Map<String, dynamic> json) =>
    PersonResponse(
      adult: json['adult'] as bool?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      originalName: json['original_name'] as String?,
      mediaType: json['media_type'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      gender: (json['gender'] as num?)?.toInt(),
      knownForDepartment: json['known_for_department'] as String?,
      profilePath: json['profile_path'] as String?,
    );

Map<String, dynamic> _$PersonResponseToJson(PersonResponse instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'id': instance.id,
      'name': instance.name,
      'popularity': instance.popularity,
      'gender': instance.gender,
      'original_name': instance.originalName,
      'media_type': instance.mediaType,
      'known_for_department': instance.knownForDepartment,
      'profile_path': instance.profilePath,
    };

SeasonResponse _$SeasonResponseFromJson(Map<String, dynamic> json) =>
    SeasonResponse(
      airDate: json['air_date'] as String?,
      episodeCount: (json['episode_count'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      seasonNumber: (json['season_number'] as num?)?.toInt(),
      showId: (json['show_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SeasonResponseToJson(SeasonResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'air_date': instance.airDate,
      'episode_count': instance.episodeCount,
      'poster_path': instance.posterPath,
      'season_number': instance.seasonNumber,
      'show_id': instance.showId,
    };

MediaResponse _$MediaResponseFromJson(Map<String, dynamic> json) =>
    MediaResponse(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      originalLanguage: json['original_language'] as String?,
      originalName: json['title'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      mediaType: json['media_type'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      firstAirDate: json['release_date'] as String?,
      voteCount: (json['vote_count'] as num?)?.toInt(),
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      character: json['character'] as String?,
      episodes: json['episodes'] as List<dynamic>?,
      seasons: (json['seasons'] as List<dynamic>?)
          ?.map((e) => SeasonResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      knownForDepartment: json['known_for_department'] as String?,
      profilePath: json['profile_path'] as String?,
    );

Map<String, dynamic> _$MediaResponseToJson(MediaResponse instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'id': instance.id,
      'name': instance.name,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'character': instance.character,
      'episodes': instance.episodes,
      'backdrop_path': instance.backdropPath,
      'original_language': instance.originalLanguage,
      'poster_path': instance.posterPath,
      'release_date': instance.firstAirDate,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'seasons': instance.seasons?.map((e) => e.toJson()).toList(),
      'title': instance.originalName,
      'media_type': instance.mediaType,
      'known_for_department': instance.knownForDepartment,
      'profile_path': instance.profilePath,
    };
