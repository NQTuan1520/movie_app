

 import 'package:equatable/equatable.dart';

class NewMovieEvent extends Equatable {
  const NewMovieEvent();

  @override
  List<Object> get props => [];
}

class GetNewMoviesEvent extends NewMovieEvent {
  final bool isRefresh;
  final bool isSelectedAll;


  const GetNewMoviesEvent({this.isRefresh = false, this.isSelectedAll = false});
  @override
  List<Object> get props => [isRefresh, isSelectedAll];
}

class LoadMoreNewMoviesEvent extends NewMovieEvent {
  const LoadMoreNewMoviesEvent();
}

class FilterNewMoviesEvent extends NewMovieEvent {
  final int genreId;

  const FilterNewMoviesEvent(this.genreId);

  @override
  List<Object> get props => [genreId];
}
