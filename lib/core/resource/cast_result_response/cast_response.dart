import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cast_response.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class CastResponseObject<T> extends Equatable {
  final T? cast;

  const CastResponseObject(this.cast);

  factory CastResponseObject.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$CastResponseObjectFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$CastResponseObjectToJson(this, toJsonT);

  @override
  List<Object?> get props => [cast];

  CastResponseObject<T> copyWith({
    T? cast,
  }) {
    return CastResponseObject<T>(
      cast ?? this.cast,
    );
  }

  @override
  String toString() {
    return 'CastResponseObject{results: $cast}';
  }
}
