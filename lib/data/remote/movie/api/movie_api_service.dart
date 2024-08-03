import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/resource/api/api_endpoint.dart';
import '../../../../core/resource/page/page_result_response.dart';
import '../response/movie_response.dart';

part 'movie_api_service.g.dart';

@RestApi(baseUrl: ApiEndPoint.baseApiUrl)
abstract class MovieApiService {
  factory MovieApiService(Dio dio) = _MovieApiService;

  @GET(ApiEndPoint.popularMovieEndpoint)
  @Extra({'requiresApiKey': true})
  Future<PageResponse<List<MovieResponse>>> getPopularMovies({
    @Query("page") int? page,
  });

  @GET(ApiEndPoint.topRatedMovieEndpoint)
  @Extra({'requiresApiKey': true})
  Future<PageResponse<List<MovieResponse>>> getTopRatedMovies({@Query("page") int? page});

  @GET(ApiEndPoint.upcomingMovieEndpoint)
  @Extra({'requiresApiKey': true})
  Future<PageResponse<List<MovieResponse>>> getUpcomingMovies({@Query("page") int? page});

  @GET(ApiEndPoint.nowPlayingMovieEndpoint)
  @Extra({'requiresApiKey': true})
  Future<PageResponse<List<MovieResponse>>> getNowPlayingMovies({@Query("page") int? page});

  @GET(ApiEndPoint.movieTimeWindowEndPoint)
  @Extra({'requiresApiKey': true})
  Future<PageResponse<List<MovieResponse>>> getTrendingMovies(@Path("time_window") String? timeWindow,
      {@Query("language") String? language, @Query("page") int? page});

  @GET(ApiEndPoint.similarMovieEndPoint)
  @Extra({'requiresApiKey': true})
  Future<PageResponse<List<MovieResponse>>> getSimilarMovies(@Path("movie_id") int? movieId,
      {@Query("page") int? page});
}
