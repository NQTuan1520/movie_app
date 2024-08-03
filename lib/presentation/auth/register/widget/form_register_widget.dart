import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../manager/color.dart';
import 'button_register_widget.dart';

class FormRegisterWidget extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final bool isObscured;
  final GestureTapCallback onTap;
  final String? Function(String?) validateEmail;
  final String? Function(String?) validatePassword;
  final String? Function(String?) validateConfirmPassword;
  const FormRegisterWidget(
      {super.key,
      required this.formKey,
      required this.emailController,
      required this.usernameController,
      required this.passwordController,
      required this.confirmPasswordController,
      required this.isObscured,
      required this.onTap,
      required this.validateEmail,
      required this.validatePassword,
      required this.validateConfirmPassword});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? TAppColor.darkFadeBlueColor
                        : TAppColor.darkFadeBlueColor,
                  ),
                  controller: usernameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Username is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: 'Username',
                    filled: true,
                    hintStyle: const TextStyle(color: Colors.grey),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? TAppColor.darkFadeBlueColor
                        : TAppColor.darkFadeBlueColor,
                  ),
                  controller: emailController,
                  validator: validateEmail,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    filled: true,
                    hintStyle: const TextStyle(color: Colors.grey),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? TAppColor.darkFadeBlueColor
                        : TAppColor.darkFadeBlueColor,
                  ),
                  controller: passwordController,
                  validator: validatePassword,
                  obscureText: isObscured,
                  decoration: InputDecoration(
                      hintText: 'Password',
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.grey),
                      fillColor: Colors.white,
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
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: TextFormField(
                  style: TextStyle(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? TAppColor.darkFadeBlueColor
                        : TAppColor.darkFadeBlueColor,
                  ),
                  validator: validateConfirmPassword,
                  controller: confirmPasswordController,
                  obscureText: isObscured,
                  decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.grey),
                      fillColor: Colors.white,
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
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
          ButtonRegisterWidget(
              formKey: formKey,
              emailController: emailController,
              usernameController: usernameController,
              passwordController: passwordController),
        ],
      ),
    );
  }
}
