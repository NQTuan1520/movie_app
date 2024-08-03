import '../../../../core/resource/api/api_exception.dart';
import '../../entity/key_word_entity.dart';
import '../../repository/key_word_repository.dart';

class KeyWordLocalUseCase {
  final KeyWordRepository _keyWordRepository;

  KeyWordLocalUseCase(this._keyWordRepository);

  Future<List<KeywordEntity>> getKeywordsLocalUseCase() async {
    try {
      return await _keyWordRepository.getKeywords();
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<void> deleteKeywordUseCase(int id) async {
    try {
      await _keyWordRepository.deleteKeyword(id);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addKeywordUseCase(KeywordEntity keyword) async {
    try {
      await _keyWordRepository.addKeyword(keyword);
    } catch (e) {
      rethrow;
    }
  }
}
