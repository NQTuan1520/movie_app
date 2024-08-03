import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/detail_people/usecase/detail_person_usecase.dart';
import '../../../../manager/enum/status_enum.dart';
import 'detail_person_event.dart';
import 'detail_person_state.dart';

class DetailPersonBloc extends Bloc<DetailPersonEvent, DetailPersonState> {
  final DetailPersonUsecase personDetailUseCase;
  DetailPersonBloc(this.personDetailUseCase) : super(const DetailPersonState()) {
    on<GetDetailOfPersonEvent>(_getDetailOfPerson);
  }

  Future<void> _getDetailOfPerson(GetDetailOfPersonEvent event, Emitter<DetailPersonState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final personDetail = await personDetailUseCase.getPersonDetail(event.personId);
      emit(state.copyWith(status: Status.success, personDetail: personDetail));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
