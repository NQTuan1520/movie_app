import 'package:equatable/equatable.dart';
import 'package:tuannq_movie/domain/movie/entity/generic_entity.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';

class GenresState extends Equatable {
  final List<GenresEntity>? genres;
  final Status? status;
  final String? message;

  const GenresState({
    this.genres,
    this.status,
    this.message,
  });

  @override
  List<Object?> get props => [genres, status, message];

  GenresState copyWith({
    List<GenresEntity>? genres,
    Status? status,
    String? message,
  }) {
    return GenresState(
      genres: genres ?? this.genres,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }
}
