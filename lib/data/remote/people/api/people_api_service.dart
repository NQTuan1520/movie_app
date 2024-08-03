import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/resource/api/api_endpoint.dart';
import '../../../../core/resource/page/page_result_response.dart';
import '../response/actor_response.dart';

part 'people_api_service.g.dart';

@RestApi(baseUrl: ApiEndPoint.baseApiUrl)
abstract class PeopleApiService {
  factory PeopleApiService(Dio dio, {String baseUrl}) = _PeopleApiService;

  @GET(ApiEndPoint.peopleEndPoint)
  @Extra({'requiresApiKey': true})
  Future<PageResponse<List<ActorResponse>>> getPopularPeople({
    @Query("page") int? page,
  });
}
