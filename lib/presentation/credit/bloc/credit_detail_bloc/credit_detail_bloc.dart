import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/resource/api/api_exception.dart';
import '../../../../domain/creadit/usecase/credit_usecase.dart';
import '../../../../manager/enum/status_enum.dart';
import 'credit_detail_event.dart';
import 'credit_detail_state.dart';

class CreditDetailBloc extends Bloc<CreditDetailEvent, CreditDetailState> {
  CreditUseCase creditUseCase;
  CreditDetailBloc(this.creditUseCase) : super(const CreditDetailState()) {
    on<GetDetailCreditEvent>(_getDetailCredit);
  }

  Future<void> _getDetailCredit(GetDetailCreditEvent event, Emitter<CreditDetailState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final creditEntity = await creditUseCase.getDetailCreditUseCase(event.id);
      emit(state.copyWith(status: Status.success, creditEntity: creditEntity));
    } on ApiException catch (e) {
      emit(state.copyWith(status: Status.failure, errorMessage: e.toString()));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, errorMessage: e.toString()));
    }
  }
}
