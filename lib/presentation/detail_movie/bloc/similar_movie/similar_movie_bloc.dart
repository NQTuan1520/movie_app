import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/presentation/detail_movie/bloc/similar_movie/similar_movie_event.dart';
import 'package:tuannq_movie/presentation/detail_movie/bloc/similar_movie/similar_movie_state.dart';

import '../../../../core/resource/api/api_exception.dart';
import '../../../../domain/movie/usecase/movie_usecase.dart';
import '../../../../manager/enum/status_enum.dart';

class SimilarMovieBloc extends Bloc<SimilarMovieEvent, SimilarMovieState> {
  MovieUseCase movieUseCase;

  SimilarMovieBloc(this.movieUseCase) : super(const SimilarMovieState()) {
    on<GetSimilarMovieListEvent>(_getSimilarMovieList);
    on<NavigatorActionPopEvent>(_navigatorActionPop);
  }

  Future<void> _navigatorActionPop(NavigatorActionPopEvent event, Emitter<SimilarMovieState> emit) async {
    emit(state.copyWith(status: Status.initial));
  }

  Future<void> _getSimilarMovieList(GetSimilarMovieListEvent event, Emitter<SimilarMovieState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final httpResponse = await movieUseCase.getMovieSimilarUseCase(event.id, 1);
      emit(state.copyWith(status: Status.success, listMovie: httpResponse.results));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
