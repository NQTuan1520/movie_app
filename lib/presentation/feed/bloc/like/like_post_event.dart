abstract class LikePostEvent {}

class LikePostRequested extends LikePostEvent {
  final String postId;
  final String uid;

  LikePostRequested({required this.postId, required this.uid});
}

class UnlikePostRequested extends LikePostEvent {
  final String postId;
  final String uid;

  UnlikePostRequested({required this.postId, required this.uid});
}

class CheckLikeStatusRequested extends LikePostEvent {
  final String postId;
  final String uid;

  CheckLikeStatusRequested({required this.postId, required this.uid});
}

class CountLikePostRequested extends LikePostEvent {
  final String postId;

  CountLikePostRequested({required this.postId});
}
