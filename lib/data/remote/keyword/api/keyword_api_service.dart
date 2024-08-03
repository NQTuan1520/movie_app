import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/resource/api/api_endpoint.dart';
import '../../../../core/resource/page/page_result_response.dart';
import '../response/keyword_response.dart';

part 'keyword_api_service.g.dart';

@RestApi(baseUrl: ApiEndPoint.baseApiUrl)
abstract class KeywordApiService {
  factory KeywordApiService(Dio dio) = _KeywordApiService;

  @GET(ApiEndPoint.searchKeywordEndPoint)
  @Extra({'requiresApiKey': true})
  Future<PageResponse<List<KeywordResponse>>> getKeywordById({
    @Query("page") int? page,
    @Query("query") String? query,
  });
}
