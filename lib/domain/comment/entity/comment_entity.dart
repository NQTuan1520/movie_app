


import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String? id;
  final String? postId;
  final String? uid;
  final String? email;
  final String? avatar;
  final String? content;
  final String? timestamp;
  final String? parentId;
  final String? username;

  const CommentEntity({
    this.id,
    this.postId,
    this.uid,
    this.email,
    this.avatar,
    this.content,
    this.timestamp,
    this.parentId,
    this.username,
  });

  @override
  List<Object?> get props => [
        id,
        postId,
        uid,
        email,
        avatar,
        content,
        timestamp,
        parentId,
        username,
      ];
}