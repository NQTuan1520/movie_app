// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/tv_show/entity/tv_show_entity.dart';

part 'tv_show_response.g.dart';

@JsonSerializable(explicitToJson: true)
class TVShowResponse extends TVShowEntity {
  @override
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

  @override
  @JsonKey(name: 'first_air_date')
  final String? firstAirDate;

  @override
  @JsonKey(name: 'original_language')
  final String? originalLanguage;

  @override
  @JsonKey(name: 'original_name')
  final String? originalName;

  @override
  @JsonKey(name: 'poster_path')
  final String? posterPath;

  @override
  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @override
  @JsonKey(name: 'vote_count')
  final int? voteCount;

  const TVShowResponse({
    this.backdropPath,
    this.firstAirDate,
    super.genreIds,
    super.id,
    super.name,
    super.originCountry,
    this.originalLanguage,
    this.originalName,
    super.overview,
    super.popularity,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
  });

  factory TVShowResponse.fromJson(Map<String, dynamic> json) => _$TVShowResponseFromJson(json);
  Map<String, dynamic> toJson() => _$TVShowResponseToJson(this);

  factory TVShowResponse.fromEntity(TVShowEntity entity) {
    return TVShowResponse(
      backdropPath: entity.backdropPath,
      firstAirDate: entity.firstAirDate,
      genreIds: entity.genreIds,
      id: entity.id,
      name: entity.name,
      originCountry: entity.originCountry,
      originalLanguage: entity.originalLanguage,
      originalName: entity.originalName,
      overview: entity.overview,
      popularity: entity.popularity,
      posterPath: entity.posterPath,
      voteAverage: entity.voteAverage,
      voteCount: entity.voteCount,
    );
  }
}
