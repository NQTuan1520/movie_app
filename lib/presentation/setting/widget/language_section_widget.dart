import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/presentation/setting/bloc/setting/setting_bloc.dart';
import 'package:tuannq_movie/presentation/setting/bloc/setting/setting_event.dart';
import 'package:tuannq_movie/presentation/setting/bloc/setting/setting_state.dart';
import 'package:tuannq_movie/presentation/setting/widget/preference_item_widget.dart';
import 'package:restart_app/restart_app.dart';

class LanguageSectionWidget extends StatelessWidget {
  final SettingState settingState;
  const LanguageSectionWidget({
    super.key,
    required this.settingState,
  });

  @override
  Widget build(BuildContext context) {
    return PreferenceItemWidget(
      context: context,
      icon: Icons.language,
      title: 'language'.tr(),
      trailing: DropdownButton<String>(
        value: settingState.selectedLanguage,
        icon: const Icon(Icons.arrow_downward),
        onChanged: (String? newValue) {
          if (newValue != null) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('confirm_change_language'.tr()),
                  content: Text('are_you_sure_you_want_to_change_language'.tr()),
                  actions: <Widget>[
                    TextButton(
                      child: Text('cancel'.tr()),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('confirm'.tr()),
                      onPressed: () {
                        context.read<SettingBloc>().add(ChangeLanguageEvent(newValue));

                        if (newValue == 'en') {
                          context.setLocale(const Locale('en', 'US'));
                        } else {
                          context.setLocale(const Locale('vi', 'VN'));
                        }

                        Restart.restartApp();

                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          }
        },
        items: <String>['en', 'vi'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value == 'en' ? 'English' : 'Vietnamese'),
          );
        }).toList(),
      ),
    );
  }
}
