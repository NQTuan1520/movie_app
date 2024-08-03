import '../../../../core/resource/api/api_exception.dart';
import '../../../../core/resource/page/page_result_response.dart';
import '../../entity/key_word_entity.dart';
import '../../repository/key_word_repository.dart';

class KeywordRemoteUseCase {
  final KeyWordRepository _keywordRepository;

  KeywordRemoteUseCase(this._keywordRepository);

  Future<PageResponse<List<KeywordEntity>>> getKeywordRemoteUseCase(String query) async {
    try {
      return await _keywordRepository.getKeyWords(query);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
