import 'package:equatable/equatable.dart';

import '../../../../domain/movie/entity/movie_entity.dart';
import '../../../../manager/enum/status_enum.dart';

class SimilarMovieState extends Equatable {
  final Status? status;
  final List<MovieEntity>? listMovie;
  final String? message;

  const SimilarMovieState({
    this.status = Status.initial,
    this.listMovie = const [],
    this.message,
  });

  @override
  List<Object?> get props => [status, listMovie, message];

  SimilarMovieState copyWith({
    Status? status,
    List<MovieEntity>? listMovie,
    String? message,
  }) {
    return SimilarMovieState(
      status: status ?? this.status,
      listMovie: listMovie ?? this.listMovie,
      message: message ?? this.message,
    );
  }
}
