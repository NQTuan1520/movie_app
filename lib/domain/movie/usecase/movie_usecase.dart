import '../../../core/resource/api/api_exception.dart';
import '../../../core/resource/page/page_result_response.dart';
import '../entity/movie_entity.dart';
import '../repository/movie_reponsitory.dart';

class MovieUseCase {
  final MovieRepository _movieRepository;

  MovieUseCase(this._movieRepository);

  Future<PageResponse<List<MovieEntity>>> getUpComingMovieUseCase(int page) async {
    try {
      return _movieRepository.getUpComingMovie(page);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<PageResponse<List<MovieEntity>>> getMovieSimilarUseCase(int movieId, int page) async {
    try {
      return await _movieRepository.getSimilarMovie(movieId, page);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<PageResponse<List<MovieEntity>>> getNowPlayingMovieUseCase(int page) async {
    try {
      return _movieRepository.getNowPlayingMovie(page);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<PageResponse<List<MovieEntity>>> getPopularMovieUseCase() async {
    try {
      return _movieRepository.getPopularMovie();
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<PageResponse<List<MovieEntity>>> getTrendingMovieUseCase(String timeWindow, int page) async {
    try {
      return _movieRepository.getTrendingMovie(timeWindow, page);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<PageResponse<List<MovieEntity>>> getTopRatedMovieUseCase(int page) async {
    try {
      return _movieRepository.getTopRatedMovie(page);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
