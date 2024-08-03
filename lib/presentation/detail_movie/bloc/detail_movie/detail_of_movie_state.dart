import 'package:equatable/equatable.dart';

import '../../../../domain/detail_movie/entity/movie_detail_entity.dart';
import '../../../../manager/enum/status_enum.dart';

class DetailOfMovieState extends Equatable {
  final Status? status;
  final String? errorMessage;
  final MovieDetailEntity movieDetail;

  const DetailOfMovieState({
    this.status = Status.initial,
    this.errorMessage = '',
    this.movieDetail = const MovieDetailEntity(),
  });

  @override
  List<Object?> get props => [status, errorMessage, movieDetail];

  //copy with
  DetailOfMovieState copyWith({
    Status? status,
    String? errorMessage,
    MovieDetailEntity? movieDetail,
  }) {
    return DetailOfMovieState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      movieDetail: movieDetail ?? this.movieDetail,
    );
  }
}
