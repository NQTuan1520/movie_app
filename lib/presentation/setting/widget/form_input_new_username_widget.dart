import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';

class FormInputNewUsernameWidget extends StatelessWidget {
  final GlobalKey formKey;
  final TextEditingController usernameController;
  final Function submit;
  const FormInputNewUsernameWidget(
      {super.key, required this.formKey, required this.usernameController, required this.submit});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'please_enter_username'.tr(),
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: usernameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppConstant.hintTextFormUsername;
                }
                return null;
              },
              onFieldSubmitted: (value) {
                submit();
              },
              style: TextStyle(fontSize: 22.sp),
              decoration: const InputDecoration(
                hintText: 'here',
                border: InputBorder.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
