import 'package:equatable/equatable.dart';

class CreditDetailEvent extends Equatable {
  const CreditDetailEvent();

  @override

  List<Object?> get props => [];
}

class GetDetailCreditEvent extends CreditDetailEvent {
  final String id;

  const GetDetailCreditEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
