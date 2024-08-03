import '../../../../core/resource/api/api_exception.dart';
import '../../../../core/resource/page/page_result_response.dart';
import '../../../../domain/movie/entity/movie_entity.dart';
import '../../../../domain/movie/repository/movie_reponsitory.dart';
import '../../../local/movie/datasource/cached_db_helper.dart';
import '../api/movie_api_service.dart';
import '../response/movie_response.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieApiService _movieApiService;
  final DatabaseHelper _databaseHelper;

  MovieRepositoryImpl(this._movieApiService, this._databaseHelper);

  @override
  Future<PageResponse<List<MovieResponse>>> getNowPlayingMovie(int page) async {
    try {
      final httpResponse = await _movieApiService.getNowPlayingMovies(page: page);
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<PageResponse<List<MovieResponse>>> getPopularMovie() async {
    try {
      final httpResponse = await _movieApiService.getPopularMovies(page: 1);
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<PageResponse<List<MovieResponse>>> getTopRatedMovie(int page) async {
    try {
      final httpResponse = await _movieApiService.getTopRatedMovies(page: page);
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<PageResponse<List<MovieEntity>>> getUpComingMovie(int page) async {
    try {
      final httpResponse = await _movieApiService.getUpcomingMovies(page: page);
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<PageResponse<List<MovieEntity>>> getTrendingMovie(String timeWindow, int page) async {
    try {
      final httpResponse = await _movieApiService.getTrendingMovies(page: page, timeWindow);
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  // Future<PageResponse<List<MovieEntity>>> _getMoviesFromCacheOrApi(
  //     int page,
  //     String type,
  //     Future<PageResponse<List<MovieResponse>>> Function() apiCall) async {
  //   try {
  //     final cachedData = await _databaseHelper.getMovie(page, type);

  //     if (cachedData != null) {
  //       final List<MovieEntity> movies = (json.decode(cachedData) as List)
  //           .map((i) => MovieResponse.fromJson(i).toEntity())
  //           .toList();
  //       if (kDebugMode) {
  //         print('cachedData: $cachedData');
  //       } // Debug log
  //       return PageResponse(movies, page, null, null);
  //     }

  //     final httpResponse = await apiCall();
  //     final data =
  //         json.encode(httpResponse.results?.map((e) => e.toJson()).toList());
  //     if (kDebugMode) {
  //       print('data: $data');
  //     } // Debug log
  //     await _databaseHelper.insertMovie(page, data, type);
  //     return httpResponse;
  //   } catch (e) {
  //     throw ApiException(message: e.toString());
  //   }
  // }

  @override
  Future<PageResponse<List<MovieResponse>>> getSimilarMovie(int movieId, int page) async {
    try {
      final httpResponse = await _movieApiService.getSimilarMovies(movieId, page: page);
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
