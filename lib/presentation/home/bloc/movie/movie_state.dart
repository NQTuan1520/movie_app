import 'package:equatable/equatable.dart';
import 'package:tuannq_movie/domain/movie/entity/movie_entity.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';

class MovieState extends Equatable {
  final String? errMessage;
  final bool? isRefresh;
  final bool? isLoadMore;
  final Status status;
  final List<MovieEntity> popularMovies;
  final List<MovieEntity> nowPlayingMovies;
  final List<MovieEntity> upcomingMovies;
  final List<MovieEntity> topRatedMovies;
  final List<MovieEntity> trendingMovies;
  final String? timeWindow;

  const MovieState({
    this.errMessage,
    this.isRefresh = false,
    this.isLoadMore = false,
    this.status = Status.initial,
    this.popularMovies = const [],
    this.nowPlayingMovies = const [],
    this.upcomingMovies = const [],
    this.topRatedMovies = const [],
    this.trendingMovies = const [],
    this.timeWindow,
  });

  MovieState copyWith({
    String? errMessage,
    bool? isRefresh,
    bool? isLoadMore,
    Status? status,
    List<MovieEntity>? popularMovies,
    List<MovieEntity>? nowPlayingMovies,
    List<MovieEntity>? upcomingMovies,
    List<MovieEntity>? topRatedMovies,
    List<MovieEntity>? trendingMovies,
    String? timeWindow,
  }) {
    return MovieState(
      errMessage: errMessage ?? this.errMessage,
      isRefresh: isRefresh ?? this.isRefresh,
      isLoadMore: isLoadMore ?? this.isLoadMore,
      status: status ?? this.status,
      popularMovies: popularMovies ?? this.popularMovies,
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      upcomingMovies: upcomingMovies ?? this.upcomingMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      trendingMovies: trendingMovies ?? this.trendingMovies,
      timeWindow: timeWindow ?? this.timeWindow,
    );
  }

  @override
  List<Object?> get props => [
        errMessage,
        isRefresh,
        isLoadMore,
        status,
        popularMovies,
        nowPlayingMovies,
        upcomingMovies,
        topRatedMovies,
        trendingMovies,
        timeWindow,
      ];
}
