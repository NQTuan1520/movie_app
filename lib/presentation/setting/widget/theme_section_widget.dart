import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/core/theme/bloc/theme_bloc.dart';
import 'package:tuannq_movie/core/theme/bloc/theme_event.dart';
import 'package:tuannq_movie/core/theme/theme.dart';
import 'package:tuannq_movie/presentation/setting/bloc/setting/setting_bloc.dart';
import 'package:tuannq_movie/presentation/setting/bloc/setting/setting_event.dart';
import 'package:tuannq_movie/presentation/setting/bloc/setting/setting_state.dart';
import 'package:tuannq_movie/presentation/setting/widget/preference_item_widget.dart';

class ThemeSectionWidget extends StatelessWidget {
  final SettingState settingState;
  const ThemeSectionWidget({
    super.key,
    required this.settingState,
  });

  @override
  Widget build(BuildContext context) {
    return PreferenceItemWidget(
      context: context,
      icon: Icons.dark_mode_outlined,
      title: 'theme'.tr(),
      trailing: Switch(
        value: settingState.isDarkMode,
        onChanged: (value) {
          context
              .read<ThemeBloc>()
              .add(ThemeChangeEvent(themeData: value ? TAppTheme.darkTheme.themeData : TAppTheme.lightTheme.themeData));
          context.read<SettingBloc>().add(ChangeThemeEvent(value));
        },
      ),
    );
  }
}
