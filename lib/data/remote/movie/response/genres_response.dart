import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/genres/entity/genres_entity.dart';

part 'genres_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GenresResponse extends GenresEntity {
  const GenresResponse({super.id, super.name});

  factory GenresResponse.fromJson(Map<String, dynamic> json) => _$GenresResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GenresResponseToJson(this);

  factory GenresResponse.fromEntity(GenresEntity entity) {
    return GenresResponse(
      id: entity.id,
      name: entity.name,
    );
  }
}
