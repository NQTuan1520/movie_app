import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/core/time_tracking/time_tracker.dart';
import 'package:tuannq_movie/manager/enum/stat_status_enum.dart';
import 'package:tuannq_movie/presentation/stat/bloc/stat_event.dart';
import 'package:tuannq_movie/presentation/stat/bloc/stat_state.dart';

class StatBloc extends Bloc<StatEvent, StatState> {
  final TimeTracker timeTracker;

  StatBloc(this.timeTracker) : super(const StatState()) {
    on<LoadDailyUsageStats>(_onLoadDailyUsageStats);
  }

  Future<void> _onLoadDailyUsageStats(
    LoadDailyUsageStats event,
    Emitter<StatState> emit,
  ) async {
    emit(state.copyWith(status: StatStatus.loading));
    try {
      await timeTracker.init(event.uid);
      final now = DateTime.now();
      final trackerDaily = await timeTracker.getDailyUsageStats(
        now.subtract(const Duration(days: 7)),
        7,
      );
      emit(state.copyWith(
        status: StatStatus.success,
        dailyUsageStats: trackerDaily,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: StatStatus.failure,
        errorMessage: error.toString(),
      ));
    }
  }
}
