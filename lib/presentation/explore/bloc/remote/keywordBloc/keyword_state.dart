import 'package:equatable/equatable.dart';

import '../../../../../domain/keyword/entity/key_word_entity.dart';
import '../../../../../manager/enum/status_enum.dart';

class KeywordState extends Equatable {
  final Status? status;
  final List<KeywordEntity> listKeyword;
  final String? message;
  final String? query;
  const KeywordState({
    this.status = Status.initial,
    this.listKeyword = const [],
    this.message,
    this.query = '',
  });

  @override
  List<Object?> get props => [status, listKeyword, message, query];

  KeywordState copyWith({
    Status? status,
    List<KeywordEntity>? listKeyword,
    String? message,
    String? query,
  }) {
    return KeywordState(
      status: status ?? this.status,
      listKeyword: listKeyword ?? this.listKeyword,
      message: message ?? this.message,
      query: query ?? this.query,
    );
  }
}
