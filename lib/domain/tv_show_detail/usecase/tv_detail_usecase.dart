import '../enitty/tv_detail_entity.dart';
import '../repository/tv_detail_repository.dart';

class TVDetailUseCase {
  final TVDetailRepository _repository;

  TVDetailUseCase(this._repository);

  Future<TVDetailEntity> getTVShowDetail(int id) {
    return _repository.getTVShowDetail(id);
  }
}
