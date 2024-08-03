import 'package:equatable/equatable.dart';

import '../../../../domain/cast/entity/cast_entity.dart';
import '../../../../manager/enum/status_enum.dart';

class CastTvState extends Equatable {
  final Status? status;
  final String? message;
  final List<CastEntity>? cast;

  const CastTvState({
    this.status = Status.initial,
    this.message = "",
    this.cast = const [],
  });

  @override
  List<Object> get props => [
        status!,
        message!,
        cast!,
      ];

  //copy with
  CastTvState copyWith({
    Status? status,
    String? message,
    List<CastEntity>? cast,
  }) {
    return CastTvState(
      status: status ?? this.status,
      message: message ?? this.message,
      cast: cast ?? this.cast,
    );
  }
}
