// import 'package:huynd2_assignment/core/resource/api/api_exception.dart';
// import 'package:huynd2_assignment/core/resource/page_result_response.dart';
// import 'package:huynd2_assignment/domain/movie/entity/movie_entity.dart';
// import 'package:huynd2_assignment/domain/search/repository/search_repository.dart';
//
// class SearchMovieUseCase {
//   final SearchRepository searchRepository;
//
//   SearchMovieUseCase(this.searchRepository);
//
//   Future<PageResponse<List<MovieEntity>>> call(String query) async {
//     try {
//       return searchRepository.searchMovie(query);
//     } catch (e) {
//       throw ApiException(message: e.toString());
//     }
//   }
// }
