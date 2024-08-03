

import 'package:equatable/equatable.dart';

 class TopRatedMovieEvent extends Equatable {
  const TopRatedMovieEvent();

  @override
  List<Object> get props => [];
}

class GetTopRatedMovieEvent extends  TopRatedMovieEvent {
  final bool isRefresh;

  const GetTopRatedMovieEvent({this.isRefresh = false});


  
  @override
  List<Object> get props => [isRefresh];
}

class LoadMoreTopRatedMovieEvent extends TopRatedMovieEvent {
  const LoadMoreTopRatedMovieEvent();
}

class UpdateFilterEvent extends TopRatedMovieEvent {
  final double minVoteAverage;
  const UpdateFilterEvent(this.minVoteAverage);

  @override
  List<Object> get props => [minVoteAverage];
}
