import 'package:equatable/equatable.dart';

import '../../../../domain/detail_people/entity/detail_person_entity.dart';
import '../../../../manager/enum/status_enum.dart';

class DetailPersonState extends Equatable {
  final String? message;
  final Status? status;
  final PersonDetail? personDetail;

  const DetailPersonState({
    this.message = '',
    this.status = Status.initial,
    this.personDetail = const PersonDetail(),
  });

  @override
  List<Object?> get props => [message, status, personDetail];

  DetailPersonState copyWith({
    String? message,
    Status? status,
    PersonDetail? personDetail,
  }) {
    return DetailPersonState(
      message: message ?? this.message,
      status: status ?? this.status,
      personDetail: personDetail ?? this.personDetail,
    );
  }
}
