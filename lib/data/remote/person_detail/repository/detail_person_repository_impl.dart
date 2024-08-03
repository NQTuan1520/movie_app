import '../../../../core/resource/api/api_exception.dart';
import '../../../../domain/detail_people/repository/detail_person_repository.dart';
import '../api/detail_person_api_service.dart';
import '../response/detail_person_response.dart';

class DetailPersonRepositoryImpl implements PersonDetailRepository {
  final DetailPersonApiService remoteDataSource;

  DetailPersonRepositoryImpl(this.remoteDataSource);

  @override
  Future<DetailPersonResponse> fetchPersonDetail(int id) async {
    try {
      final httpResponse = await remoteDataSource.getPopularMovies(id);
      return httpResponse;
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
