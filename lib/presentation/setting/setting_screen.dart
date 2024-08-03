// setting_screen.dart
import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/presentation/setting/bloc/setting/setting_bloc.dart';
import 'package:tuannq_movie/presentation/setting/bloc/setting/setting_event.dart';
import 'package:tuannq_movie/presentation/setting/bloc/setting/setting_state.dart';
import 'package:tuannq_movie/presentation/setting/widget/language_section_widget.dart';
import 'package:tuannq_movie/presentation/setting/widget/my_content_section_widget.dart';
import 'package:tuannq_movie/presentation/setting/widget/state_section_widget.dart';
import 'package:tuannq_movie/presentation/setting/widget/theme_section_widget.dart';
import 'package:tuannq_movie/manager/widget/custom_spin_widget.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_bloc.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_event.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_state.dart';
import 'package:tuannq_movie/presentation/setting/widget/button_logout_widget.dart';
import 'package:tuannq_movie/presentation/setting/widget/layout_guest_widget.dart';
import 'package:tuannq_movie/presentation/setting/widget/layout_un_authentication_widget.dart';
import 'package:tuannq_movie/presentation/setting/widget/profile_section_widget.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser!;
  late StreamSubscription<User?> _authSubscription;

  @override
  void dispose() {
    super.dispose();
    _authSubscription.cancel();
  }

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser!;

    _authSubscription = _auth.authStateChanges().listen((User? user) async {
      if (!mounted) return;
      if (user == null) {
        context.read<SettingBloc>().add(const LoadPreferencesEvent(''));
      } else if (user.isAnonymous) {
        context.read<SettingBloc>().add(const LoadPreferencesEvent(''));
      } else {
        context.read<SettingBloc>().add(LoadPreferencesEvent(user.uid));
      }
    });

    context.read<AuthBloc>().add(GetInformationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingBloc, SettingState>(
      builder: (context, settingState) {
        return settingState.isGuest
            ? const LayoutGuestSettingWidget()
            : Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  actions: [ButtonLogoutWidget(auth: _auth)],
                ),
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: BlocConsumer<AuthBloc, AuthState>(
                      listener: (context, state) {
                        if (state is AuthLoading) {
                          Center(
                            child: SpinCustomWidget(sized: 50.r),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthAuthenticated) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProfileSectionWidget(
                                user: user,
                                context: context,
                              ),
                              _buildPreferenceSection(context, settingState),
                            ],
                          );
                        } else if (state is AuthUnauthenticated) {
                          return const LayoutUnAuthenticationWidget();
                        }

                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
              );
      },
    );
  }

  Widget _buildPreferenceSection(
    BuildContext context,
    SettingState settingState,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'preferences'.tr(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          16.verticalSpace,
          LanguageSectionWidget(
            settingState: settingState,
          ),
          16.verticalSpace,
          ThemeSectionWidget(settingState: settingState),
          16.verticalSpace,
          26.verticalSpace,
          Text(
            'content'.tr(),
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          16.verticalSpace,
          const MyContentSectionWidget(),
          16.verticalSpace,
          const StatSectionWidget(),
        ],
      ),
    );
  }
}
