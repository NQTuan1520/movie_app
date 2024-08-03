import '../entity/detail_person_entity.dart';

abstract class PersonDetailRepository {
  Future<PersonDetail> fetchPersonDetail(int personId);
}
