import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/searchMovieBloc/search_movie_event.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/searchMovieBloc/search_movie_state.dart';

import '../../../../../core/resource/api/api_exception.dart';
import '../../../../../domain/search/usecase/search_usecase.dart';
import '../../../../../manager/enum/status_enum.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  SearchUseCase searchMovieUseCase;
  SearchMovieBloc(this.searchMovieUseCase) : super(const SearchMovieState()) {
    on<GetMovieBySearchEvent>(_getMovieBySearch, transformer: debounce(const Duration(milliseconds: 1000)));

    on<FilteredGetMovieBySearchEvent>(_getFilteredMovieBySearch);
  }

  Future<void> _getFilteredMovieBySearch(FilteredGetMovieBySearchEvent event, Emitter<SearchMovieState> emit) async {
    emit(state.copyWith(
      status: Status.loading,
      isAdult: event.isAdult,
      primaryReleaseYear: event.primaryReleaseYear,
      region: event.region,
    ));
    try {
      final response = await searchMovieUseCase.searchMovieByFilter(
        event.query,
        event.isAdult,
        event.primaryReleaseYear,
        event.region,
      );
      emit(state.copyWith(status: Status.success, movies: response.results));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  Future<void> _getMovieBySearch(GetMovieBySearchEvent event, Emitter<SearchMovieState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final response = await searchMovieUseCase.searchMovieByQuery(event.query);
      emit(state.copyWith(status: Status.success, movies: response.results));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  EventTransformer<Event> debounce<Event>(Duration duration) =>
      (events, mapper) => events.debounceTime(duration).switchMap(mapper);
}
