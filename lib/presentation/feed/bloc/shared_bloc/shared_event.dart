import 'package:equatable/equatable.dart';
import 'package:tuannq_movie/domain/shared/entity/shared_entity.dart';

class SharedEvent extends Equatable {
  const SharedEvent();

  @override
  List<Object?> get props => [];
}

class PostSharedEvent extends SharedEvent {
  final SharedEntity sharedEntity;
  const PostSharedEvent({required this.sharedEntity});

  @override
  List<Object?> get props => [sharedEntity];
}

class UpdateSharedEvent extends SharedEvent {
  final SharedEntity sharedEntity;
  final String id;
  const UpdateSharedEvent({required this.sharedEntity, required this.id});

  @override
  List<Object?> get props => [sharedEntity];
}

class GetAllSharedEvent extends SharedEvent {
  const GetAllSharedEvent();

  @override
  List<Object?> get props => [];
}

class LikeSharedEvent extends SharedEvent {
  final SharedEntity sharedEntity;
  final String id;

  const LikeSharedEvent({required this.sharedEntity, required this.id});

  @override
  List<Object?> get props => [sharedEntity];
}

class DeleteSharedEvent extends SharedEvent {
  final String id;
  const DeleteSharedEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class GetSharedEvent extends SharedEvent {
  final String uid;
  const GetSharedEvent({required this.uid});

  @override
  List<Object?> get props => [uid];
}
