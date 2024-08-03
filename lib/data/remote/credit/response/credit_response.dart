// ignore_for_file: override_on_non_overriding_member, overridden_fields, must_be_immutable

import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/creadit/entity/credit_entity.dart';

part 'credit_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CreditResponse extends CreditEntity {
  @override
  @JsonKey(name: 'credit_type')
  final String? creditEntityType;

  @override
  @JsonKey(name: 'media_type')
  String? mediaType;

  @override
  @JsonKey(name: 'person')
  PersonResponse? person;

  @override
  @JsonKey(name: 'media', fromJson: _fromJsonMedia, toJson: _toJsonMedia)
  List<MediaResponse>? media;

  CreditResponse({
    this.creditEntityType,
    super.department,
    super.job,
    this.media,
    this.mediaType,
    super.id,
    this.person,
  });

  factory CreditResponse.fromJson(Map<String, dynamic> json) => _$CreditResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CreditResponseToJson(this);

  static List<MediaResponse>? _fromJsonMedia(dynamic json) {
    if (json is List) {
      return json.map((e) => MediaResponse.fromJson(e as Map<String, dynamic>)).toList();
    } else if (json is Map) {
      return [MediaResponse.fromJson(json as Map<String, dynamic>)];
    } else {
      return null;
    }
  }

  static dynamic _toJsonMedia(List<MediaResponse>? media) {
    if (media == null || media.isEmpty) {
      return null;
    } else if (media.length == 1) {
      return media[0].toJson();
    } else {
      return media.map((e) => e.toJson()).toList();
    }
  }
}

@JsonSerializable(explicitToJson: true)
class PersonResponse extends Person {
  @override
  @JsonKey(name: 'original_name')
  final String? originalName;

  @override
  @JsonKey(name: 'media_type')
  final String? mediaType;

  @override
  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;

  @override
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  const PersonResponse({
    super.adult,
    super.id,
    super.name,
    this.originalName,
    this.mediaType,
    super.popularity,
    super.gender,
    this.knownForDepartment,
    this.profilePath,
  });

  factory PersonResponse.fromJson(Map<String, dynamic> json) => _$PersonResponseFromJson(json);
  Map<String, dynamic> toJson() => _$PersonResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SeasonResponse extends Season {
  @override
  @JsonKey(name: 'air_date')
  final String? airDate;

  @override
  @JsonKey(name: 'episode_count')
  final int? episodeCount;

  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @override
  @JsonKey(name: 'season_number')
  final int? seasonNumber;

  @override
  @JsonKey(name: 'show_id')
  final int? showId;

  const SeasonResponse({
    this.airDate,
    this.episodeCount,
    super.id,
    super.name,
    super.overview,
    this.posterPath,
    this.seasonNumber,
    this.showId,
  });

  factory SeasonResponse.fromJson(Map<String, dynamic> json) => _$SeasonResponseFromJson(json);
  Map<String, dynamic> toJson() => _$SeasonResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class MediaResponse extends Media {
  @override
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @override
  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @override
  @JsonKey(name: 'release_date')
  final String? firstAirDate;

  @override
  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @override
  @JsonKey(name: 'vote_count')
  final int? voteCount;

  @override
  @JsonKey(name: 'seasons')
  List<SeasonResponse>? seasons;
  @override
  @JsonKey(name: 'title')
  final String? originalName;

  @override
  @JsonKey(name: 'media_type')
  final String? mediaType;

  @override
  @JsonKey(name: 'known_for_department')
  final String? knownForDepartment;

  @override
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  MediaResponse({
    super.adult,
    this.backdropPath,
    super.id,
    super.name,
    this.originalLanguage,
    this.originalName,
    super.overview,
    this.posterPath,
    this.mediaType,
    super.popularity,
    this.firstAirDate,
    this.voteCount,
    this.voteAverage,
    super.character,
    super.episodes,
    this.seasons,
    this.knownForDepartment,
    this.profilePath,
  });

  factory MediaResponse.fromJson(Map<String, dynamic> json) => _$MediaResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MediaResponseToJson(this);
}
