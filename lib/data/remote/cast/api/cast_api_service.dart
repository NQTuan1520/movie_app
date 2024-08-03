import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/resource/api/api_endpoint.dart';
import '../../../../core/resource/cast_result_response/cast_response.dart';
import '../response/cast_response.dart';

part 'cast_api_service.g.dart';

@RestApi(baseUrl: ApiEndPoint.baseApiUrl)
abstract class CastApiService {
  factory CastApiService(Dio dio) = _CastApiService;

  @GET(ApiEndPoint.getCastByMovieID)
  @Extra({'requiresApiKey': true})
  Future<CastResponseObject<List<CastResponse>>> getCastByMovieId(@Path('movie_id') int movieId);

  @GET(ApiEndPoint.getCastByTVId)
  @Extra({'requiresApiKey': true})
  Future<CastResponseObject<List<CastResponse>>> getCastByTVId(@Path('series_id') int tvId);
}
