import 'package:equatable/equatable.dart';
import 'package:tuannq_movie/domain/movie/entity/movie_entity.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';

class NewMovieState extends Equatable {
  final Status? status;
  final bool? isRefresh;
  final bool? isLoadMore;
  final List<MovieEntity>? newMovies;
  final String? timeWindow;
  final String? message;
  final int currentPage;
  final int? selectedGenreId;
  final bool? isSelectedAll;

  const NewMovieState({
    this.status = Status.initial,
    this.message = '',
    this.isRefresh = false,
    this.isLoadMore = false,
    this.newMovies = const [],
    this.timeWindow,
    this.currentPage = 1,
    this.selectedGenreId,
    this.isSelectedAll = false,
  });

  @override
  List<Object?> get props =>
      [status, isRefresh, isLoadMore, newMovies, timeWindow, currentPage, selectedGenreId, isSelectedAll];

  NewMovieState copyWith({
    Status? status,
    bool? isRefresh,
    bool? isLoadMore,
    String? message,
    List<MovieEntity>? newMovies,
    String? timeWindow,
    int? currentPage,
    int? selectedGenreId,
    bool? isSelectedAll,
  }) {
    return NewMovieState(
      status: status ?? this.status,
      isRefresh: isRefresh ?? this.isRefresh,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      newMovies: newMovies ?? this.newMovies,
      timeWindow: timeWindow ?? this.timeWindow,
      message: message ?? this.message,
      currentPage: currentPage ?? this.currentPage,
      selectedGenreId: selectedGenreId ?? this.selectedGenreId,
      isSelectedAll: isSelectedAll ?? this.isSelectedAll,
    );
  }
}
