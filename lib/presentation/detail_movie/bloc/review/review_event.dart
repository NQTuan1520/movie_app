import 'package:equatable/equatable.dart';

class ReviewEvent extends Equatable {
  const ReviewEvent();

  @override

  List<Object?> get props => [];
}

class GetReviewEvent extends ReviewEvent {
  final int id;

  const GetReviewEvent(this.id);

  @override
  List<Object?> get props => [id];
}
