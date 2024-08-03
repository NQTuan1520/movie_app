import 'package:equatable/equatable.dart';

class GenresEntity extends Equatable {
  final int? id;
  final String? name;

  const GenresEntity({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
