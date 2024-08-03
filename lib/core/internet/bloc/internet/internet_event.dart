import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

abstract class InternetEvent extends Equatable {
  const InternetEvent();

  @override
  List<Object> get props => [];
}

class InternetConnected extends InternetEvent {
  final List<ConnectivityResult> connectionType;

  const InternetConnected(this.connectionType);

  @override
  List<Object> get props => [connectionType];
}

class InternetDisconnected extends InternetEvent {}

class CheckInternet extends InternetEvent {}
