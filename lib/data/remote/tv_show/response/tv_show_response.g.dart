// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv_show_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TVShowResponse _$TVShowResponseFromJson(Map<String, dynamic> json) =>
    TVShowResponse(
      backdropPath: json['backdrop_path'] as String?,
      firstAirDate: json['first_air_date'] as String?,
      genreIds: (json['genreIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      originCountry: (json['originCountry'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      originalLanguage: json['original_language'] as String?,
      originalName: json['original_name'] as String?,
      overview: json['overview'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$TVShowResponseToJson(TVShowResponse instance) =>
    <String, dynamic>{
      'genreIds': instance.genreIds,
      'id': instance.id,
      'name': instance.name,
      'originCountry': instance.originCountry,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'backdrop_path': instance.backdropPath,
      'first_air_date': instance.firstAirDate,
      'original_language': instance.originalLanguage,
      'original_name': instance.originalName,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };
