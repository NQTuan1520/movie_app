


abstract class LikePostRepository {
  Future<void> likePost(String postId, String uid);
  Future<void> unlikePost(String postId, String uid);
  Future<bool> isPostLiked(String postId, String uid);
  Future<int> countLikePost(String postId);
}