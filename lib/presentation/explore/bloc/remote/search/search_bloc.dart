import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/search/search_event.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/search/search_state.dart';

import '../../../../../manager/enum/status_enum.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final FirebaseAuth _auth;

  SearchBloc(this._auth) : super(const SearchState()) {
    on<CheckUserStatusEvent>(_onCheckUserStatus);
  }

  Future<void> _onCheckUserStatus(CheckUserStatusEvent event, Emitter<SearchState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final user = _auth.currentUser;
      if (user == null || user.isAnonymous) {
        emit(state.copyWith(status: Status.success, isGuest: true));
      } else {
        emit(state.copyWith(status: Status.success, isGuest: false));
      }
    } catch (_) {
      emit(state.copyWith(status: Status.failure));
    }
  }
}
