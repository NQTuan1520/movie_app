import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/movie/entity/generic_entity.dart';

part 'genres_response.g.dart';

@JsonSerializable(explicitToJson: true)
class GenresResponse extends GenresEntity {
  const GenresResponse({super.id, super.name});

  factory GenresResponse.fromJson(Map<String, dynamic> json) => _$GenresResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GenresResponseToJson(this);
}
