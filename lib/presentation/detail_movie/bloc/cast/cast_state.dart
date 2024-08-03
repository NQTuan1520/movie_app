import 'package:equatable/equatable.dart';

import '../../../../domain/cast/entity/cast_entity.dart';
import '../../../../manager/enum/status_enum.dart';

class CastState extends Equatable {
  final Status status;
  final List<CastEntity> casts;
  final String messageError;

  const CastState({
    this.status = Status.initial,
    this.casts = const [],
    this.messageError = '',
  });

  CastState copyWith({
    Status? status,
    List<CastEntity>? casts,
    String? messageError,
  }) {
    return CastState(
      status: status ?? this.status,
      casts: casts ?? this.casts,
      messageError: messageError ?? this.messageError,
    );
  }

  @override
  List<Object?> get props => [status, casts, messageError];
}
