import 'package:equatable/equatable.dart';

class ActorEntity extends Equatable {
  final bool? adult;
  final int? gender;
  final int? id;
  final String? knowForDepartment;
  final String? name;
  final String? originalName;
  final double? popularity;
  final String? profilePath;

  const ActorEntity({
    this.adult,
    this.gender,
    this.id,
    this.knowForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
  });

  // Equatable props
  @override
  List<Object?> get props => [
        adult,
        gender,
        id,
        knowForDepartment,
        name,
        originalName,
        popularity,
        profilePath,
      ];

  // copyWith method
  ActorEntity copyWith({
    bool? adult,
    int? gender,
    int? id,
    String? knowForDepartment,
    String? name,
    String? originalName,
    double? popularity,
    String? profilePath,
  }) {
    return ActorEntity(
      adult: adult ?? this.adult,
      gender: gender ?? this.gender,
      id: id ?? this.id,
      knowForDepartment: knowForDepartment ?? this.knowForDepartment,
      name: name ?? this.name,
      originalName: originalName ?? this.originalName,
      popularity: popularity ?? this.popularity,
      profilePath: profilePath ?? this.profilePath,
    );
  }
}
