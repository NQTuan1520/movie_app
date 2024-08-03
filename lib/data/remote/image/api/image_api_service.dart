import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/resource/api/api_endpoint.dart';
import '../../../../core/resource/image_object_response/image_object_response.dart';
import '../response/image_response.dart';

part 'image_api_service.g.dart';

@RestApi(baseUrl: ApiEndPoint.baseApiUrl)
abstract class ImageApiService {
  factory ImageApiService(Dio dio) = _ImageApiService;

  @GET(ApiEndPoint.imageEndPoint)
  @Extra({'requiresApiKey': true})
  Future<ImageResponseObject<List<ImageResponse>>> getMovieImages(
    @Path("movie_id") int movieId,
  );
}
