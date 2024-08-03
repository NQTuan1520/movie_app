import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/cast/usecase/cast_usecase.dart';
import '../../../../manager/enum/status_enum.dart';
import 'cast_tv_event.dart';
import 'cast_tv_state.dart';

class CastTvBloc extends Bloc<CastTvEvent, CastTvState> {
  final CastUseCase creditUseCase;

  CastTvBloc(this.creditUseCase) : super(const CastTvState()) {
    on<GetCastTVDetailEvent>(_getCastTVDetail);
  }

  Future<void> _getCastTVDetail(GetCastTVDetailEvent event, Emitter<CastTvState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final cast = await creditUseCase.getCastOfDetailTvUseCase(event.tvId);
      emit(state.copyWith(status: Status.success, cast: cast.cast));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
