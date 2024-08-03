import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/core/resource/api/api_exception.dart';
import 'package:tuannq_movie/domain/shared/usecase/shared_usecase.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_bloc/shared_event.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_bloc/shared_state.dart';

class SharedBloc extends Bloc<SharedEvent, SharedState> {
  SharedPostUseCase postSharedUseCase;

  SharedBloc(
    this.postSharedUseCase,
  ) : super(const SharedState()) {
    on<PostSharedEvent>(_postSharedEvent);
    on<GetAllSharedEvent>(_getAllSharedEvent);

    on<DeleteSharedEvent>(_deleteSharedEvent);
    on<UpdateSharedEvent>(_updateSharedEvent);
    on<GetSharedEvent>(_getSharedByIDEvent);
  }

  Future<void> _getSharedByIDEvent(GetSharedEvent event, Emitter<SharedState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final sharedPosts = await postSharedUseCase.getSharedByIdUseCase(event.uid);
      emit(state.copyWith(status: Status.success, shared: sharedPosts, isFresh: true));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  Future<void> _updateSharedEvent(UpdateSharedEvent event, Emitter<SharedState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final sharedEntity = await postSharedUseCase.updateSharedUseCase(event.sharedEntity, event.id);
      final sharedPosts = await postSharedUseCase.getAllSharedUseCase();

      emit(state.copyWith(status: Status.success, sharedEntity: sharedEntity, shared: sharedPosts));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  Future<void> _deleteSharedEvent(DeleteSharedEvent event, Emitter<SharedState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final sharedEntity = await postSharedUseCase.deleteSharedUseCase(event.id);
      final sharedPosts = await postSharedUseCase.getAllSharedUseCase();

      emit(state.copyWith(status: Status.success, sharedEntity: sharedEntity, shared: sharedPosts));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  Future<void> _getAllSharedEvent(GetAllSharedEvent event, Emitter<SharedState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final sharedPosts = await postSharedUseCase.getAllSharedUseCase();

      emit(state.copyWith(status: Status.success, shared: sharedPosts));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  Future<void> _postSharedEvent(PostSharedEvent event, Emitter<SharedState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final sharedEntity = await postSharedUseCase.postSharedUseCase(event.sharedEntity);
      final sharedPosts = await postSharedUseCase.getAllSharedUseCase();
      emit(state.copyWith(status: Status.success, sharedEntity: sharedEntity, shared: sharedPosts));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.message));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
