import 'package:equatable/equatable.dart';
import 'package:tuannq_movie/domain/favourite/entity/user_favourite_entity.dart';

class FavouriteEvent extends Equatable {
  const FavouriteEvent();

  @override
  List<Object?> get props => [];
}

class ResetFavourite extends FavouriteEvent {}

class AddFavourite extends FavouriteEvent {
  final String userId;
  final UserFavouriteEntity movie;

  const AddFavourite(this.userId, this.movie);
}

class GetFavourites extends FavouriteEvent {
  final String userId;

  const GetFavourites(this.userId);
}

class RemoveFavourite extends FavouriteEvent {
  final String userId;
  final int movieId;

  const RemoveFavourite(this.userId, this.movieId);
}
