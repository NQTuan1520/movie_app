import '../../../core/resource/api/api_exception.dart';
import '../entity/user_favourite_entity.dart';
import '../repository/favourite_repository.dart';

class FavouriteUseCase {
  final FavouriteRepository _favouriteRepository;

  FavouriteUseCase(this._favouriteRepository);

  Future<void> addFavouriteUseCase(UserFavouriteEntity favourite, String uid) async {
    try {
      return await _favouriteRepository.addFavourite(favourite, uid);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<void> deleteFavouriteUseCase(String uid, int idMovie) async {
    try {
      return _favouriteRepository.removeFavourite(uid, idMovie);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<List<UserFavouriteEntity>> getFavouriteUseCase(String id) async {
    return await _favouriteRepository.getFavourites(id);
  }
}
