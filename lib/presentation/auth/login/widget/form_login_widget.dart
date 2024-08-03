import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../manager/color.dart';

class FormLoginWidget extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;
  final GestureTapCallback onTap;
  final bool isObscured;
  final String? Function(String?) validateEmail;
  final String? Function(String?) validatePassword;
  const FormLoginWidget(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.formKey,
      required this.onTap,
      required this.isObscured,
      required this.validateEmail,
      required this.validatePassword});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 18.h),
            child: TextFormField(
              controller: emailController,
              validator: validateEmail,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? TAppColor.darkFadeBlueColor
                    : TAppColor.darkFadeBlueColor,
              ),
              decoration: InputDecoration(
                hintText: 'Email',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: TextFormField(
              controller: passwordController,
              validator: validatePassword,
              obscureText: isObscured,
              style: TextStyle(
                color: Theme.of(context).brightness == Brightness.dark
                    ? TAppColor.darkFadeBlueColor
                    : TAppColor.darkFadeBlueColor,
              ),
              decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.white,
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  suffixIcon: IconButton(
                    onPressed: () {
                      onTap();
                    },
                    icon: Icon(isObscured ? Icons.visibility : Icons.visibility_off),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
