import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/favourite/entity/user_favourite_entity.dart';
import '../../../domain/favourite/repository/favourite_repository.dart';

class FavouriteRepositoryImpl extends FavouriteRepository {
  final FirebaseFirestore firestore;

  FavouriteRepositoryImpl({required this.firestore});

  @override
  Future<void> addFavourite(UserFavouriteEntity favourite, String userId) async {
    try {
      final docRef = firestore.collection('users').doc(userId).collection('favourites').doc('${favourite.id}');

      final favouriteRef = {
        'id': favourite.id,
        'title': favourite.title,
        'posterPath': favourite.posterPath,
      };

      await docRef.set(favouriteRef);
    } catch (e) {
      throw Exception('Error adding favourite: $e');
    }
  }

  @override
  Future<List<UserFavouriteEntity>> getFavourites(String uid) async {
    try {
      final querySnapshot = await firestore.collection('users').doc(uid).collection('favourites').get();
      return querySnapshot.docs.map((doc) => UserFavouriteEntity.fromJson(doc.data())).toList();
    } catch (e) {
      throw Exception('Error fetching favourites: $e');
    }
  }

  @override
  Future<void> removeFavourite(String userId, int movieId) async {
    try {
      final docRef = firestore.collection('users').doc(userId).collection('favourites').doc('$movieId');
      await docRef.delete();
    } catch (e) {
      throw Exception('Error removing favourite: $e');
    }
  }
}
