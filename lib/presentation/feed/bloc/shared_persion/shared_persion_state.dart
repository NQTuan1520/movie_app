import 'package:equatable/equatable.dart';
import 'package:tuannq_movie/domain/shared/entity/shared_entity.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';

class SharedPersonState extends Equatable {
  final Status? status;
  final List<SharedEntity>? shared;
  final SharedEntity? sharedEntity;
  final String? message;
  final int? likeCount;
  final bool? isLike;
  final bool? isFresh;
  final Set<String>? likedPosts;
  const SharedPersonState(
      {this.status = Status.initial,
      this.shared = const [],
      this.sharedEntity = const SharedEntity(),
      this.message = '',
      this.likeCount = 0,
      this.isLike = false,
      this.likedPosts = const {},
      this.isFresh = false});

  @override
  List<Object?> get props => [status, shared, sharedEntity, message, likeCount, isLike, likedPosts, isFresh];

  SharedPersonState copyWith({
    Status? status,
    List<SharedEntity>? shared,
    SharedEntity? sharedEntity,
    String? message,
    int? likeCount,
    bool? isLike,
    Set<String>? likedPosts,
    bool? isFresh,
  }) {
    return SharedPersonState(
      status: status ?? this.status,
      shared: shared ?? this.shared,
      sharedEntity: sharedEntity ?? this.sharedEntity,
      message: message ?? this.message,
      likeCount: likeCount ?? this.likeCount,
      isLike: isLike ?? this.isLike,
      likedPosts: likedPosts ?? this.likedPosts,
      isFresh: isFresh ?? this.isFresh,
    );
  }
}
