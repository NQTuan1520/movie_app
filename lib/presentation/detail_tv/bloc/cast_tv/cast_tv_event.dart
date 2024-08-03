

 import 'package:equatable/equatable.dart';

class CastTvEvent extends Equatable {
  const CastTvEvent();

  @override
  List<Object> get props => [];
}

class GetCastTVDetailEvent extends CastTvEvent {
  final int tvId;

  const GetCastTVDetailEvent(this.tvId);

  @override
  List<Object> get props => [tvId];
}
