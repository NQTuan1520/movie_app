import 'package:equatable/equatable.dart';

import '../../../../domain/review/entity/review_entity.dart';
import '../../../../manager/enum/status_enum.dart';

class ReviewState extends Equatable {
  final Status? status;
  final List<ReviewEntity> reviews;
  final String? message;
  const ReviewState({
    this.status = Status.initial,
    this.reviews = const [],
    this.message,
  });

  @override
  List<Object?> get props => [status, reviews, message];

  ReviewState copyWith({
    Status? status,
    List<ReviewEntity>? reviews,
    String? message,
  }) {
    return ReviewState(
      status: status ?? this.status,
      reviews: reviews ?? this.reviews,
      message: message ?? this.message,
    );
  }
}
