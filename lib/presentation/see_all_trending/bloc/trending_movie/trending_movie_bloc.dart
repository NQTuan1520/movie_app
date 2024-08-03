import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/core/resource/api/api_exception.dart';
import 'package:tuannq_movie/domain/movie/entity/movie_entity.dart';
import 'package:tuannq_movie/domain/movie/usecase/movie_usecase.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/see_all_trending/bloc/trending_movie/trending_movie_event.dart';
import 'package:tuannq_movie/presentation/see_all_trending/bloc/trending_movie/trending_movie_state.dart';

class TrendingMovieBloc extends Bloc<TrendingMovieEvent, TrendingMovieState> {
  final MovieUseCase movieUseCase;

  TrendingMovieBloc(this.movieUseCase) : super(const TrendingMovieState()) {
    on<GetTrendingMoviesEvent>(_getTrendingMovies);
    on<LoadMoreTrendingMoviesEvent>(_loadMoreTrendingMovies);
    on<FilterTrendingMoviesEvent>(_filterTrendingMovies);
  }

  Future<void> _getTrendingMovies(GetTrendingMoviesEvent event, Emitter<TrendingMovieState> emit) async {
    emit(state.copyWith(
      isRefresh: event.isRefresh,
      status: Status.loading,
      currentPage: 1,
    ));
    try {
      // Simulate loading
      final dataState = await movieUseCase.getTrendingMovieUseCase(event.timeWindow, 1);
      // final filteredMovies =
      //     _filterMoviesByGenre(dataState.results, state.selectedGenreId);

      emit(state.copyWith(
        status: Status.success,
        trendingMovies: dataState.results,
        isRefresh: false,
        timeWindow: event.timeWindow,
        isSelectedAll: event.isSelectedAll,
        currentPage: 1,
      ));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  Future<void> _loadMoreTrendingMovies(LoadMoreTrendingMoviesEvent event, Emitter<TrendingMovieState> emit) async {
    emit(state.copyWith(isLoadMore: true, status: Status.loading));
    try {
      final nextPage = state.currentPage + 1;
      final dataState = await movieUseCase.getTrendingMovieUseCase(event.timeWindow, nextPage);
      final updatedMovies = List<MovieEntity>.from(state.trendingMovies!)..addAll(dataState.results ?? []);
      emit(state.copyWith(
          status: Status.success,
          trendingMovies: updatedMovies,
          isLoadMore: false,
          timeWindow: event.timeWindow,
          currentPage: nextPage));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  Future<void> _filterTrendingMovies(FilterTrendingMoviesEvent event, Emitter<TrendingMovieState> emit) async {
    emit(state.copyWith(isRefresh: true, status: Status.loading, selectedGenreId: event.genreId));
    try {
      final dataState =
          await movieUseCase.getTrendingMovieUseCase(event.timeWindow, 1); // Replace with your time window logic
      final filteredMovies = _filterMoviesByGenre(dataState.results, event.genreId);

      emit(state.copyWith(
          status: Status.success,
          trendingMovies: filteredMovies,
          isRefresh: false,
          currentPage: 1,
          timeWindow: event.timeWindow,
          isSelectedAll: false,
          selectedGenreId: event.genreId));
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
