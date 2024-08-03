 import 'package:equatable/equatable.dart';

class ReviewTvEvent extends Equatable {

  const ReviewTvEvent();

  @override
  List<Object> get props => [];
}

class GetReviewTVShowEvent extends ReviewTvEvent {
  final int id;

  const GetReviewTVShowEvent(this.id);

  @override
  List<Object> get props => [id];
}
