import '../../../core/resource/page/page_result_response.dart';
import '../entity/tv_show_entity.dart';

abstract class TVShowRepository {
  // API method
  Future<PageResponse<List<TVShowEntity>>> getTvShowAirToDay();

  Future<PageResponse<List<TVShowEntity>>> getTvShowPopular();

  Future<PageResponse<List<TVShowEntity>>> getTVShowSimilar(String seriesID);
}
