// setting_event.dart
import 'package:equatable/equatable.dart';

class SettingEvent extends Equatable {
  const SettingEvent();

  @override
  List<Object?> get props => [];
}

class LoadPreferencesEvent extends SettingEvent {
  final String uid;
  
  const LoadPreferencesEvent(this.uid);

  @override
  List<Object?> get props => [uid];
}

class ChangeLanguageEvent extends SettingEvent {
  final String languageCode;
  
  const ChangeLanguageEvent(this.languageCode);

  @override
  List<Object?> get props => [languageCode];
}

class ChangeThemeEvent extends SettingEvent {
  final bool isDarkMode;

  const ChangeThemeEvent(this.isDarkMode);

  @override
  List<Object?> get props => [isDarkMode];
}

class ChangeNotificationEvent extends SettingEvent {
  final bool isNotification;

  const ChangeNotificationEvent(this.isNotification);

  @override
  List<Object?> get props => [isNotification];
}
