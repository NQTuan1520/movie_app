import 'package:equatable/equatable.dart';

class PeopleEvent extends Equatable {
  const PeopleEvent();

  @override
  List<Object?> get props => [];
}

class GetPopularPeopleEvent extends PeopleEvent {
  final bool isRefresh;

  const GetPopularPeopleEvent({this.isRefresh = false});

  @override
  List<Object?> get props => [isRefresh];
}
