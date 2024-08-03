import 'package:tuannq_movie/data/remote/cast/response/cast_response.dart';

import '../../../../core/resource/api/api_exception.dart';
import '../../../../core/resource/cast_result_response/cast_response.dart';
import '../../../../domain/cast/entity/cast_entity.dart';
import '../../../../domain/cast/repository/cast_repository.dart';
import '../api/cast_api_service.dart';

class CastRepositoryImpl extends CastRepository {
  final CastApiService _castApiService;

  CastRepositoryImpl(this._castApiService);

  @override
  Future<CastResponseObject<List<CastResponse>>> fetchCastsInDetailMovie(int movieId) {
    try {
      final httpResponse = _castApiService.getCastByMovieId(movieId);
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<CastResponseObject<List<CastResponse>>> fetchCastsInDetailTv(int tvId) {
    try {
      final httpResponse = _castApiService.getCastByTVId(tvId);
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
