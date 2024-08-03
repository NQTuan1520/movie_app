import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_bloc.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_event.dart';
import 'package:tuannq_movie/presentation/auth/login/login_screen.dart';

class LayoutGuestSettingWidget extends StatelessWidget {
  const LayoutGuestSettingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                AppConstant.passwordImage,
                width: 80.w,
              ),
              16.verticalSpace,
              Center(
                child: Text(
                  "sign_in_request".tr(),
                  textAlign: TextAlign.center,
                ),
              ),
              16.verticalSpace,
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 12.h),
                  ),
                  onPressed: () {
                    context.read<AuthBloc>().add(AuthLogout());

                    Navigator.pushAndRemoveUntil(
                        context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
                  },
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.login),
                        10.horizontalSpace,
                        Text('login_now'.tr()),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
