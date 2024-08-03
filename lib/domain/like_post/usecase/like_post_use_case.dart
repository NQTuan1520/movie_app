import '../repository/like_post_repository.dart';

class LikePostUseCase {
  final LikePostRepository _likePostRepository;

  LikePostUseCase(this._likePostRepository);

  Future<void> addLikePost(String idPost, String idUser) async {
    return _likePostRepository.likePost(idPost, idUser);
  }

  Future<void> removeLikePost(String idPost, String idUser) async {
    return _likePostRepository.unlikePost(idPost, idUser);
  }

  Future<bool> isPostLiked(String idPost, String idUser) async {
    return _likePostRepository.isPostLiked(idPost, idUser);
  }

  Future<int> countLikePost(String idPost) async {
    return _likePostRepository.countLikePost(idPost);
  }
}
