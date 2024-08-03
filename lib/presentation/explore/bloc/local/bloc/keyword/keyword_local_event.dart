import 'package:equatable/equatable.dart';

class KeywordLocalEvent extends Equatable {
  const KeywordLocalEvent();

  @override
  List<Object?> get props => [];
}

class RemoveKeywordEvent extends KeywordLocalEvent {
  final int idKeyword;
  const RemoveKeywordEvent({required this.idKeyword});
}

class AddKeywordEvent extends KeywordLocalEvent {
  final String keyword;
  const AddKeywordEvent({required this.keyword});
}

class GetStoredKeywordsEvent extends KeywordLocalEvent {}
