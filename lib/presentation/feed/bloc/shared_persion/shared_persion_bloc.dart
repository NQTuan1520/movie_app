import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/domain/shared/usecase/shared_usecase.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_persion/shared_persion_event.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_persion/shared_persion_state.dart';

class SharedPersonBloc extends Bloc<SharedPersonEvent, SharedPersonState> {
  SharedPostUseCase postSharedUseCase;
  SharedPersonBloc(this.postSharedUseCase) : super(const SharedPersonState()) {
    on<GetShareEventById>(_getSharedByIdEvent);
  }

  Future<void> _getSharedByIdEvent(GetShareEventById event, Emitter<SharedPersonState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final sharedPosts = await postSharedUseCase.getSharedByIdUseCase(event.uid);

      emit(state.copyWith(status: Status.success, shared: sharedPosts, isFresh: true));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
