import 'package:equatable/equatable.dart';

import '../../../../domain/tv_show/entity/tv_show_entity.dart';
import '../../../../manager/enum/status_enum.dart';

class SimilarTvShowState extends Equatable {
  final Status? status;
  final String? message;
  final List<TVShowEntity>? tvShows;
  const SimilarTvShowState({
    this.status = Status.initial,
    this.message = "",
    this.tvShows,
  });

  @override
  List<Object?> get props => [status, message, tvShows];

  SimilarTvShowState copyWith({
    Status? status,
    String? message,
    List<TVShowEntity>? tvShows,
  }) {
    return SimilarTvShowState(
      status: status ?? this.status,
      message: message ?? this.message,
      tvShows: tvShows ?? this.tvShows,
    );
  }
}
