import 'package:equatable/equatable.dart';
import 'package:tuannq_movie/domain/trailer/entity/trailer_entity.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';

class TrailerState extends Equatable {
  final Status status;
  final List<TrailerEntity>? trailers;
  final String? message;
  final String currentTrailerType;
  final bool isControllerReady;

  const TrailerState({
    this.status = Status.initial,
    this.trailers,
    this.message,
    this.currentTrailerType = 'Teaser',
    this.isControllerReady = false,
  });

  @override
  List<Object?> get props => [status, trailers, message, currentTrailerType, isControllerReady];

  TrailerState copyWith({
    Status? status,
    List<TrailerEntity>? trailers,
    String? message,
    String? currentTrailerType,
    bool? isControllerReady,
  }) {
    return TrailerState(
      status: status ?? this.status,
      trailers: trailers ?? this.trailers,
      message: message ?? this.message,
      currentTrailerType: currentTrailerType ?? this.currentTrailerType,
      isControllerReady: isControllerReady ?? this.isControllerReady,
    );
  }
}
