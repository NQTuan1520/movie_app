import '../../../../core/resource/api/api_exception.dart';
import '../../../../core/resource/page/page_result_response.dart';
import '../../../../domain/trailer/repository/trailer_repository.dart';
import '../api/trailer_api_service.dart';
import '../response/trailer_response.dart';

class TrailerRepositoryImpl extends TrailerRepository {
  final TrailerApiService _trailerApiService;

  TrailerRepositoryImpl(this._trailerApiService);

  @override
  Future<PageResponse<List<TrailerResponse>>> getTrailers(int id) async {
    try {
      final httpResponse = await _trailerApiService.getTrailers(id);
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
