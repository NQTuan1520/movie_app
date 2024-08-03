import '../../../core/resource/api/api_exception.dart';
import '../../../core/resource/page/page_result_response.dart';
import '../entity/review_entity.dart';
import '../repository/review_repository.dart';

class ReviewUseCase {
  final ReviewRepository _reviewRepository;

  ReviewUseCase(this._reviewRepository);

  Future<PageResponse<List<ReviewEntity>>> getReviewByIdUseCase(int id) async {
    try {
      return await _reviewRepository.getReviewByMovieId(id);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<PageResponse<List<ReviewEntity>>> getReviewByTvShowIdUseCase(int id) async {
    try {
      return await _reviewRepository.getReviewByTvShowID(id);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
