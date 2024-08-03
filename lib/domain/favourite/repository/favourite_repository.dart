import '../entity/user_favourite_entity.dart';

abstract class FavouriteRepository {
  Future<void> addFavourite(UserFavouriteEntity favourite, String userId);

  Future<void> removeFavourite(String userId, int movieId);

  Future<List<UserFavouriteEntity>> getFavourites(String uid);
}
