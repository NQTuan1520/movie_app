import '../entity/comment_entity.dart';
import '../repository/comment_repository.dart';

class CommentUseCase {
  final CommentRepository repository;

  CommentUseCase(this.repository);

  Future<CommentEntity> addComment(CommentEntity comment) async {
    return repository.addComment(comment);
  }

  Future<CommentEntity> deleteComment(String commentId) {
    return repository.deleteComment(commentId);
  }

  Future<List<CommentEntity>> getCommentsUseCase(String postId) {
    return repository.getComments(postId);
  }

  Future<List<CommentEntity>> getRepliesUseCase(String commentId) {
    return repository.getReplies(commentId);
  }

  Future<CommentEntity> updateComment(CommentEntity comment) {
    return repository.updateComment(comment);
  }
}
