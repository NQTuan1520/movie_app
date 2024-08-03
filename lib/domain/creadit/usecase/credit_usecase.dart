import '../entity/credit_entity.dart';
import '../repository/credit_repository.dart';

class CreditUseCase {
  final CreditRepository _creditRepository;

  CreditUseCase(this._creditRepository);

  Future<CreditEntity> getDetailCreditUseCase(String id) async {
    try {
      return _creditRepository.getCreditDetail(id);
    } catch (e) {
      rethrow;
    }
  }
}
