import '../../../core/resource/genres_result/genres_result.dart';
import '../../movie/entity/generic_entity.dart';

abstract class GenresRepository {
  Future<GenresResult<List<GenresEntity>>> getGenres();
}
