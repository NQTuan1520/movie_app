import '../../../core/resource/page/page_result_response.dart';
import '../entity/movie_entity.dart';

abstract class MovieRepository {
  //Api Method
  Future<PageResponse<List<MovieEntity>>> getNowPlayingMovie(int page);

  Future<PageResponse<List<MovieEntity>>> getUpComingMovie(int page);

  Future<PageResponse<List<MovieEntity>>> getPopularMovie();

  Future<PageResponse<List<MovieEntity>>> getTopRatedMovie(int page);

  Future<PageResponse<List<MovieEntity>>> getTrendingMovie(String timeWindow, int page);

  Future<PageResponse<List<MovieEntity>>> getSimilarMovie(int movieId, int page);

//get detail movie
}
