import 'package:equatable/equatable.dart';

import '../../../../../../domain/keyword/entity/key_word_entity.dart';
import '../../../../../../manager/enum/status_enum.dart';

class KeywordLocalState extends Equatable {
  final Status status;
  final List<KeywordEntity> listKeyword;
  final String? message;

  const KeywordLocalState({
    this.status = Status.initial,
    this.listKeyword = const [],
    this.message = '',
  });

  KeywordLocalState copyWith({
    Status? status,
    List<KeywordEntity>? listKeyword,
    String? message,
  }) {
    return KeywordLocalState(
      status: status ?? this.status,
      listKeyword: listKeyword ?? this.listKeyword,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, listKeyword, message];
}
