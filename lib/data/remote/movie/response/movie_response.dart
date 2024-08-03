// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/movie/entity/movie_entity.dart';
import 'genres_response.dart';

part 'movie_response.g.dart';

@JsonSerializable(explicitToJson: true)
class MovieResponse extends MovieEntity {
  @override
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;

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
  @JsonKey(name: 'release_date')
  final String? releaseDate;

  @override
  @JsonKey(name: 'vote_average')
  final double? voteAverage;

  @override
  @JsonKey(name: 'vote_count')
  final int? voteCount;

  @override
  @JsonKey(name: 'genres')
  final GenresResponse? genres;

  @override
  @JsonKey(name: 'genre_ids')
  final List<int>? genreIds;
  const MovieResponse({
    super.adult,
    this.backdropPath,
    super.id,
    this.originalLanguage,
    this.originalTitle,
    super.overview,
    super.popularity,
    this.posterPath,
    this.releaseDate,
    this.genreIds,
    super.title,
    super.video,
    this.voteAverage,
    this.voteCount,
    this.genres,
  });

  factory MovieResponse.fromJson(Map<String, dynamic> json) => _$MovieResponseFromJson(json);
  Map<String, dynamic> toJson() => _$MovieResponseToJson(this);

  factory MovieResponse.fromEntity(MovieEntity entity) {
    return MovieResponse(
      adult: entity.adult,
      backdropPath: entity.backdropPath,
      id: entity.id,
      originalLanguage: entity.originalLanguage,
      originalTitle: entity.originalTitle,
      overview: entity.overview,
      popularity: entity.popularity,
      posterPath: entity.posterPath,
      releaseDate: entity.releaseDate,
      title: entity.title,
      video: entity.video,
      voteAverage: entity.voteAverage,
      voteCount: entity.voteCount,
      genres: entity.genres != null ? GenresResponse.fromEntity(entity.genres!) : null,
    );
  }

  MovieEntity toEntity() {
    return MovieEntity(
      adult: adult,
      backdropPath: backdropPath,
      id: id,
      originalLanguage: originalLanguage,
      originalTitle: originalTitle,
      overview: overview,
      popularity: popularity,
      posterPath: posterPath,
      releaseDate: releaseDate,
      title: title,
      video: video,
      voteAverage: voteAverage,
      voteCount: voteCount,
    );
  }
}
