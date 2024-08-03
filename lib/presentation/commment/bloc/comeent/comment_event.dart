import 'package:equatable/equatable.dart';

import '../../../../domain/comment/entity/comment_entity.dart';

class CommentEvent extends Equatable {
  const CommentEvent();

  @override
  List<Object?> get props => [];
}

class AddCommentRequested extends CommentEvent {
  final CommentEntity comment;

  const AddCommentRequested(this.comment);

  @override
  List<Object?> get props => [comment];
}

class DeleteCommentRequested extends CommentEvent {
  final String commentId;
  final CommentEntity comment;

  const DeleteCommentRequested(this.commentId, this.comment);

  @override
  List<Object?> get props => [commentId];
}

class GetCommentsRequested extends CommentEvent {
  final String postId;

  const GetCommentsRequested(this.postId);

  @override
  List<Object?> get props => [postId];
}

class GetRepliesRequested extends CommentEvent {
  final String commentId;

  const GetRepliesRequested(this.commentId);

  @override
  List<Object?> get props => [commentId];
}

class UpdateCommentRequested extends CommentEvent {
  final CommentEntity comment;

  const UpdateCommentRequested(this.comment);

  @override
  List<Object?> get props => [comment];
}

class ReplyToCommentRequested extends CommentEvent {
  final CommentEntity comment;

  const ReplyToCommentRequested(this.comment);

  @override
  List<Object> get props => [comment];
}

class RefreshCommentRequested extends CommentEvent {
  final String postId;

  const RefreshCommentRequested(this.postId);

  @override
  List<Object?> get props => [postId];
}
