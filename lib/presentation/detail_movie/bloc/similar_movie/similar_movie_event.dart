import 'package:equatable/equatable.dart';

class SimilarMovieEvent extends Equatable {
  const SimilarMovieEvent();

  @override

  List<Object?> get props => [];
}

class GetSimilarMovieListEvent extends SimilarMovieEvent {
  final int id;

  const GetSimilarMovieListEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class NavigatorActionPopEvent extends SimilarMovieEvent {
  const NavigatorActionPopEvent();
}
