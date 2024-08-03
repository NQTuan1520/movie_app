// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _SearchApiService implements SearchApiService {
  _SearchApiService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'https://api.themoviedb.org/3';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<PageResponse<List<MovieResponse>>> searchMovie({
    String? query,
    int? page,
  }) async {
    const _extra = <String, dynamic>{'requiresApiKey': true};
    final queryParameters = <String, dynamic>{
      r'query': query,
      r'page': page,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PageResponse<List<MovieResponse>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/search/movie',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PageResponse<List<MovieResponse>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<MovieResponse>(
                  (i) => MovieResponse.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  @override
  Future<PageResponse<List<MovieResponse>>> searchMovieByFilter({
    String? query,
    int? page,
    bool? isAdult,
    String? primaryReleaseYear,
    String? region,
  }) async {
    const _extra = <String, dynamic>{'requiresApiKey': true};
    final queryParameters = <String, dynamic>{
      r'query': query,
      r'page': page,
      r'include_adult': isAdult,
      r'primary_release_year': primaryReleaseYear,
      r'region': region,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<PageResponse<List<MovieResponse>>>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/search/movie',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(
                baseUrl: _combineBaseUrls(
              _dio.options.baseUrl,
              baseUrl,
            ))));
    final value = PageResponse<List<MovieResponse>>.fromJson(
      _result.data!,
      (json) => json is List<dynamic>
          ? json
              .map<MovieResponse>(
                  (i) => MovieResponse.fromJson(i as Map<String, dynamic>))
              .toList()
          : List.empty(),
    );
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(
    String dioBaseUrl,
    String? baseUrl,
  ) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}
