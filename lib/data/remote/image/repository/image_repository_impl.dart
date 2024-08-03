import '../../../../core/resource/api/api_exception.dart';
import '../../../../core/resource/image_object_response/image_object_response.dart';
import '../../../../domain/image_movie/repository/image_repository.dart';
import '../api/image_api_service.dart';
import '../response/image_response.dart';

class ImageRepositoryImpl extends ImageRepository {
  final ImageApiService _imageApiService;

  ImageRepositoryImpl(this._imageApiService);

  @override
  Future<ImageResponseObject<List<ImageResponse>>> getImagesByMovieId(int movieId) async {
    try {
      final httpResponse = await _imageApiService.getMovieImages(movieId);
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
