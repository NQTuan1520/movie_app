import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/keyword/entity/key_word_entity.dart';

part 'keyword_response.g.dart';

@JsonSerializable(explicitToJson: true)
class KeywordResponse extends KeywordEntity {
  const KeywordResponse({super.id, super.name});

  factory KeywordResponse.fromJson(Map<String, dynamic> json) => _$KeywordResponseFromJson(json);

  Map<String, dynamic> toJson() => _$KeywordResponseToJson(this);

  factory KeywordResponse.fromEntity(KeywordEntity entity) {
    return KeywordResponse(
      id: entity.id,
      name: entity.name,
    );
  }
}
