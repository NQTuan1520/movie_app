// setting_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/presentation/setting/bloc/setting/setting_event.dart';
import 'package:tuannq_movie/presentation/setting/bloc/setting/setting_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(const SettingState()) {
    on<LoadPreferencesEvent>(_onLoadPreferences);
    on<ChangeLanguageEvent>(_onChangeLanguage);
    on<ChangeThemeEvent>(_onChangeTheme);
    on<ChangeNotificationEvent>(_onChangeNotification);
  }

  Future<void> _onLoadPreferences(LoadPreferencesEvent event, Emitter<SettingState> emit) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? languageCode = pref.getString('language_code_${event.uid}');
    bool? darkMode = pref.getBool('theme_${event.uid}');
    bool? notification = pref.getBool('notification_${event.uid}');

    emit(state.copyWith(
      selectedLanguage: languageCode ?? 'en',
      isDarkMode: darkMode ?? false,
      isNotification: notification ?? false,
      uid: event.uid,
      isGuest: event.uid.isEmpty,
    ));
  }

  Future<void> _onChangeLanguage(ChangeLanguageEvent event, Emitter<SettingState> emit) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('language_code_${state.uid}', event.languageCode);
    emit(state.copyWith(selectedLanguage: event.languageCode));
  }

  Future<void> _onChangeTheme(ChangeThemeEvent event, Emitter<SettingState> emit) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('theme_${state.uid}', event.isDarkMode);
    emit(state.copyWith(isDarkMode: event.isDarkMode));
  }

  Future<void> _onChangeNotification(ChangeNotificationEvent event, Emitter<SettingState> emit) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('notification_${state.uid}', event.isNotification);
    emit(state.copyWith(isNotification: event.isNotification));
  }
}
