import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../../../core/resource/api/api_exception.dart';
import '../../../../domain/shared/entity/shared_entity.dart';
import '../../../../domain/shared/repository/shared_repository.dart';
import '../../../local/feed/resource/feed_cached_database.dart';
import '../api/shared_api_service.dart';
import '../response/shared_response.dart';

class SharedRepositoryImpl extends SharedRepository {
  final SharedApiService _sharedApiService;
  final CachedFeedDatabase _databaseHelper;

  SharedRepositoryImpl(this._sharedApiService, this._databaseHelper);

  @override
  Future<SharedResponse> deleteShared(String id) async {
    try {
      final httpResponse = await _sharedApiService.deleteShared(id);
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<List<SharedResponse>> getAllShared() async {
    try {
      final httpResponse = await _sharedApiService.getAllShared();
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<List<SharedResponse>> getSharedByUid(String uid) async {
    try {
      final httpResponse = await _sharedApiService.getSharedByUid(uid);
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<SharedResponse> postShared(SharedEntity sharedEntity) async {
    try {
      final httpResponse = await _sharedApiService.postShared(SharedResponse(
        id: sharedEntity.id,
        uid: sharedEntity.uid,
        title: sharedEntity.title,
        posterPath: sharedEntity.posterPath,
        titleShared: sharedEntity.titleShared,
        idMovie: sharedEntity.idMovie,
        email: sharedEntity.email,
        avatar: sharedEntity.avatar,
        like: sharedEntity.like,
        isLike: sharedEntity.isLike,
        username: sharedEntity.username,
      ));
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  @override
  Future<SharedResponse> updateShared(SharedEntity sharedEntity, String id) async {
    try {
      final httpResponse = await _sharedApiService.updateShared(
        id,
        SharedResponse(
          id: sharedEntity.id,
          uid: sharedEntity.uid,
          title: sharedEntity.title,
          titleShared: sharedEntity.titleShared,
          posterPath: sharedEntity.posterPath,
          idMovie: sharedEntity.idMovie,
          email: sharedEntity.email,
          avatar: sharedEntity.avatar,
          like: sharedEntity.like,
          isLike: sharedEntity.isLike,
          username: sharedEntity.username,
        ),
      );
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }

  Future<List<SharedResponse>> _getSharedCachedOrApi(
      int page, String type, Future<List<SharedResponse>> Function() apiCall) async {
    try {
      final cachedData = await _databaseHelper.getFeed(page, type);

      if (cachedData != null) {
        final List<SharedResponse> shared =
            (json.decode(cachedData) as List).map((i) => SharedResponse.fromJson(i)).toList();
        if (kDebugMode) {
          print('cachedData: $cachedData');
        } // Debug log
        return shared;
      }

      final httpResponse = await apiCall();
      final data = json.encode(httpResponse.map((e) => e.toJson()).toList());
      if (kDebugMode) {
        print('data: $data');
      } // Debug log
      await _databaseHelper.insertCached(page, data, type);
      return httpResponse;
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
