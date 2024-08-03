import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'image_object_response.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class ImageResponseObject<T> extends Equatable {
  final T? backdrops;

  const ImageResponseObject(this.backdrops);

  factory ImageResponseObject.fromJson(
          Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$ImageResponseObjectFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ImageResponseObjectToJson(this, toJsonT);

  @override
  List<Object?> get props => [backdrops];

  ImageResponseObject<T> copyWith({
    T? backdrops,
  }) {
    return ImageResponseObject<T>(
      backdrops ?? this.backdrops,
    );
  }

  @override
  String toString() {
    return 'ImageResponseObject{results: $backdrops}';
  }
}
