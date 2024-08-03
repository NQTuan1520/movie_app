import 'package:equatable/equatable.dart';

abstract class InternetState extends Equatable {
  const InternetState();

  @override
  List<Object> get props => [];
}

class InternetInitial extends InternetState {}

class InternetConnectionSuccess extends InternetState {




  @override
  List<Object> get props => [];
}

class InternetConnectionFailure extends InternetState {}
