import '../../../core/resource/api/api_exception.dart';
import '../../../core/resource/page/page_result_response.dart';
import '../entity/tv_show_entity.dart';
import '../repository/tv_show_repository.dart';

class TVShowUseCase {
  final TVShowRepository _tvShowRepository;

  TVShowUseCase(this._tvShowRepository);

  Future<PageResponse<List<TVShowEntity>>> getTVShowAirTodayUseCase() {
    try {
      return _tvShowRepository.getTvShowAirToDay();
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<PageResponse<List<TVShowEntity>>> getTVShowPopularUseCase() async {
    try {
      return await _tvShowRepository.getTvShowPopular();
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<PageResponse<List<TVShowEntity>>> getTVShowSimilarUseCase(String seriesID) async {
    try {
      return await _tvShowRepository.getTVShowSimilar(seriesID);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
