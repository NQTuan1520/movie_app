import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/tvShowPopularBloc/tv_show_popular_event.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/tvShowPopularBloc/tv_show_popular_state.dart';

import '../../../../../core/resource/api/api_exception.dart';
import '../../../../../domain/tv_show/usecase/tv_show_usecase.dart';
import '../../../../../manager/enum/status_enum.dart';

class TvShowPopularBloc extends Bloc<TvShowPopularEvent, TvShowPopularState> {
  TVShowUseCase tvShowUseCase;

  TvShowPopularBloc(this.tvShowUseCase) : super(const TvShowPopularState()) {
    on<GetTvShowPopularListEvent>(_getTvShowPopularList);
  }

  Future<void> _getTvShowPopularList(
    GetTvShowPopularListEvent event,
    Emitter<TvShowPopularState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final response = await tvShowUseCase.getTVShowPopularUseCase();
      emit(state.copyWith(status: Status.success, tvShowListPopular: response.results));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, messageError: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, messageError: e.toString()));
    }
  }
}
