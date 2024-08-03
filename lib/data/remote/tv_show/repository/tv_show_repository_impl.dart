import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../core/resource/api/api_exception.dart';
import '../../../../core/resource/page/page_result_response.dart';
import '../../../../domain/tv_show/entity/tv_show_entity.dart';
import '../../../../domain/tv_show/repository/tv_show_repository.dart';
import '../../../local/tv_show/datasource/cached_db_tv_show_hepler.dart';
import '../api/tv_show_api_service.dart';
import '../response/tv_show_response.dart';

class TVShowRepositoryImpl extends TVShowRepository {
  final TVShowApiService _tvShowApiService;
  final DatabaseTvShowCachedHelper _databaseTvShowCachedHelper;

  TVShowRepositoryImpl(this._tvShowApiService, this._databaseTvShowCachedHelper);

  @override
  Future<PageResponse<List<TVShowResponse>>> getTvShowAirToDay() async {
    return await _getTvShowFromCacheOrApi(1, "airing_today", () => _tvShowApiService.getAiringTodayTVShows(page: 1));
  }

  @override
  Future<PageResponse<List<TVShowResponse>>> getTvShowPopular() async {
    return await _getTvShowFromCacheOrApi(1, "popular", () => _tvShowApiService.getPopularTVShows(page: 1));
  }

  @override
  Future<PageResponse<List<TVShowEntity>>> getTVShowSimilar(String seriesID) async {
    try {
      return await _tvShowApiService.getSimilarTVShows(seriesID: seriesID);
    } on ApiException catch (e) {
      throw ApiException(message: e.toString());
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<PageResponse<List<TVShowResponse>>> _getTvShowFromCacheOrApi(
      int page, String type, Future<PageResponse<List<TVShowResponse>>> Function() apiCall) async {
    try {
      final cachedData = await _databaseTvShowCachedHelper.getTvShowCached(page, type);

      if (cachedData != null) {
        final List<TVShowResponse> actors =
            (json.decode(cachedData) as List).map((i) => TVShowResponse.fromJson(i)).toList();
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
      await _databaseTvShowCachedHelper.insertTvShowCached(page, data, type);
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
