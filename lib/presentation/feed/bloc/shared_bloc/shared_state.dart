import 'package:equatable/equatable.dart';
import 'package:tuannq_movie/domain/shared/entity/shared_entity.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';

class SharedState extends Equatable {
  final Status? status;
  final List<SharedEntity>? shared;
  final SharedEntity? sharedEntity;
  final String? message;
  final bool? isFresh;

  const SharedState(
      {this.status = Status.initial,
      this.shared = const [],
      this.sharedEntity = const SharedEntity(),
      this.message = '',
      this.isFresh = false // Add this line
      });

  @override
  List<Object?> get props => [status, shared, sharedEntity, message, isFresh]; // Add likedPosts here

  SharedState copyWith({
    Status? status,
    List<SharedEntity>? shared,
    SharedEntity? sharedEntity,
    String? message,
    bool? isFresh, // Add this line
  }) {
    return SharedState(
      status: status ?? this.status,
      shared: shared ?? this.shared,
      sharedEntity: sharedEntity ?? this.sharedEntity,
      message: message ?? this.message,
      isFresh: isFresh ?? this.isFresh, // Add this line
    );
  }
}
