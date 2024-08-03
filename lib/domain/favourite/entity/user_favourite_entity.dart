import 'package:equatable/equatable.dart';

class UserFavouriteEntity extends Equatable {
  final int? id;
  final String? title;
  final String? posterPath;

  const UserFavouriteEntity({this.id, this.title, this.posterPath});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserFavouriteEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          posterPath == other.posterPath;

  factory UserFavouriteEntity.fromJson(Map<String, dynamic> json) {
    return UserFavouriteEntity(
      id: json['id'] as int,
      title: json['title'] as String,
      posterPath: json['posterPath'] as String,
    );
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ posterPath.hashCode;

  @override

  List<Object?> get props => [id, title, posterPath];
}
