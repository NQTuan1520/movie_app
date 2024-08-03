// ignore_for_file: overridden_fields, must_be_immutable

import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/detail_movie/entity/movie_detail_entity.dart';

part 'movie_detail_response.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieDetailResponse extends MovieDetailEntity {
  @override
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @override
  @JsonKey(name: 'imdb_id')
  final String? imdbId;

  @override
  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  @override
  @JsonKey(name: 'original_title')
  final String? originalTitle;

  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @override
  @JsonKey(name: 'production_companies')
  final List<ProductionCompaniesResponse> productionCompanies;

  @override
  @JsonKey(name: "release_date")
  final String? releaseDate;

  @override
  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @override
  @JsonKey(name: 'vote_count')
  final int? voteCount;

  @override
  @JsonKey(name: 'genres')
  List<GenresResponse>? genres;

  MovieDetailResponse({
    super.adult,
    this.backdropPath,
    this.imdbId,
    this.originalLanguage,
    this.originalTitle,
    this.posterPath,
    this.productionCompanies = const [],
    this.releaseDate,
    this.voteAverage,
    this.voteCount,
    this.genres,
    super.budget,
    super.homepage,
    super.id,
    super.overview,
    super.popularity,
    super.productionCountries,
    super.revenue,
    super.runtime,
    super.spokenLanguages,
    super.status,
    super.tagline,
    super.title,
    super.video,
  });

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) => _$MovieDetailResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class GenresResponse extends Genre {
  const GenresResponse({super.id, super.name});

  factory GenresResponse.fromJson(Map<String, dynamic> json) => _$GenresResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenresResponseToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ProductionCompaniesResponse extends ProductionCompany {
  @override
  @JsonKey(name: 'origin_country')
  final String? originCountry;

  @override
  @JsonKey(name: 'logo_path')
  final String? logoPath;

  const ProductionCompaniesResponse({
    super.id,
    this.logoPath,
    this.originCountry,
    super.name,
  });

  factory ProductionCompaniesResponse.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompaniesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompaniesResponseToJson(this);
}
