import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/core/resource/api/api_exception.dart';
import 'package:tuannq_movie/domain/movie/usecase/movie_usecase.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/home/bloc/movie/movie_event.dart';
import 'package:tuannq_movie/presentation/home/bloc/movie/movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  MovieUseCase movieUseCase;

  MovieBloc(
    this.movieUseCase,
  ) : super(const MovieState()) {
    on<GetMoviesNowPlayingEvent>(_getNowPlayingMovie);
    on<GetMoviesTopRatedEvent>(_getTopRatedMovie);
    on<GetMoviesUpcomingEvent>(_getUpComingMovie);
    on<GetMoviesPopularEvent>(_getPopularMovie);
    on<GetMoviesTrendingEvent>(_getTrendingMovie);
    on<ChangeTimeWindowEvent>(_changeTimeWindow);
  }

  Future<void> _changeTimeWindow(ChangeTimeWindowEvent event, Emitter<MovieState> emit) async {
    emit(state.copyWith(timeWindow: event.timeWindow));
    add(GetMoviesTrendingEvent(timeWindow: event.timeWindow));
  }

  Future<void> _getTrendingMovie(GetMoviesTrendingEvent event, Emitter<MovieState> emit) async {
    emit(state.copyWith(isRefresh: event.isRefresh, status: Status.loading));
    try {
      final dataState = await movieUseCase.getTrendingMovieUseCase(event.timeWindow, 1);
      emit(state.copyWith(status: Status.success, trendingMovies: dataState.results));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, errMessage: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, errMessage: e.toString()));
    }
  }

  Future<void> _getNowPlayingMovie(GetMoviesNowPlayingEvent event, Emitter<MovieState> emit) async {
    emit(state.copyWith(isRefresh: event.isRefresh, status: Status.loading));
    try {
      final dataState = await movieUseCase.getNowPlayingMovieUseCase(1);
      emit(state.copyWith(status: Status.success, nowPlayingMovies: dataState.results));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, errMessage: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, errMessage: e.toString()));
    }
  }

  Future<void> _getTopRatedMovie(GetMoviesTopRatedEvent event, Emitter<MovieState> emit) async {
    emit(state.copyWith(isRefresh: event.isRefresh, status: Status.loading));
    try {
      final dataState = await movieUseCase.getTopRatedMovieUseCase(1);
      emit(state.copyWith(status: Status.success, topRatedMovies: dataState.results));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, errMessage: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, errMessage: e.toString()));
    }
  }

  Future<void> _getUpComingMovie(GetMoviesUpcomingEvent event, Emitter<MovieState> emit) async {
    emit(state.copyWith(isRefresh: event.isRefresh, status: Status.loading));
    try {
      final dataState = await movieUseCase.getUpComingMovieUseCase(1);
      emit(state.copyWith(status: Status.success, upcomingMovies: dataState.results));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, errMessage: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, errMessage: e.toString()));
    }
  }

  Future<void> _getPopularMovie(GetMoviesPopularEvent event, Emitter<MovieState> emit) async {
    emit(state.copyWith(isRefresh: event.isRefresh, status: Status.loading));
    try {
      final dataState = await movieUseCase.getPopularMovieUseCase();
      emit(state.copyWith(status: Status.success, popularMovies: dataState.results));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, errMessage: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, errMessage: e.toString()));
    }
  }
}
