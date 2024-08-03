import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../../../core/resource/api/api_endpoint.dart';
import '../request/like_post_request.dart';

part 'like_post_api_service.g.dart';

@RestApi(baseUrl: 'http://localhost:3000')
abstract class LikePostApiService {
  factory LikePostApiService(Dio dio, {String baseUrl}) = _LikePostApiService;

  @POST(ApiEndPoint.likePostEndPoint)
  Future<void> likePost({
    @Field('id') required String id,
    @Field('postId') required String postId,
    @Field('uid') required String uid,
  });

  @DELETE(ApiEndPoint.unlikePostEndPoint)
  Future<void> unlikePost({
    @Path('id') required String id,
    @Query('postId') required String postId,
    @Query('uid') required String uid,
  });

  @GET(ApiEndPoint.getLikesEndPoint)
  Future<List<LikePostRequest>> getLikes();

  @GET(ApiEndPoint.getLikesByPostIdEndPoint)
  Future<List<LikePostRequest>> getLikesByPostId({
    @Query('postId') required String postId,
  });
}
