import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tuannq_movie/domain/like_post/usecase/like_post_use_case.dart';
import 'package:tuannq_movie/manager/enum/like_status_enum.dart';
import 'package:tuannq_movie/presentation/feed/bloc/like/like_post_event.dart';
import 'package:tuannq_movie/presentation/feed/bloc/like/like_post_state.dart';

class LikePostBloc extends Bloc<LikePostEvent, LikePostState> {
  final LikePostUseCase _likePostUseCase;

  LikePostBloc(this._likePostUseCase) : super(const LikePostState()) {
    on<LikePostRequested>(_onLikePostRequested);
    on<UnlikePostRequested>(_onUnlikePostRequested);
    on<CheckLikeStatusRequested>(_onCheckLikeStatusRequested);
    on<CountLikePostRequested>(_onCountLikePostRequested);
  }

  Future<void> _onLikePostRequested(LikePostRequested event, Emitter<LikePostState> emit) async {
    try {
      emit(state.copyWith(status: LikePostStatus.loading));
      await _likePostUseCase.addLikePost(event.postId, event.uid);
      bool isLiked = await _likePostUseCase.isPostLiked(event.postId, event.uid);
      int likeCount = await _likePostUseCase.countLikePost(event.postId);
      emit(state.copyWith(status: LikePostStatus.success, isLiked: isLiked, likeCount: likeCount));
    } catch (e) {
      emit(state.copyWith(status: LikePostStatus.failure, message: e.toString()));
    }
  }

  Future<void> _onUnlikePostRequested(UnlikePostRequested event, Emitter<LikePostState> emit) async {
    try {
      emit(state.copyWith(status: LikePostStatus.loading));
      await _likePostUseCase.removeLikePost(event.postId, event.uid);
      bool isLiked = await _likePostUseCase.isPostLiked(event.postId, event.uid);
      int likeCount = await _likePostUseCase.countLikePost(event.postId);
      emit(state.copyWith(status: LikePostStatus.success, isLiked: isLiked, likeCount: likeCount));
    } catch (e) {
      emit(state.copyWith(status: LikePostStatus.failure, message: e.toString()));
    }
  }

  Future<void> _onCheckLikeStatusRequested(CheckLikeStatusRequested event, Emitter<LikePostState> emit) async {
    try {
      emit(state.copyWith(status: LikePostStatus.loading));
      bool isLiked = await _likePostUseCase.isPostLiked(event.postId, event.uid);
      int likeCount = await _likePostUseCase.countLikePost(event.postId);
      emit(state.copyWith(status: LikePostStatus.success, isLiked: isLiked, likeCount: likeCount));
    } catch (e) {
      emit(state.copyWith(status: LikePostStatus.failure, message: e.toString()));
    }
  }

  Future<void> _onCountLikePostRequested(CountLikePostRequested event, Emitter<LikePostState> emit) async {
    try {
      emit(state.copyWith(status: LikePostStatus.loading));
      int likeCount = await _likePostUseCase.countLikePost(event.postId);
      emit(state.copyWith(status: LikePostStatus.success, likeCount: likeCount)); // Only like count is updated
    } catch (e) {
      emit(state.copyWith(status: LikePostStatus.failure, message: e.toString()));
    }
  }
}
