import 'package:equatable/equatable.dart';
import 'package:tuannq_movie/domain/people/entity/actor_entity.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';

class PeopleState extends Equatable {
  final Status? status;
  final String? messageError;
  final List<ActorEntity> peopleList;
  final bool? isRefresh;

  const PeopleState({
    this.status = Status.initial,
    this.messageError,
    this.peopleList = const [],
    this.isRefresh = false,
  });

  @override
  List<Object?> get props => [status, messageError, peopleList, isRefresh];

  PeopleState copyWith({
    Status? status,
    String? messageError,
    List<ActorEntity>? peopleList,
    bool? isRefresh,
  }) {
    return PeopleState(
      status: status ?? this.status,
      messageError: messageError ?? this.messageError,
      peopleList: peopleList ?? this.peopleList,
      isRefresh: isRefresh ?? this.isRefresh,
    );
  }
}
