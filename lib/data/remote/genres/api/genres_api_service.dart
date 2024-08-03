import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:tuannq_movie/core/resource/api/api_endpoint.dart';
import 'package:tuannq_movie/data/remote/genres/response/genres_response.dart';

import '../../../../core/resource/genres_result/genres_result.dart';

part 'genres_api_service.g.dart';

@RestApi(baseUrl: ApiEndPoint.baseApiUrl)
abstract class GenresApiService {
  factory GenresApiService(Dio dio) = _GenresApiService;

  @GET(ApiEndPoint.genresEndPoint)
  @Extra({'requiresApiKey': true})
  Future<GenresResult<List<GenresResponse>>> getGenres();
}
