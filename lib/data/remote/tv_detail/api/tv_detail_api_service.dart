import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/resource/api/api_endpoint.dart';
import '../response/tv_detail_response.dart';

part 'tv_detail_api_service.g.dart';

@RestApi(baseUrl: ApiEndPoint.baseApiUrl)
abstract class TvDetailApiService {
  factory TvDetailApiService(Dio dio, {String baseUrl}) = _TvDetailApiService;

  @GET(ApiEndPoint.tvDetailEndPoint)
  @Extra({'requiresApiKey': true})
  Future<TVDetailResponse> getTvDetail(
    @Path('series_id') int tvID,
  );
}
