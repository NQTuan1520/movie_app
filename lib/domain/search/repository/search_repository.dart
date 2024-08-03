import '../../../core/resource/page/page_result_response.dart';
import '../../movie/entity/movie_entity.dart';

abstract class SearchRepository {
  //Api Method
  Future<PageResponse<List<MovieEntity>>> searchMovie(
    String query,
  );

  Future<PageResponse<List<MovieEntity>>> searchMovieByFilter(
    String query,
    bool isAdult,
    String primaryReleaseYear,
    String region,
  );
}
