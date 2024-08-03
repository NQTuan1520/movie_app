import '../../../core/resource/api/api_exception.dart';
import '../../../core/resource/image_object_response/image_object_response.dart';
import '../entity/image_movie_entity.dart';
import '../repository/image_repository.dart';

class ImageDetailUseCase {
  final ImageRepository _imageRepository;

  ImageDetailUseCase(this._imageRepository);

  Future<ImageResponseObject<List<ImageEntity>>> getImageDetailOfMovieUseCase(int movieId) async {
    try {
      return await _imageRepository.getImagesByMovieId(movieId);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
