import '../../../core/resource/page/page_result_response.dart';
import '../entity/actor_entity.dart';

abstract class PeopleRepository {
  //Api Method
  Future<PageResponse<List<ActorEntity>>> getPopularPeople();
}
