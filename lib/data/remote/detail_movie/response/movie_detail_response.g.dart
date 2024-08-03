// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDetailResponse _$MovieDetailResponseFromJson(Map<String, dynamic> json) =>
    MovieDetailResponse(
      adult: json['adult'] as bool?,
      backdropPath: json['backdrop_path'] as String?,
      imdbId: json['imdb_id'] as String?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      posterPath: json['poster_path'] as String?,
      productionCompanies: (json['production_companies'] as List<dynamic>?)
              ?.map((e) => ProductionCompaniesResponse.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
      releaseDate: json['release_date'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => GenresResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      budget: (json['budget'] as num?)?.toInt(),
      homepage: json['homepage'] as String?,
      id: (json['id'] as num?)?.toInt(),
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      productionCountries: (json['productionCountries'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      revenue: (json['revenue'] as num?)?.toInt(),
      runtime: (json['runtime'] as num?)?.toInt(),
      spokenLanguages: (json['spokenLanguages'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      status: json['status'] as String?,
      tagline: json['tagline'] as String?,
      title: json['title'] as String?,
      video: json['video'] as bool?,
    );

Map<String, dynamic> _$MovieDetailResponseToJson(
        MovieDetailResponse instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'budget': instance.budget,
      'homepage': instance.homepage,
      'id': instance.id,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'productionCountries': instance.productionCountries,
      'revenue': instance.revenue,
      'runtime': instance.runtime,
      'spokenLanguages': instance.spokenLanguages,
      'status': instance.status,
      'tagline': instance.tagline,
      'title': instance.title,
      'video': instance.video,
      'backdrop_path': instance.backdropPath,
      'imdb_id': instance.imdbId,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'poster_path': instance.posterPath,
      'production_companies':
          instance.productionCompanies.map((e) => e.toJson()).toList(),
      'release_date': instance.releaseDate,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'genres': instance.genres?.map((e) => e.toJson()).toList(),
    };

GenresResponse _$GenresResponseFromJson(Map<String, dynamic> json) =>
    GenresResponse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$GenresResponseToJson(GenresResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

ProductionCompaniesResponse _$ProductionCompaniesResponseFromJson(
        Map<String, dynamic> json) =>
    ProductionCompaniesResponse(
      id: (json['id'] as num?)?.toInt(),
      logoPath: json['logo_path'] as String?,
      originCountry: json['origin_country'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$ProductionCompaniesResponseToJson(
        ProductionCompaniesResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'origin_country': instance.originCountry,
      'logo_path': instance.logoPath,
    };
