import 'package:equatable/equatable.dart';

class SettingState extends Equatable {
  final String selectedLanguage;
  final bool isDarkMode;
  final bool isNotification;
  final bool isGuest;
  final String uid;

  const SettingState({
    this.selectedLanguage = 'en',
    this.isDarkMode = false,
    this.isNotification = false,
    this.isGuest = false,
    this.uid = '',
  });

  SettingState copyWith({
    String? selectedLanguage,
    bool? isDarkMode,
    bool? isNotification,
    bool? isGuest,
    String? uid,
  }) {
    return SettingState(
      selectedLanguage: selectedLanguage ?? this.selectedLanguage,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isNotification: isNotification ?? this.isNotification,
      isGuest: isGuest ?? this.isGuest,
      uid: uid ?? this.uid,
    );
  }

  @override
  List<Object?> get props =>
      [selectedLanguage, isDarkMode, isNotification, isGuest, uid];
}
