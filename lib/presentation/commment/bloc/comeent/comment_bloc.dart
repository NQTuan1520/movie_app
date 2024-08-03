import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/comment/usecase/comment_use_case.dart';
import 'comment_event.dart';
import 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final CommentUseCase commentUseCase;

  CommentBloc(this.commentUseCase) : super(const CommentState()) {
    on<AddCommentRequested>(_onAddCommentRequested);
    on<DeleteCommentRequested>(_onDeleteCommentRequested);
    on<GetCommentsRequested>(_onGetCommentsRequested);
    on<GetRepliesRequested>(_onGetRepliesRequested);
    on<UpdateCommentRequested>(_onUpdateCommentRequested);
    on<ReplyToCommentRequested>(_onReplyToCommentRequested);
    on<RefreshCommentRequested>(_onRefreshCommentRequested);
  }

  void _onRefreshCommentRequested(RefreshCommentRequested event, Emitter<CommentState> emit) async {
    emit(state.copyWith(status: CommentStatus.refreshing));
    try {
      final comments = await commentUseCase.getCommentsUseCase(event.postId);
      emit(state.copyWith(status: CommentStatus.success, comments: comments));
    } catch (e) {
      emit(state.copyWith(status: CommentStatus.error, errorMessage: e.toString()));
    }
  }

  void _onAddCommentRequested(AddCommentRequested event, Emitter<CommentState> emit) async {
    try {
      await commentUseCase.addComment(event.comment);
      final comments = await commentUseCase.getCommentsUseCase(event.comment.postId ?? '');
      emit(state.copyWith(
          status: CommentStatus.success, comments: comments, replyingTo: null, countComments: comments.length));
    } catch (e) {
      emit(state.copyWith(status: CommentStatus.error, errorMessage: e.toString()));
    }
  }

  void _onDeleteCommentRequested(DeleteCommentRequested event, Emitter<CommentState> emit) async {
    emit(state.copyWith(status: CommentStatus.loading));
    try {
      await commentUseCase.deleteComment(event.commentId);
      final comments = await commentUseCase.getCommentsUseCase(event.comment.postId ?? '');
      emit(state.copyWith(status: CommentStatus.success, comments: comments, countComments: comments.length));
    } catch (e) {
      emit(state.copyWith(status: CommentStatus.error, errorMessage: e.toString()));
    }
  }

  void _onGetCommentsRequested(GetCommentsRequested event, Emitter<CommentState> emit) async {
    emit(state.copyWith(status: CommentStatus.loading));
    try {
      final comments = await commentUseCase.getCommentsUseCase(event.postId);
      emit(state.copyWith(status: CommentStatus.success, comments: comments, countComments: comments.length));
    } catch (e) {
      emit(state.copyWith(status: CommentStatus.error, errorMessage: e.toString()));
    }
  }

  void _onGetRepliesRequested(GetRepliesRequested event, Emitter<CommentState> emit) async {
    emit(state.copyWith(status: CommentStatus.loading));
    try {
      final replies = await commentUseCase.getRepliesUseCase(event.commentId);

      emit(state.copyWith(status: CommentStatus.success, comments: replies));
    } catch (e) {
      emit(state.copyWith(status: CommentStatus.error, errorMessage: e.toString()));
    }
  }

  void _onUpdateCommentRequested(UpdateCommentRequested event, Emitter<CommentState> emit) async {
    emit(state.copyWith(status: CommentStatus.loading));
    try {
      await commentUseCase.updateComment(event.comment);
      final comments = await commentUseCase.getCommentsUseCase(event.comment.postId ?? '');
      emit(state.copyWith(
          status: CommentStatus.success, comments: comments, replyingTo: null, countComments: comments.length));
    } catch (e) {
      emit(state.copyWith(status: CommentStatus.error, errorMessage: e.toString()));
    }
  }

  void _onReplyToCommentRequested(ReplyToCommentRequested event, Emitter<CommentState> emit) {
    emit(state.copyWith(replyingTo: event.comment));
  }
}
