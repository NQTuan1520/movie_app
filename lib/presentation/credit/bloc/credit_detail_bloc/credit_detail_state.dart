import 'package:equatable/equatable.dart';

import '../../../../domain/creadit/entity/credit_entity.dart';
import '../../../../manager/enum/status_enum.dart';

class CreditDetailState extends Equatable {
  final String? errorMessage;
  final Status? status;
  final CreditEntity creditEntity;
  const CreditDetailState({
    this.status = Status.initial,
    this.creditEntity = const CreditEntity(),
    this.errorMessage,
  });

  CreditDetailState copyWith({
    Status? status,
    CreditEntity? creditEntity,
    String? errorMessage,
  }) {
    return CreditDetailState(
      status: status ?? this.status,
      creditEntity: creditEntity ?? this.creditEntity,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, creditEntity, errorMessage];
}
