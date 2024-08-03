import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final double? aspectRatio;
  final int? height;
  final String? iso6391;
  final String? filePath;
  final double? voteAverage;
  final int? voteCount;
  final int? width;

  const ImageEntity({
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.filePath,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  ImageEntity copyWith({
    double? aspectRatio,
    int? height,
    String? iso6391,
    String? filePath,
    double? voteAverage,
    int? voteCount,
    int? width,
  }) {
    return ImageEntity(
      aspectRatio: aspectRatio ?? this.aspectRatio,
      height: height ?? this.height,
      iso6391: iso6391 ?? this.iso6391,
      filePath: filePath ?? this.filePath,
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      width: width ?? this.width,
    );
  }

  @override
  List<Object?> get props => [
        aspectRatio,
        height,
        iso6391,
        filePath,
        voteAverage,
        voteCount,
        width,
      ];
}
