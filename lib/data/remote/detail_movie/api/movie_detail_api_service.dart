import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/resource/api/api_endpoint.dart';
import '../response/movie_detail_response.dart';

part 'movie_detail_api_service.g.dart';

@RestApi(baseUrl: ApiEndPoint.baseApiUrl)
abstract class MovieDetailApiService {
  factory MovieDetailApiService(Dio dio, {String baseUrl}) = _MovieDetailApiService;

  @GET(ApiEndPoint.movieDetailEndPoint)
  @Extra({'requiresApiKey': true})
  Future<MovieDetailResponse> getMovieDetail(@Path('movie_id') int movieId);
}
