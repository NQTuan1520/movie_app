import 'package:equatable/equatable.dart';

import '../../../../../domain/movie/entity/movie_entity.dart';
import '../../../../../manager/enum/status_enum.dart';

class SearchMovieState extends Equatable {
  final Status status;
  final List<MovieEntity> movies;
  final bool isAdult;
  final String primaryReleaseYear;
  final String region;
  final String message;

  const SearchMovieState({
    this.status = Status.initial,
    this.movies = const [],
    this.isAdult = false,
    this.primaryReleaseYear = '2022',
    this.region = 'US',
    this.message = '',
  });

  SearchMovieState copyWith({
    Status? status,
    List<MovieEntity>? movies,
    bool? isAdult,
    String? primaryReleaseYear,
    String? region,
    String? message,
  }) {
    return SearchMovieState(
      status: status ?? this.status,
      movies: movies ?? this.movies,
      isAdult: isAdult ?? this.isAdult,
      primaryReleaseYear: primaryReleaseYear ?? this.primaryReleaseYear,
      region: region ?? this.region,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, movies, isAdult, primaryReleaseYear, region, message];
}
