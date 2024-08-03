

import 'package:equatable/equatable.dart';

class SimilarTvShowEvent extends Equatable {
  const SimilarTvShowEvent();

  @override
  List<Object> get props => [];
}

class GetSimilarTVEvent extends SimilarTvShowEvent {
  final String seriesID;

  const GetSimilarTVEvent(this.seriesID);

  @override
  List<Object> get props => [seriesID];
}


