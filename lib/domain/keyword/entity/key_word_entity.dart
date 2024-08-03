import 'package:equatable/equatable.dart';

class KeywordEntity extends Equatable {
  final String? name;
  final int? id;

  const KeywordEntity({this.name, this.id});

  @override
  List<Object?> get props => [name, id];

  KeywordEntity copyWith({
    String? name,
    int? id,
  }) {
    return KeywordEntity(
      name: name ?? this.name,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'keyword': name,
      };

  factory KeywordEntity.fromMap(Map<String, dynamic> json) => KeywordEntity(
        id: json['id'],
        name: json['keyword'],
      );
}
