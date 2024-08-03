import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/core/resource/api/api_exception.dart';
import 'package:tuannq_movie/domain/movie/entity/movie_entity.dart';
import 'package:tuannq_movie/domain/movie/usecase/movie_usecase.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/see_all_top_rated/bloc/top_rated/top_rated_movie_event.dart';
import 'package:tuannq_movie/presentation/see_all_top_rated/bloc/top_rated/top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final MovieUseCase movieUseCase;
  TopRatedMovieBloc(this.movieUseCase) : super(const TopRatedMovieState()) {
    on<GetTopRatedMovieEvent>(_getTopRatedMovies);
    on<LoadMoreTopRatedMovieEvent>(_loadMoreTopRatedMovies);
    on<UpdateFilterEvent>(_updateFilter);
  }

  Future<void> _getTopRatedMovies(GetTopRatedMovieEvent event, Emitter<TopRatedMovieState> emit) async {
    emit(state.copyWith(isRefresh: event.isRefresh, status: Status.loading, currentPage: 1));
    try {
      final dataState = await movieUseCase.getTopRatedMovieUseCase(1);
      emit(
        state.copyWith(
          status: Status.success,
          moviesTopRated: dataState.results,
          isRefresh: false,
          currentPage: 1,
        ),
      );
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  Future<void> _loadMoreTopRatedMovies(LoadMoreTopRatedMovieEvent event, Emitter<TopRatedMovieState> emit) async {
    emit(state.copyWith(isLoadMore: true, status: Status.loading));
    try {
      final nextPage = state.currentPage! + 1;
      final dataState = await movieUseCase.getTopRatedMovieUseCase(nextPage);
      final updatedMovies = List<MovieEntity>.from(state.moviesTopRated!)..addAll(dataState.results ?? []);

      emit(
        state.copyWith(
          status: Status.success,
          moviesTopRated: updatedMovies,
          isLoadMore: false,
          currentPage: nextPage,
        ),
      );
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  void _updateFilter(UpdateFilterEvent event, Emitter<TopRatedMovieState> emit) {
    final filteredMovies = state.moviesTopRated!.where((movie) => movie.voteAverage! >= event.minVoteAverage).toList();
    emit(state.copyWith(
      status: Status.success,
      minVoteAverage: event.minVoteAverage,
      moviesTopRated: filteredMovies,
    ));
  }
}
