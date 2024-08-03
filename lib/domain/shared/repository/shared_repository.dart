import '../entity/shared_entity.dart';

abstract class SharedRepository {
  Future<SharedEntity> postShared(SharedEntity sharedEntity);

  Future<List<SharedEntity>> getSharedByUid(String uid);

  Future<List<SharedEntity>> getAllShared();

  Future<SharedEntity> deleteShared(String id);

  Future<SharedEntity> updateShared(SharedEntity sharedEntity, String id);
}
