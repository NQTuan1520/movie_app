import 'package:equatable/equatable.dart';

class KeywordEvent extends Equatable {
  const KeywordEvent();

  @override

  List<Object?> get props => [];
}

class GetKeywordBySearchEvent extends KeywordEvent {
  final String query;

  const GetKeywordBySearchEvent({this.query = ''});

  @override
  List<Object?> get props => [query];
}

class ClearKeywordSearchEvent extends KeywordEvent {}
