class UserEntity {
  final String id;
  final String email;
  final String username;
  final String image;

  UserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.image,
  });

  UserEntity copyWith({
    String? id,
    String? email,
    String? username,
    String? image,
  }) {
    return UserEntity(
      id: id ?? this.id,
      email: email ?? this.email,
      username: username ?? this.username,
      image: image ?? this.image,
    );
  }

  @override
  String toString() {
    return 'UserEntity{id: $id, email: $email, username: $username, image: $image}';
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          username == other.username &&
          image == other.image;

  //to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'image': image,
    };
  }

  //from json
  factory UserEntity.fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      email: json['email'],
      username: json['username'],
      image: json['image'],
    );
  }
}
