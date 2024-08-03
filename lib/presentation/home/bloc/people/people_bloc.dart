import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/domain/people/usecase/people_usecase.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/home/bloc/people/people_event.dart';
import 'package:tuannq_movie/presentation/home/bloc/people/people_state.dart';

import '../../../../core/resource/api/api_exception.dart';

class PeopleBloc extends Bloc<PeopleEvent, PeopleState> {
  PeopleUseCase peopleUseCase;
  PeopleBloc(this.peopleUseCase) : super(const PeopleState()) {
    on<GetPopularPeopleEvent>(_getPopularPeople);
  }

  Future<void> _getPopularPeople(GetPopularPeopleEvent event, Emitter<PeopleState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final dataState = await peopleUseCase.getPopularPeopleUseCase();
      emit(state.copyWith(
        status: Status.success,
        peopleList: dataState.results,
      ));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, messageError: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, messageError: e.toString()));
    }
  }
}
