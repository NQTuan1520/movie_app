import '../../../../core/resource/api/api_exception.dart';
import '../../../../domain/creadit/repository/credit_repository.dart';
import '../api/credit_api_service.dart';
import '../response/credit_response.dart';

class CreditRepositoryImpl extends CreditRepository {
  final CreditApiService _creditApiService;

  CreditRepositoryImpl(this._creditApiService);
  @override
  Future<CreditResponse> getCreditDetail(String id) {
    try {
      final httpResponse = _creditApiService.getDetailCredit(id);
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
