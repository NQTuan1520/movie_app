import 'package:equatable/equatable.dart';

class AuthorDetails extends Equatable {
  final String? name;
  final String? username;
  final String? avatarPath;
  final double? rating;

  const AuthorDetails({
    this.name,
    this.username,
    this.avatarPath,
    this.rating,
  });

  @override
  List<Object?> get props => [name, username, avatarPath, rating];

  AuthorDetails copyWith({
    String? name,
    String? username,
    String? avatarPath,
    double? rating,
  }) {
    return AuthorDetails(
      name: name ?? this.name,
      username: username ?? this.username,
      avatarPath: avatarPath ?? this.avatarPath,
      rating: rating ?? this.rating,
    );
  }
}

class ReviewEntity extends Equatable {
  final String? author;
  final AuthorDetails? authorDetails;
  final String? content;
  final String? createdAt;
  final String? id;
  final String? updatedAt;
  final String? url;

  const ReviewEntity({
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
    this.id,
    this.updatedAt,
    this.url,
  });

  @override
  List<Object?> get props => [author, authorDetails, content, createdAt, id, updatedAt, url];

  ReviewEntity copyWith({
    String? author,
    AuthorDetails? authorDetails,
    String? content,
    String? createdAt,
    String? id,
    String? updatedAt,
    String? url,
  }) {
    return ReviewEntity(
      author: author ?? this.author,
      authorDetails: authorDetails ?? this.authorDetails,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      id: id ?? this.id,
      updatedAt: updatedAt ?? this.updatedAt,
      url: url ?? this.url,
    );
  }
}
