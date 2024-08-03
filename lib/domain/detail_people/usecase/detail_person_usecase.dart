import '../entity/detail_person_entity.dart';
import '../repository/detail_person_repository.dart';

class DetailPersonUsecase {
  final PersonDetailRepository _repository;

  DetailPersonUsecase(this._repository);

  Future<PersonDetail> getPersonDetail(int id) async {
    return await _repository.fetchPersonDetail(id);
  }
}
