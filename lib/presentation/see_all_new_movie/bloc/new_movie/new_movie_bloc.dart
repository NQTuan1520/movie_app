import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/core/resource/api/api_exception.dart';
import 'package:tuannq_movie/domain/movie/entity/movie_entity.dart';
import 'package:tuannq_movie/domain/movie/usecase/movie_usecase.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/see_all_new_movie/bloc/new_movie/new_movie_event.dart';
import 'package:tuannq_movie/presentation/see_all_new_movie/bloc/new_movie/new_movie_state.dart';

class NewMovieBloc extends Bloc<NewMovieEvent, NewMovieState> {
  final MovieUseCase movieUseCase;
  NewMovieBloc(this.movieUseCase) : super(const NewMovieState()) {
    on<GetNewMoviesEvent>(_getNewMovies);
    on<LoadMoreNewMoviesEvent>(_loadMoreNewMovies);
    on<FilterNewMoviesEvent>(_filterNewMovies);
  }

  Future<void> _getNewMovies(GetNewMoviesEvent event, Emitter<NewMovieState> emit) async {
    emit(state.copyWith(isRefresh: event.isRefresh, status: Status.loading, currentPage: 1));
    try {
      final dataState = await movieUseCase.getUpComingMovieUseCase(1);
      emit(state.copyWith(
          status: Status.success,
          newMovies: dataState.results,
          isSelectedAll: event.isSelectedAll,
          isRefresh: false,
          currentPage: 1));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  Future<void> _loadMoreNewMovies(LoadMoreNewMoviesEvent event, Emitter<NewMovieState> emit) async {
    emit(state.copyWith(
      isLoadMore: true,
      status: Status.loading,
    ));
    try {
      final nextPage = state.currentPage + 1;
      final dataState = await movieUseCase.getUpComingMovieUseCase(nextPage);
      final updatedMovies = List<MovieEntity>.from(state.newMovies!)..addAll(dataState.results ?? []);
      emit(state.copyWith(
        status: Status.success,
        newMovies: updatedMovies,
        isLoadMore: false,
        currentPage: nextPage,
      ));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  Future<void> _filterNewMovies(FilterNewMoviesEvent event, Emitter<NewMovieState> emit) async {
    emit(state.copyWith(status: Status.loading, selectedGenreId: event.genreId));
    try {
      final dataState = await movieUseCase.getUpComingMovieUseCase(1);
      final filteredMovies = _filterMoviesByGenre(dataState.results, event.genreId);
      emit(state.copyWith(
          status: Status.success,
          newMovies: filteredMovies,
          currentPage: 1,
          selectedGenreId: event.genreId,
          isSelectedAll: false,
          isRefresh: false));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  List<MovieEntity>? _filterMoviesByGenre(List<MovieEntity>? movies, int? genreId) {
    return genreId != null ? movies?.where((movie) => movie.genreIds?.contains(genreId) ?? false).toList() : movies;
  }
}
