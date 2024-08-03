import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/core/resource/api/api_exception.dart';
import 'package:tuannq_movie/domain/genres/usecase/genres_usecase.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/home/bloc/genres/genres_event.dart';
import 'package:tuannq_movie/presentation/home/bloc/genres/genres_state.dart';

class GenresBloc extends Bloc<GenresEvent, GenresState> {
  final GenresUseCase genresUseCase;
  GenresBloc(this.genresUseCase) : super(const GenresState()) {
    on<GetGenres>(_getGenres);
  }

  Future<void> _getGenres(GetGenres event, Emitter emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final result = await genresUseCase.getGenres();
      emit(state.copyWith(status: Status.success, genres: result.genres));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
