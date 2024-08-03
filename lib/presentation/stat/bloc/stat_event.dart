// events.dart
import 'package:equatable/equatable.dart';

abstract class StatEvent extends Equatable {
  const StatEvent();

  @override
  List<Object> get props => [];
}

class LoadDailyUsageStats extends StatEvent {
  final String uid;

  const LoadDailyUsageStats(this.uid);

  @override
  List<Object> get props => [uid];
}
