import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/presentation/home/bloc/app_bar/app_bar_event.dart';
import 'package:tuannq_movie/presentation/home/bloc/app_bar/app_bar_state.dart';

class PageViewBloc extends Bloc<PageViewEvent, PageViewState> {
  late Timer _timer;

  PageViewBloc() : super(const PageViewState()) {
    on<PageChanged>(_onPageChanged);
    on<ResetPageTimer>(_onResetPageTimer);
    _startTimer();
  }

  void _onPageChanged(PageChanged event, Emitter<PageViewState> emit) {
    emit(state.copyWith(currentPage: event.newPage, status: PageViewStateStatus.pageChanged));
  }

  void _onResetPageTimer(ResetPageTimer event, Emitter<PageViewState> emit) {
    _timer.cancel();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      int nextPage = (state.currentPage + 1) % 5;
      add(PageChanged(nextPage));
    });
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
