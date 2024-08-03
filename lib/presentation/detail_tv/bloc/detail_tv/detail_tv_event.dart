
 import 'package:equatable/equatable.dart';

class DetailTvEvent extends Equatable {
  const DetailTvEvent();

  @override
  List<Object> get props => [];
}

class GetDetailTvEvent extends DetailTvEvent {
  final int id;

  const GetDetailTvEvent(this.id);

  @override
  List<Object> get props => [id];
}
