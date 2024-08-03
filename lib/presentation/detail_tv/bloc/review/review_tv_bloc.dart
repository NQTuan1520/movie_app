import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/presentation/detail_tv/bloc/review/review_tv_event.dart';
import 'package:tuannq_movie/presentation/detail_tv/bloc/review/review_tv_state.dart';

import '../../../../domain/review/usecase/review_usecase.dart';
import '../../../../manager/enum/status_enum.dart';

class ReviewTvBloc extends Bloc<ReviewTvEvent, ReviewTvState> {
  final ReviewUseCase reviewUseCase;
  ReviewTvBloc(this.reviewUseCase) : super(const ReviewTvState()) {
    on<GetReviewTVShowEvent>(_getReviewTvShow);
  }

  void _getReviewTvShow(GetReviewTVShowEvent event, Emitter<ReviewTvState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final response = await reviewUseCase.getReviewByTvShowIdUseCase(event.id);
      emit(state.copyWith(status: Status.success, reviewList: response.results));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
