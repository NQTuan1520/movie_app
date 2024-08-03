import 'package:equatable/equatable.dart';

class DetailOfMovieEvent extends Equatable {
  const DetailOfMovieEvent();

  @override

  List<Object?> get props => [];
}

class GetDetailOfMovieEvent extends DetailOfMovieEvent {
  final int movieId;

  const GetDetailOfMovieEvent({this.movieId = 0});

  @override
  List<Object?> get props => [movieId];
}
