// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/tv_show_detail/enitty/tv_detail_entity.dart';

part 'tv_detail_response.g.dart';

@JsonSerializable(explicitToJson: true)
class CreatorResponse extends Creator {
  @override
  @JsonKey(name: 'credit_id')
  final String? creditId;

  @override
  @JsonKey(name: 'profile_path')
  final String? profilePath;

  const CreatorResponse({
    super.id,
    this.creditId,
    super.name,
    super.gender,
    this.profilePath,
  });

  factory CreatorResponse.fromJson(Map<String, dynamic> json) => _$CreatorResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CreatorResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GenreResponse extends Genre {
  const GenreResponse({
    super.id,
    super.name,
  });

  factory GenreResponse.fromJson(Map<String, dynamic> json) => _$GenreResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenreResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class NetworkResponse extends Network {
  @override
  @JsonKey(name: 'logo_path')
  final String? logoPath;

  @override
  @JsonKey(name: 'origin_country')
  final String? originCountry;

  const NetworkResponse({
    super.id,
    super.name,
    this.logoPath,
    this.originCountry,
  });

  factory NetworkResponse.fromJson(Map<String, dynamic> json) => _$NetworkResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NetworkResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductionCompanyResponse extends ProductionCompany {
  @override
  @JsonKey(name: 'logo_path')
  final String? logoPath;

  @override
  @JsonKey(name: 'origin_country')
  final String? originCountry;

  const ProductionCompanyResponse({
    super.id,
    super.name,
    this.logoPath,
    this.originCountry,
  });

  factory ProductionCompanyResponse.fromJson(Map<String, dynamic> json) => _$ProductionCompanyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanyResponseToJson(this);
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
  @JsonKey(name: 'id')
  final int? id;

  @override
  @JsonKey(name: 'name')
  final String? name;

  @override
  @JsonKey(name: 'overview')
  final String? overview;

  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @override
  @JsonKey(name: 'season_number')
  final int? seasonNumber;

  const SeasonResponse({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
  });

  factory SeasonResponse.fromJson(Map<String, dynamic> json) => _$SeasonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SeasonResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class EpisodeResponse extends Episode {
  @override
  @JsonKey(name: 'air_date')
  final String? airDate;

  @override
  @JsonKey(name: 'episode_number')
  final int? episodeNumber;

  @override
  @JsonKey(name: 'id')
  final int? id;

  @override
  @JsonKey(name: 'name')
  final String? name;

  @override
  @JsonKey(name: 'overview')
  final String? overview;

  @override
  @JsonKey(name: 'production_code')
  final String? productionCode;

  @override
  @JsonKey(name: 'season_number')
  final int? seasonNumber;

  @override
  @JsonKey(name: 'still_path')
  final String? stillPath;

  @override
  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @override
  @JsonKey(name: 'vote_count')
  final int? voteCount;

  const EpisodeResponse({
    this.airDate,
    this.episodeNumber,
    this.id,
    this.name,
    this.overview,
    this.productionCode,
    this.seasonNumber,
    this.stillPath,
    super.runtime,
    super.showId,
    this.voteAverage,
    this.voteCount,
  });

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) => _$EpisodeResponseFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class SpokenLanguageResponse extends SpokenLanguage {
  @override
  @JsonKey(name: 'english_name')
  final String? englishName;

  @override
  @JsonKey(name: 'iso_639_1')
  final String? iso6391;

  const SpokenLanguageResponse({
    this.englishName,
    this.iso6391,
    super.name,
  });

  factory SpokenLanguageResponse.fromJson(Map<String, dynamic> json) => _$SpokenLanguageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class TVDetailResponse extends TVDetailEntity {
  @override
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @override
  @JsonKey(name: 'created_by')
  final List<CreatorResponse>? createdBy;

  @override
  @JsonKey(name: 'episode_run_time')
  final List<int>? episodeRunTime;

  @override
  @JsonKey(name: 'first_air_date')
  final String? firstAirDate;

  @override
  @JsonKey(name: 'genres')
  final List<GenreResponse>? genres;

  @override
  @JsonKey(name: 'homepage')
  final String? homepage;

  @override
  @JsonKey(name: 'id')
  final int? id;

  @override
  @JsonKey(name: 'in_production')
  final bool? inProduction;

  @override
  @JsonKey(name: 'languages')
  final List<String>? languages;

  @override
  @JsonKey(name: 'last_air_date')
  final String? lastAirDate;

  @override
  @JsonKey(name: 'last_episode_to_air')
  final EpisodeResponse? lastEpisodeToAir;

  @override
  @JsonKey(name: 'name')
  final String? name;

  @override
  @JsonKey(name: 'networks')
  final List<NetworkResponse>? networks;

  @override
  @JsonKey(name: 'number_of_episodes')
  final int? numberOfEpisodes;

  @override
  @JsonKey(name: 'number_of_seasons')
  final int? numberOfSeasons;

  @override
  @JsonKey(name: 'origin_country')
  final List<String>? originCountry;

  @override
  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  @override
  @JsonKey(name: 'original_name')
  final String? originalName;

  @override
  @JsonKey(name: 'overview')
  final String? overview;

  @override
  @JsonKey(name: 'popularity')
  final double? popularity;

  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @override
  @JsonKey(name: 'production_companies')
  final List<ProductionCompanyResponse>? productionCompanies;

  @override
  @JsonKey(name: 'seasons')
  final List<SeasonResponse>? seasons;

  @override
  @JsonKey(name: 'spoken_languages')
  final List<SpokenLanguageResponse>? spokenLanguages;

  @override
  @JsonKey(name: 'status')
  final String? status;

  @override
  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @override
  @JsonKey(name: 'vote_count')
  final int? voteCount;

  @override
  @JsonKey(name: 'next_episode_to_air')
  final EpisodeResponse? nextEpisodeToAir;

  const TVDetailResponse({
    super.adult,
    this.backdropPath,
    this.createdBy,
    this.episodeRunTime,
    this.firstAirDate,
    this.nextEpisodeToAir,
    this.genres,
    this.homepage,
    this.id,
    this.inProduction,
    this.languages,
    this.lastAirDate,
    this.lastEpisodeToAir,
    this.name,
    this.networks,
    this.numberOfEpisodes,
    this.numberOfSeasons,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.seasons,
    this.spokenLanguages,
    this.status,
    super.tagline,
    super.type,
    this.voteAverage,
    this.voteCount,
  });

  factory TVDetailResponse.fromJson(Map<String, dynamic> json) => _$TVDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TVDetailResponseToJson(this);
}
