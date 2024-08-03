import 'package:json_annotation/json_annotation.dart';

import '../../../../domain/image_movie/entity/image_movie_entity.dart';

part 'image_response.g.dart';

@JsonSerializable(explicitToJson: true)
class ImageResponse extends ImageEntity {
  @override
  @JsonKey(name: 'aspect_ratio')
  final double? aspectRatio;

  @override
  @JsonKey(name: 'iso_639_1')
  final String? iso6391;

  @override
  @JsonKey(name: 'file_path')
  final String? filePath;

  @override
  @JsonKey(name: 'vote_average')
  final double? voteAverage;
  @override
  @JsonKey(name: 'vote_count')
  final int? voteCount;

  const ImageResponse({
    this.aspectRatio,
    super.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    super.width,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) => _$ImageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ImageResponseToJson(this);

  @override
  ImageResponse copyWith({
    double? aspectRatio,
    int? height,
    String? iso6391,
    String? filePath,
    double? voteAverage,
    int? voteCount,
    int? width,
  }) {
    return ImageResponse(
      aspectRatio: aspectRatio ?? this.aspectRatio,
      iso6391: iso6391 ?? this.iso6391,
      filePath: filePath ?? this.filePath,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
    );
  }
}
