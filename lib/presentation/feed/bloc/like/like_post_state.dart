import 'package:equatable/equatable.dart';
import 'package:tuannq_movie/manager/enum/like_status_enum.dart';

class LikePostState extends Equatable {
  final LikePostStatus status;
  final bool isLiked;
  final int likeCount;
  final String? message;

  const LikePostState({
    this.status = LikePostStatus.initial,
    this.isLiked = false,
    this.likeCount = 0,
    this.message,
  });

  LikePostState copyWith({
    LikePostStatus? status,
    bool? isLiked,
    int? likeCount,
    String? message,
  }) {
    return LikePostState(
      status: status ?? this.status,
      isLiked: isLiked ?? this.isLiked,
      likeCount: likeCount ?? this.likeCount,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, isLiked, likeCount, message];
}
