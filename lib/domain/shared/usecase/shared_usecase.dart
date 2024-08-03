import '../../../core/resource/api/api_exception.dart';
import '../entity/shared_entity.dart';
import '../repository/shared_repository.dart';

class SharedPostUseCase {
  final SharedRepository _sharedRepository;

  SharedPostUseCase(this._sharedRepository);

  Future<SharedEntity> deleteSharedUseCase(String id) async {
    try {
      return await _sharedRepository.deleteShared(id);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<List<SharedEntity>> getAllSharedUseCase() async {
    try {
      return await _sharedRepository.getAllShared();
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<List<SharedEntity>> getSharedByIdUseCase(String uid) async {
    try {
      return await _sharedRepository.getSharedByUid(uid);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<SharedEntity> postSharedUseCase(SharedEntity sharedEntity) async {
    try {
      return await _sharedRepository.postShared(sharedEntity);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<SharedEntity> updateSharedUseCase(SharedEntity sharedEntity, String id) async {
    try {
      return await _sharedRepository.updateShared(sharedEntity, id);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
