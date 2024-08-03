import 'package:tuannq_movie/data/remote/tv_detail/response/tv_detail_response.dart';

import '../../../../core/resource/api/api_exception.dart';
import '../../../../domain/tv_show_detail/repository/tv_detail_repository.dart';
import '../api/tv_detail_api_service.dart';

class TVDetailRepositoryImpl extends TVDetailRepository {
  final TvDetailApiService _tvDetailApiService;

  TVDetailRepositoryImpl(this._tvDetailApiService);

  @override
  Future<TVDetailResponse> getTVShowDetail(int id) {
    try {
      final httpResponse = _tvDetailApiService.getTvDetail(id);
      return httpResponse;
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
