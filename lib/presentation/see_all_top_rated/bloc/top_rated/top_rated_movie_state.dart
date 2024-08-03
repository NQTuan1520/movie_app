import 'package:equatable/equatable.dart';
import 'package:tuannq_movie/domain/movie/entity/movie_entity.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';

class TopRatedMovieState extends Equatable {
  final Status? status;
  final List<MovieEntity>? moviesTopRated;
  final String? message;
  final bool? isRefresh;
  final bool? isLoadMore;
  final int? page;
  final int? selectedGenreId;
  final int? currentPage;
  final double? minVoteAverage;

  const TopRatedMovieState({
    this.status = Status.initial,
    this.moviesTopRated = const [],
    this.message = '',
    this.isRefresh = false,
    this.isLoadMore = false,
    this.page = 1,
    this.selectedGenreId,
    this.currentPage = 1,
    this.minVoteAverage = 0,
  });

  @override
  List<Object?> get props => [
        status,
        moviesTopRated,
        message,
        isRefresh,
        isLoadMore,
        page,
        selectedGenreId,
        currentPage,
        minVoteAverage,
      ];

  TopRatedMovieState copyWith(
      {Status? status,
      List<MovieEntity>? moviesTopRated,
      String? message,
      bool? isRefresh,
      bool? isLoadMore,
      int? page,
      int? selectedGenreId,
      int? currentPage,
      double? minVoteAverage,
      List<MovieEntity>? originalMoviesTopRated}) {
    return TopRatedMovieState(
      status: status ?? this.status,
      moviesTopRated: moviesTopRated ?? this.moviesTopRated,
      message: message ?? this.message,
      isRefresh: isRefresh ?? this.isRefresh,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      page: page ?? this.page,
      selectedGenreId: selectedGenreId ?? this.selectedGenreId,
      currentPage: currentPage ?? this.currentPage,
      minVoteAverage: minVoteAverage ?? this.minVoteAverage,
    );
  }
}
