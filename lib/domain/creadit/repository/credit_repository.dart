import '../entity/credit_entity.dart';

abstract class CreditRepository {
  Future<CreditEntity> getCreditDetail(String id);
}
