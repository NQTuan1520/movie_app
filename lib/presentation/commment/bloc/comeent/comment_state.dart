import 'package:equatable/equatable.dart';

import '../../../../domain/comment/entity/comment_entity.dart';

enum CommentStatus { initial, loading, success, error, refreshing }

class CommentState extends Equatable {
  final List<CommentEntity>? comments;
  final CommentStatus? status;
  final String? errorMessage;
  final CommentEntity? replyingTo;
  final List<CommentEntity>? replyComments;
  final int? countComments;

  const CommentState({
    this.comments = const [],
    this.status = CommentStatus.initial,
    this.replyingTo,
    this.errorMessage = '',
    this.replyComments = const [],
    this.countComments = 0,
  });

  CommentState copyWith({
    List<CommentEntity>? comments,
    CommentStatus? status,
    String? errorMessage,
    CommentEntity? replyingTo,
    List<CommentEntity>? replyComments,
    int? countComments,
  }) {
    return CommentState(
      comments: comments ?? this.comments,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      replyingTo: replyingTo ?? this.replyingTo,
      replyComments: replyComments ?? this.replyComments,
      countComments: countComments ?? this.countComments,
    );
  }

  @override
  List<Object?> get props => [comments, status, errorMessage, replyingTo, replyComments, countComments];
}
