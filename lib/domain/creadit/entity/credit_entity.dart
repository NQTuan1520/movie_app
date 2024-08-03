import 'package:equatable/equatable.dart';

class Person extends Equatable {
  final bool? adult;
  final int? id;
  final String? name;
  final String? originalName;
  final String? mediaType;
  final double? popularity;
  final int? gender;
  final String? knownForDepartment;
  final String? profilePath;

  const Person({
    this.adult,
    this.id,
    this.name,
    this.originalName,
    this.mediaType,
    this.popularity,
    this.gender,
    this.knownForDepartment,
    this.profilePath,
  });

  @override
  List<Object?> get props => [
        adult,
        id,
        name,
        originalName,
        mediaType,
        popularity,
        gender,
        knownForDepartment,
        profilePath
      ];

  Person copyWith({
    bool? adult,
    int? id,
    String? name,
    String? originalName,
    String? mediaType,
    double? popularity,
    int? gender,
    String? knownForDepartment,
    String? profilePath,
  }) {
    return Person(
      adult: adult ?? this.adult,
      id: id ?? this.id,
      name: name ?? this.name,
      originalName: originalName ?? this.originalName,
      mediaType: mediaType ?? this.mediaType,
      popularity: popularity ?? this.popularity,
      gender: gender ?? this.gender,
      knownForDepartment: knownForDepartment ?? this.knownForDepartment,
      profilePath: profilePath ?? this.profilePath,
    );
  }
}

class Season extends Equatable {
  final String? airDate;
  final int? episodeCount;
  final int? id;
  final String? name;
  final String? overview;
  final String? posterPath;
  final int? seasonNumber;
  final int? showId;

  const Season({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.overview,
    this.posterPath,
    this.seasonNumber,
    this.showId,
  });

  @override
  List<Object?> get props =>
      [airDate, episodeCount, id, name, overview, posterPath, seasonNumber, showId];

  Season copyWith({
    String? airDate,
    int? episodeCount,
    int? id,
    String? name,
    String? overview,
    String? posterPath,
    int? seasonNumber,
    int? showId,
  }) {
    return Season(
      airDate: airDate ?? this.airDate,
      episodeCount: episodeCount ?? this.episodeCount,
      id: id ?? this.id,
      name: name ?? this.name,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      seasonNumber: seasonNumber ?? this.seasonNumber,
      showId: showId ?? this.showId,
    );
  }
}

class Media extends Equatable {
  final bool? adult;
  final String? backdropPath;
  final int? id;
  final String? name;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final String? posterPath;
  final String? mediaType;
  final List<int>? genreIds;
  final double? popularity;
  final String? firstAirDate;
  final double? voteAverage;
  final int? voteCount;
  final List<String>? originCountry;
  final String? character;
  final List<dynamic>? episodes;
  final List<Season>? seasons;

  const Media({
    this.adult,
    this.backdropPath,
    this.id,
    this.name,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.posterPath,
    this.mediaType,
    this.genreIds,
    this.popularity,
    this.firstAirDate,
    this.voteAverage,
    this.voteCount,
    this.originCountry,
    this.character,
    this.episodes,
    this.seasons,
  });

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        id,
        name,
        originalLanguage,
        originalName,
        overview,
        posterPath,
        mediaType,
        genreIds,
        popularity,
        firstAirDate,
        voteAverage,
        voteCount,
        originCountry,
        character,
        episodes,
        seasons
      ];

  Media copyWith({
    bool? adult,
    String? backdropPath,
    int? id,
    String? name,
    String? originalLanguage,
    String? originalName,
    String? overview,
    String? posterPath,
    String? mediaType,
    List<int>? genreIds,
    double? popularity,
    String? firstAirDate,
    double? voteAverage,
    int? voteCount,
    List<String>? originCountry,
    String? character,
    List<dynamic>? episodes,
    List<Season>? seasons,
  }) {
    return Media(
      adult: adult ?? this.adult,
      backdropPath: backdropPath ?? this.backdropPath,
      id: id ?? this.id,
      name: name ?? this.name,
      originalLanguage: originalLanguage ?? this.originalLanguage,
      originalName: originalName ?? this.originalName,
      overview: overview ?? this.overview,
      posterPath: posterPath ?? this.posterPath,
      mediaType: mediaType ?? this.mediaType,
      genreIds: genreIds ?? this.genreIds,
      popularity: popularity ?? this.popularity,
      firstAirDate: firstAirDate ?? this.firstAirDate,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      originCountry: originCountry ?? this.originCountry,
      character: character ?? this.character,
      episodes: episodes ?? this.episodes,
      seasons: seasons ?? this.seasons,
    );
  }
}

class CreditEntity extends Equatable {
  final String? creditEntityType;
  final String? department;
  final String? job;
  final List<Media>? media;
  final String? mediaType;
  final String? id;
  final Person? person;
  final List<Season>? season;

  const CreditEntity({
    this.creditEntityType,
    this.department,
    this.season,
    this.job,
    this.media,
    this.mediaType,
    this.id,
    this.person,
  });

  @override
  List<Object?> get props => [creditEntityType, department, job, media, mediaType, id, person];

  CreditEntity copyWith({
    String? creditEntityType,
    String? department,
    String? job,
    List<Media>? media,
    List<Season>? season,
    String? mediaType,
    String? id,
    Person? person,
  }) {
    return CreditEntity(
      creditEntityType: creditEntityType ?? this.creditEntityType,
      department: department ?? this.department,
      season: season ?? this.season,
      job: job ?? this.job,
      media: media ?? this.media,
      mediaType: mediaType ?? this.mediaType,
      id: id ?? this.id,
      person: person ?? this.person,
    );
  }
}
