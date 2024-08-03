import '../entity/comment_entity.dart';

abstract class CommentRepository {
  Future<CommentEntity> addComment(CommentEntity comment);
  Future<CommentEntity> deleteComment(String commentId);
  Future<CommentEntity> updateComment(CommentEntity comment);
  Future<List<CommentEntity>> getComments(String postId);
  Future<List<CommentEntity>> getReplies(String commentId);
}
