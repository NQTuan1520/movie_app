// ignore_for_file: overridden_fields

import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/trailer/entity/trailer_entity.dart';

part 'trailer_response.g.dart';

@JsonSerializable(explicitToJson: true)
class TrailerResponse extends TrailerEntity {
  @override
  @JsonKey(name: 'iso_639_1')
  final String? iso6391;

  @override
  @JsonKey(name: 'iso_3166_1')
  final String? iso31661;

  @override
  @JsonKey(name: 'published_at')
  final String? publishedAt;

  const TrailerResponse({
    this.iso6391,
    this.iso31661,
    super.name,
    super.key,
    super.site,
    super.size,
    super.type,
    super.official,
    this.publishedAt,
    super.id,
  });

  factory TrailerResponse.fromJson(Map<String, dynamic> json) => _$TrailerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TrailerResponseToJson(this);

  @override
  List<Object?> get props => [
        iso6391,
        iso31661,
        name,
        key,
        site,
        size,
        type,
        official,
        publishedAt,
        id,
      ];

  @override
  TrailerResponse copyWith({
    String? iso6391,
    String? iso31661,
    String? name,
    String? key,
    String? site,
    int? size,
    String? type,
    bool? official,
    String? publishedAt,
    String? id,
  }) {
    return TrailerResponse(
      iso6391: iso6391 ?? this.iso6391,
      iso31661: iso31661 ?? this.iso31661,
      name: name ?? this.name,
      key: key ?? this.key,
      site: site ?? this.site,
      size: size ?? this.size,
      type: type ?? this.type,
      official: official ?? this.official,
      publishedAt: publishedAt ?? this.publishedAt,
      id: id ?? this.id,
    );
  }

  @override
  String toString() {
    return 'TrailerResponse{iso6391: $iso6391, iso31661: $iso31661, name: $name, key: $key, site: $site, size: $size, type: $type, official: $official, publishedAt: $publishedAt, id: $id}';
  }

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrailerResponse &&
          runtimeType == other.runtimeType &&
          iso6391 == other.iso6391 &&
          iso31661 == other.iso31661 &&
          name == other.name &&
          key == other.key &&
          site == other.site &&
          size == other.size &&
          type == other.type &&
          official == other.official &&
          publishedAt == other.publishedAt &&
          id == other.id;
}
