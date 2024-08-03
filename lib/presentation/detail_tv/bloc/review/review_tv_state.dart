import 'package:equatable/equatable.dart';

import '../../../../domain/review/entity/review_entity.dart';
import '../../../../manager/enum/status_enum.dart';

class ReviewTvState extends Equatable {
  final Status? status;
  final String? message;
  final List<ReviewEntity>? reviewList;

  const ReviewTvState({
    this.status = Status.initial,
    this.message = '',
    this.reviewList = const [],
  });

  ReviewTvState copyWith({
    Status? status,
    String? message,
    List<ReviewEntity>? reviewList,
  }) {
    return ReviewTvState(
      status: status ?? this.status,
      message: message ?? this.message,
      reviewList: reviewList ?? this.reviewList,
    );
  }

  @override
  List<Object?> get props => [status, message, reviewList];
}
