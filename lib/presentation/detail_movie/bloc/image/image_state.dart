import 'package:equatable/equatable.dart';

import '../../../../domain/image_movie/entity/image_movie_entity.dart';
import '../../../../manager/enum/status_enum.dart';

class ImageState extends Equatable {
  final Status? status;
  final List<ImageEntity> imageList;
  final String? message;
  const ImageState({
    this.status = Status.initial,
    this.imageList = const [],
    this.message,
  });

  @override
  List<Object?> get props => [status, imageList, message];

  ImageState copyWith({
    Status? status,
    List<ImageEntity>? imageList,
    String? message,
  }) {
    return ImageState(
      status: status ?? this.status,
      imageList: imageList ?? this.imageList,
      message: message ?? this.message,
    );
  }
}
