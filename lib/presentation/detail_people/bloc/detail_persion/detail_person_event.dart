

 import 'package:equatable/equatable.dart';

class DetailPersonEvent extends Equatable {
  const DetailPersonEvent();

  @override
  List<Object> get props => [];
}

class GetDetailOfPersonEvent extends DetailPersonEvent {
  final int personId;

  const GetDetailOfPersonEvent(this.personId);

  @override
  List<Object> get props => [personId];
}
