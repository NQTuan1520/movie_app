// states.dart
import 'package:equatable/equatable.dart';
import 'package:tuannq_movie/manager/enum/stat_status_enum.dart';

class StatState extends Equatable {
  final StatStatus status;
  final Map<String, int> dailyUsageStats;
  final String errorMessage;

  const StatState({
    this.status = StatStatus.initial,
    this.dailyUsageStats = const {},
    this.errorMessage = '',
  });

  StatState copyWith({
    StatStatus? status,
    Map<String, int>? dailyUsageStats,
    String? errorMessage,
  }) {
    return StatState(
      status: status ?? this.status,
      dailyUsageStats: dailyUsageStats ?? this.dailyUsageStats,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, dailyUsageStats, errorMessage];
}
