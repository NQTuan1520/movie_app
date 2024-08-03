import '../../../core/resource/page/page_result_response.dart';
import '../entity/trailer_entity.dart';

abstract class TrailerRepository {
  Future<PageResponse<List<TrailerEntity>>> getTrailers(int id);
}
