import '../../../../domain/like_post/repository/like_post_repository.dart';
import '../api/like_post_api_service.dart';

class LikePostRepositoryImpl extends LikePostRepository {
  final LikePostApiService _likePostApiService;

  LikePostRepositoryImpl(this._likePostApiService);

  @override
  Future<bool> isPostLiked(String postId, String uid) async {
    final likes = await _likePostApiService.getLikesByPostId(postId: postId);
    return likes.any((like) => like.idUser == uid);
  }

  @override
  Future<void> likePost(String postId, String uid) async {
    await _likePostApiService.likePost(id: uid, postId: postId, uid: uid);
  }

  @override
  Future<void> unlikePost(String postId, String uid) async {
    await _likePostApiService.unlikePost(id: uid, postId: postId, uid: uid);
  }

  @override
  Future<int> countLikePost(String postId) async {
    final likes = await _likePostApiService.getLikesByPostId(postId: postId);
    return likes.length;
  }
}
