import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'internet_event.dart';
import 'internet_state.dart';

class InternetBloc extends Bloc<InternetEvent, InternetState> {
  // ignore: unused_field
  final Connectivity _connectivity;
  StreamSubscription? connection;

  InternetBloc(this._connectivity) : super(InternetInitial()) {
    on<InternetConnected>(_onInternetConnected);
    on<InternetDisconnected>(_onInternetDisconnected);
    on<CheckInternet>(_onCheckInternet);

    connection = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // whenever connection status is changed.
      if (results.contains(ConnectivityResult.none)) {
        add(InternetDisconnected());
      } else {
        add(InternetConnected(results));
      }
    });
  }

  void _onInternetConnected(InternetConnected event, Emitter<InternetState> emit) {
    emit(InternetConnectionSuccess());
  }

  void _onInternetDisconnected(InternetDisconnected event, Emitter<InternetState> emit) {
    emit(InternetConnectionFailure());
  }

  Future<void> _onCheckInternet(CheckInternet event, Emitter<InternetState> emit) async {
    connection = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> results) {
      // whenever connection status is changed.
      if (results.contains(ConnectivityResult.none)) {
        emit(InternetConnectionFailure());
      } else {
        emit(InternetConnectionSuccess());
      }
    });
  }

  @override
  Future<void> close() {
    connection?.cancel();
    return super.close();
  }
}
