import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/presentation/detail_movie/bloc/review/review_event.dart';
import 'package:tuannq_movie/presentation/detail_movie/bloc/review/review_state.dart';

import '../../../../core/resource/api/api_exception.dart';
import '../../../../domain/review/usecase/review_usecase.dart';
import '../../../../manager/enum/status_enum.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  ReviewUseCase reviewUseCase;
  ReviewBloc(this.reviewUseCase) : super(const ReviewState()) {
    on<GetReviewEvent>(_getReviewById);
  }

  Future<void> _getReviewById(GetReviewEvent event, Emitter<ReviewState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final response = await reviewUseCase.getReviewByIdUseCase(event.id);
      emit(state.copyWith(status: Status.success, reviews: response.results));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
