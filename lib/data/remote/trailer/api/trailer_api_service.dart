import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/resource/api/api_endpoint.dart';
import '../../../../core/resource/page/page_result_response.dart';
import '../response/trailer_response.dart';

part 'trailer_api_service.g.dart';

@RestApi(baseUrl: ApiEndPoint.baseApiUrl)
abstract class TrailerApiService {
  factory TrailerApiService(Dio dio) = _TrailerApiService;

  @GET(ApiEndPoint.trailerEndPoint)
  @Extra({'requiresApiKey': true})
  Future<PageResponse<List<TrailerResponse>>> getTrailers(
    @Path('movie_id') int id,
  );
}
