
import 'package:equatable/equatable.dart';

class TrendingMovieEvent extends Equatable {
  const TrendingMovieEvent();

  @override
  List<Object> get props => [];
}


class GetTrendingMoviesEvent extends TrendingMovieEvent {
  final bool isRefresh;
  final bool isSelectedAll;
  final bool isLoading;
  final String timeWindow;
  
  const GetTrendingMoviesEvent({this.isRefresh = false, this.timeWindow = 'day', this.isSelectedAll = false, this.isLoading = false});
  @override
  List<Object> get props => [isRefresh, timeWindow, isSelectedAll, isLoading];
}

class LoadMoreTrendingMoviesEvent extends TrendingMovieEvent {
  final String timeWindow;

  const LoadMoreTrendingMoviesEvent({this.timeWindow = 'day'});

  @override
  List<Object> get props => [timeWindow];
}

class FilterTrendingMoviesEvent extends TrendingMovieEvent {
  final int genreId;
  final String timeWindow;

  const FilterTrendingMoviesEvent(this.genreId, this.timeWindow);

  @override
  List<Object> get props => [genreId];
}
