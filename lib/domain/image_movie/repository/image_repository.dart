import '../../../core/resource/image_object_response/image_object_response.dart';
import '../entity/image_movie_entity.dart';

abstract class ImageRepository {
  Future<ImageResponseObject<List<ImageEntity>>> getImagesByMovieId(int movieId);
}
