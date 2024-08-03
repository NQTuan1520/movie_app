import '../enitty/tv_detail_entity.dart';

abstract class TVDetailRepository {
  Future<TVDetailEntity> getTVShowDetail(int id);
}
