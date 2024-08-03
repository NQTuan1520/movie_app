import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/core/theme/bloc/theme_event.dart';
import 'package:tuannq_movie/core/theme/bloc/theme_state.dart';

import '../theme.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(themeData: TAppTheme.lightTheme.themeData)) {
    on<ThemeEvent>(_mapThemeEventToState);
    on<ThemeChangeEvent>(_mapThemeChangeEvent);
  }

  FutureOr<void> _mapThemeEventToState(ThemeEvent event, Emitter<ThemeState> emit) {
    emit(ThemeLoading());
  }

  FutureOr<void> _mapThemeChangeEvent(ThemeChangeEvent event, Emitter<ThemeState> emit) async {
    emit(ThemeSuccess(themeData: event.themeData));
  }
}
