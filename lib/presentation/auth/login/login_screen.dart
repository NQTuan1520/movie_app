import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/presentation/auth/login/widget/divider_widget.dart';
import 'package:tuannq_movie/presentation/auth/login/widget/social_login_container_widget.dart';
import 'package:tuannq_movie/presentation/auth/login/widget/text_sigin_up_bottom_widget.dart';

import '../../../manager/router/main_wrapper.dart';
import '../../../manager/router/routes_name.dart';
import '../../../manager/utils/utils.dart';
import '../../forgot_password/input_email_forgot_password.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import 'widget/button_login_widget.dart';
import 'widget/form_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode userFocus = FocusNode();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _formKey.currentState!.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    const emailRegex = r'^[^@]+@[^@]+\.[^@]+';
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(emailRegex).hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  bool isObscured = true;

  void _hideLoadingDialog() {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/img/cover.png',
              fit: BoxFit.cover,
            ),
          ),

          // Blur effect
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
          ),
          Center(
              child: SafeArea(
            child: BlocListener<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthLoading) {
                  AppUtils.showLoadingDialog(context);
                } else if (state is AuthLoginFailure) {
                  _hideLoadingDialog();
                  AppUtils.showCustomToastError(
                    'Login failed! Please check your email and password again.',
                    context,
                  );
                } else if (state is AuthAuthenticated) {
                  _hideLoadingDialog();
                  AppUtils.showCustomToastSuccess(
                    'Login success! Enjoy your free time !!.',
                    context,
                  );
                  Navigator.pushAndRemoveUntil(
                      context, MaterialPageRoute(builder: (context) => const MainWrapper()), (route) => false);
                } else if (state is AuthUnauthenticated) {
                  _hideLoadingDialog();
                  return;
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    16.verticalSpace,
                    Text(
                      "Login to Your Account",
                      style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w500),
                    ),
                    50.verticalSpace,
                    Column(
                      children: [
                        FormLoginWidget(
                          emailController: emailController,
                          passwordController: passwordController,
                          formKey: _formKey,
                          onTap: () {
                            setState(() {
                              isObscured = !isObscured;
                            });
                          },
                          isObscured: isObscured,
                          validateEmail: _validateEmail,
                          validatePassword: _validatePassword,
                        ),
                        20.verticalSpace,
                        ButtonLoginWidget(
                            formKey: _formKey,
                            emailController: emailController,
                            passwordController: passwordController),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (_) => const InputEmailToResetPassword()));
                          },
                          child: Text('Forgot the password?',
                              style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w400)),
                        ),
                      ],
                    ),
                    50.verticalSpace,
                    const DividerWidget(),
                    50.verticalSpace,
                    const SocialLoginWidget(),
                    SizedBox(height: 20.h),
                    TextSignUpBottomWidget(
                      callback: () {
                        Navigator.pushNamed(context, RoutesName.register);
                      },
                      text1: 'Don\'t have an account?',
                      text2: 'Sign up now',
                    ),
                    20.verticalSpace,
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
