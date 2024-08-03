import 'package:equatable/equatable.dart';

class SharedEntity extends Equatable {
  final String? id;
  final String? uid;
  final String? title;
  final String? posterPath;
  final int? idMovie;
  final String? titleShared;
  final String? email;
  final String? avatar;
  final int? like;
  final bool? isLike;
  final String? username;

  const SharedEntity({
    this.id,
    this.uid,
    this.title,
    this.posterPath,
    this.idMovie,
    this.titleShared,
    this.email,
    this.avatar,
    this.like,
    this.isLike,
    this.username,
  });

  @override

  List<Object?> get props =>
      [id, uid, title, posterPath, idMovie, titleShared, email, avatar, like, isLike, username];

  //copy with

  SharedEntity copyWith({
    String? id,
    String? uid,
    String? title,
    String? posterPath,
    int? idMovie,
    String? titleShared,
    String? email,
    String? avatar,
    int? like,
    bool? isLike,
    String? username,
  }) {
    return SharedEntity(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      title: title ?? this.title,
      posterPath: posterPath ?? this.posterPath,
      idMovie: idMovie ?? this.idMovie,
      titleShared: titleShared ?? this.titleShared,
      email: email ?? this.email,
      avatar: avatar ?? this.avatar,
      like: like ?? this.like,
      isLike: isLike ?? this.isLike,
      username: username ?? this.username,
    );
  }
}
