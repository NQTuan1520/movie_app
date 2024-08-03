import 'package:equatable/equatable.dart';

import '../../../../domain/tv_show_detail/enitty/tv_detail_entity.dart';
import '../../../../manager/enum/status_enum.dart';

class DetailTvState extends Equatable {
  final Status? status;
  final TVDetailEntity? tvDetailEntity;
  final String? message;

  const DetailTvState({
    this.status,
    this.tvDetailEntity,
    this.message,
  });

  @override
  List<Object?> get props => [status, tvDetailEntity, message];

  DetailTvState copyWith({
    Status? status,
    TVDetailEntity? tvDetailEntity,
    String? message,
  }) {
    return DetailTvState(
      status: status ?? this.status,
      tvDetailEntity: tvDetailEntity ?? this.tvDetailEntity,
      message: message ?? this.message,
    );
  }
}
