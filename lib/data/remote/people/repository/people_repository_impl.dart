import 'dart:convert';
import 'package:flutter/foundation.dart';

import '../../../../core/resource/api/api_exception.dart';
import '../../../../core/resource/page/page_result_response.dart';
import '../../../../domain/people/repository/people_repository.dart';
import '../../../local/movie/datasource/cached_db_helper.dart';
import '../api/people_api_service.dart';
import '../response/actor_response.dart';

class PeopleRepositoryImpl implements PeopleRepository {
  final PeopleApiService _peopleApiService;
  final DatabaseHelper _databaseHelper;

  PeopleRepositoryImpl(this._peopleApiService, this._databaseHelper);

  @override
  Future<PageResponse<List<ActorResponse>>> getPopularPeople({int page = 1}) async {
    try {
      return await _getPeopleFromCacheOrApi(
          page, 'popular_people', () => _peopleApiService.getPopularPeople(page: page));
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<PageResponse<List<ActorResponse>>> _getPeopleFromCacheOrApi(
      int page, String type, Future<PageResponse<List<ActorResponse>>> Function() apiCall) async {
    try {
      final cachedData = await _databaseHelper.getMovie(page, type);

      if (cachedData != null) {
        final List<ActorResponse> actors =
            (json.decode(cachedData) as List).map((i) => ActorResponse.fromJson(i)).toList();
        if (kDebugMode) {
          print('cachedData: $cachedData');
        } // Debug log
        return PageResponse(actors, page, null, null);
      }

      final httpResponse = await apiCall();
      final data = json.encode(httpResponse.results?.map((e) => e.toJson()).toList());
      if (kDebugMode) {
        print('data: $data');
      } // Debug log
      await _databaseHelper.insertMovie(page, data, type);
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
