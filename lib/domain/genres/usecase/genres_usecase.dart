import '../../../core/resource/api/api_exception.dart';
import '../../../core/resource/genres_result/genres_result.dart';
import '../../movie/entity/generic_entity.dart';
import '../repository/genres_repository.dart';

class GenresUseCase {
  final GenresRepository _genresRepository;

  GenresUseCase(this._genresRepository);

  Future<GenresResult<List<GenresEntity>>> getGenres() async {
    try {
      return await _genresRepository.getGenres();
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
