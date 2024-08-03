import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'page_result_response.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class PageResponse<T> extends Equatable {
  final T? results;
  final int? page;
  final int? totalPages;
  final int? totalResults;

  const PageResponse(this.results, this.page, this.totalPages, this.totalResults);

  factory PageResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$PageResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$PageResponseToJson(this, toJsonT);

  @override
  List<Object?> get props => [results, page, totalPages, totalResults];

  PageResponse<T> copyWith({
    T? results,
    int? page,
    int? totalPages,
    int? totalResults,
  }) {
    return PageResponse<T>(
      results ?? this.results,
      page ?? this.page,
      totalPages ?? this.totalPages,
      totalResults ?? this.totalResults,
    );
  }

  @override
  String toString() {
    return 'PageResponse{results: $results, page: $page, totalPages: $totalPages, totalResults: $totalResults}';
  }
}
