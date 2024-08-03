import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/cast/usecase/cast_usecase.dart';
import '../../../../manager/enum/status_enum.dart';
import 'cast_event.dart';
import 'cast_state.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  final CastUseCase castUseCase;
  CastBloc(this.castUseCase) : super(const CastState()) {
    on<GetCastDetailOfMovieEvent>(_getCastDetailOfMovie);
  }

  Future<void> _getCastDetailOfMovie(GetCastDetailOfMovieEvent event, Emitter<CastState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final response = await castUseCase.getCastOfDetailMovieUseCase(event.id);
      emit(state.copyWith(status: Status.success, casts: response.cast));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, messageError: e.toString()));
    }
  }
}
