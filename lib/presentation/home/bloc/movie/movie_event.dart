import 'package:equatable/equatable.dart';

class MovieEvent extends Equatable {
  const MovieEvent();

  @override

  List<Object?> get props => [];
}

class GetMoviesPopularEvent extends MovieEvent {
  final bool isRefresh;

  const GetMoviesPopularEvent({this.isRefresh = false});

  @override
  List<Object?> get props => [isRefresh];
}

class GetMoviesNowPlayingEvent extends MovieEvent {
  final bool isRefresh;

  const GetMoviesNowPlayingEvent({this.isRefresh = false});

  @override
  List<Object?> get props => [isRefresh];
}

class GetMoviesUpcomingEvent extends MovieEvent {
  final bool isRefresh;

  const GetMoviesUpcomingEvent({this.isRefresh = false});

  @override
  List<Object?> get props => [isRefresh];
}

class GetMoviesTopRatedEvent extends MovieEvent {
  final bool isRefresh;

  const GetMoviesTopRatedEvent({this.isRefresh = false});

  @override
  List<Object?> get props => [isRefresh];
}

class GetMoviesTrendingEvent extends MovieEvent {
  final bool isRefresh;
  final String timeWindow;

  const GetMoviesTrendingEvent({this.isRefresh = false, this.timeWindow = 'week'});
  @override
  List<Object?> get props => [isRefresh, timeWindow];
}

class ChangeTimeWindowEvent extends MovieEvent {
  final String timeWindow;

  const ChangeTimeWindowEvent(this.timeWindow);

  @override
  List<Object?> get props => [timeWindow];
}
