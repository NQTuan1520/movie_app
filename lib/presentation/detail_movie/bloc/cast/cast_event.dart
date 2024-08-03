import 'package:equatable/equatable.dart';

class CastEvent extends Equatable {
  const CastEvent();

  @override
  List<Object?> get props => [];
}

class GetCastDetailOfMovieEvent extends CastEvent {
  final int id;

  const GetCastDetailOfMovieEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
