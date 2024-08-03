import 'package:equatable/equatable.dart';

class SearchMovieEvent extends Equatable {
  const SearchMovieEvent();

  @override
  List<Object?> get props => [];
}

class GetMovieBySearchEvent extends SearchMovieEvent {
  final String query;

  const GetMovieBySearchEvent({this.query = ''});

  @override
  List<Object?> get props => [query];
}

class FilteredGetMovieBySearchEvent extends SearchMovieEvent {
  final String query;
  final bool isAdult;
  final String primaryReleaseYear;
  final String region;

  const FilteredGetMovieBySearchEvent({
    this.query = '',
    required this.isAdult,
    required this.primaryReleaseYear,
    required this.region,
  });

  @override
  List<Object?> get props => [query, isAdult, primaryReleaseYear, region];
}
