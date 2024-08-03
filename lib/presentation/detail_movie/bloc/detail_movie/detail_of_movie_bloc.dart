import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resource/api/api_exception.dart';
import '../../../../domain/detail_movie/usecase/detail_movie_usecase.dart';
import '../../../../manager/enum/status_enum.dart';
import 'detail_of_movie_event.dart';
import 'detail_of_movie_state.dart';

class DetailOfMovieBloc extends Bloc<DetailOfMovieEvent, DetailOfMovieState> {
  DetailMovieUseCase detailMovieUseCase;

  DetailOfMovieBloc(this.detailMovieUseCase) : super(const DetailOfMovieState()) {
    on<GetDetailOfMovieEvent>(_getDetailOfMovie);
  }

  Future<void> _getDetailOfMovie(
    GetDetailOfMovieEvent event,
    Emitter<DetailOfMovieState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final response = await detailMovieUseCase.getDetailOfMovieDefaultUseCase(event.movieId);
      emit(state.copyWith(status: Status.success, movieDetail: response));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, errorMessage: e.message));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, errorMessage: e.toString()));
    }
  }
}
