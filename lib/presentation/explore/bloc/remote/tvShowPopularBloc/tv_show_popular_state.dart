import 'package:equatable/equatable.dart';

import '../../../../../domain/tv_show/entity/tv_show_entity.dart';
import '../../../../../manager/enum/status_enum.dart';

class TvShowPopularState extends Equatable {
  final Status? status;
  final String? messageError;
  final List<TVShowEntity>? tvShowListPopular;
  const TvShowPopularState({
    this.status = Status.initial,
    this.messageError = '',
    this.tvShowListPopular = const [],
  });

  @override
  List<Object?> get props => [status, messageError, tvShowListPopular];

  TvShowPopularState copyWith({
    Status? status,
    String? messageError,
    List<TVShowEntity>? tvShowListPopular,
  }) {
    return TvShowPopularState(
      status: status ?? this.status,
      messageError: messageError ?? this.messageError,
      tvShowListPopular: tvShowListPopular ?? this.tvShowListPopular,
    );
  }
}
