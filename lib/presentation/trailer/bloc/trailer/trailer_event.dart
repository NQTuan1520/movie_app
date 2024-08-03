import 'package:equatable/equatable.dart';

class TrailerEvent extends Equatable {
  const TrailerEvent();

  @override

  List<Object?> get props => [];
}

class GetTrailerEvent extends TrailerEvent {
  final int movieId;
  const GetTrailerEvent({required this.movieId});

  @override
  List<Object?> get props => [movieId];
}

class UpdateTrailerTypeEvent extends TrailerEvent {
  final String trailerType;
  const UpdateTrailerTypeEvent({required this.trailerType});

  @override
  List<Object?> get props => [trailerType];
}

class UpdateControllerReadyEvent extends TrailerEvent {
  final bool isControllerReady;
  const UpdateControllerReadyEvent({required this.isControllerReady});

  @override
  List<Object?> get props => [isControllerReady];
}
