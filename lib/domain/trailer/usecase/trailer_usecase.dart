import '../../../core/resource/api/api_exception.dart';
import '../../../core/resource/page/page_result_response.dart';
import '../entity/trailer_entity.dart';
import '../repository/trailer_repository.dart';

class TrailerUseCase {
  final TrailerRepository _trailerRepository;

  TrailerUseCase(this._trailerRepository);

  Future<PageResponse<List<TrailerEntity>>> getTrailerByIdUseCase(int id) {
    try {
      return _trailerRepository.getTrailers(id);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
