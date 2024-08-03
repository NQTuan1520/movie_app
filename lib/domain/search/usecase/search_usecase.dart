import '../../../core/resource/api/api_exception.dart';
import '../../../core/resource/page/page_result_response.dart';
import '../../movie/entity/movie_entity.dart';
import '../repository/search_repository.dart';

class SearchUseCase {
  final SearchRepository _searchRepository;

  SearchUseCase(this._searchRepository);

  Future<PageResponse<List<MovieEntity>>> searchMovieByQuery(String query) async {
    try {
      return _searchRepository.searchMovie(query);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<PageResponse<List<MovieEntity>>> searchMovieByFilter(
    String query,
    bool isAdult,
    String primaryReleaseYear,
    String region,
  ) async {
    return _searchRepository.searchMovieByFilter(query, isAdult, primaryReleaseYear, region);
  }
}
