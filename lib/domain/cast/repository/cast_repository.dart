import '../../../core/resource/cast_result_response/cast_response.dart';
import '../entity/cast_entity.dart';

abstract class CastRepository {
  Future<CastResponseObject<List<CastEntity>>> fetchCastsInDetailMovie(int movieId);
  Future<CastResponseObject<List<CastEntity>>> fetchCastsInDetailTv(int tvId);
}
