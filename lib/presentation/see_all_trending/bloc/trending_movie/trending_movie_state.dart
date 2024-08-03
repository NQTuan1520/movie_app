import 'package:equatable/equatable.dart';
import 'package:tuannq_movie/domain/movie/entity/movie_entity.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';

class TrendingMovieState extends Equatable {
  final Status? status;
  final bool? isRefresh;
  final bool? isLoadMore;
  final List<MovieEntity>? trendingMovies;
  final String? timeWindow;
  final String? message;
  final int currentPage;
  final int? selectedGenreId;
  const TrendingMovieState({
    this.status = Status.initial,
    this.message = '',
    this.isRefresh = false,
    this.isLoadMore = false,
    this.trendingMovies = const [],
    this.timeWindow = 'day',
    this.currentPage = 1,
    this.selectedGenreId,
  });

  TrendingMovieState copyWith({
    Status? status,
    bool? isRefresh,
    bool? isLoadMore,
    String? message,
    List<MovieEntity>? trendingMovies,
    String? timeWindow,
    int? currentPage,
    int? selectedGenreId,
    bool? isSelectedAll,
  }) {
    return TrendingMovieState(
      status: status ?? this.status,
      isRefresh: isRefresh ?? this.isRefresh,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      trendingMovies: trendingMovies ?? this.trendingMovies,
      timeWindow: timeWindow ?? this.timeWindow,
      message: message ?? this.message,
      currentPage: currentPage ?? this.currentPage,
      selectedGenreId: selectedGenreId ?? this.selectedGenreId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isRefresh,
        isLoadMore,
        trendingMovies,
        timeWindow,
        currentPage,
        selectedGenreId,
      ];
}
