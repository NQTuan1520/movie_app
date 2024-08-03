


import 'package:equatable/equatable.dart';

class LikePostEntity extends Equatable {
  final String? idPost;
  final String? idUser;

  const LikePostEntity({
    this.idPost,
    this.idUser,
  });

  @override
  List<Object?> get props => [
    idPost,
    idUser,
  ];

  // copyWith
  LikePostEntity copyWith({
    String? idPost,
    String? idUser,
    bool? isLike,
    bool? isDislike,
  }) {
    return LikePostEntity(
      idPost: idPost ?? this.idPost,
      idUser: idUser ?? this.idUser,
    );
  }
}