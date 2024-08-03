import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/presentation/auth/register/widget/form_register_widget.dart';

import '../../../manager/router/main_wrapper.dart';
import '../../../manager/router/routes_name.dart';
import '../../../manager/utils/utils.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_state.dart';
import '../login/widget/divider_widget.dart';
import '../login/widget/social_login_container_widget.dart';
import '../login/widget/text_sigin_up_bottom_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isObscured = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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

  String? _validateConfirmPassword(String? value) {
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _hideLoadingDialog() {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.white,
          child: Center(
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black))),
        ),
      ),
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
                  } else if (state is AuthRegisterFailure) {
                    _hideLoadingDialog();
                    AppUtils.showCustomToastError(state.message, context);
                  } else if (state is AuthUnauthenticated) {
                    _hideLoadingDialog();
                    return;
                  } else if (state is AuthAuthenticated) {
                    _hideLoadingDialog();
                    AppUtils.showCustomToastSuccess(
                      'Register success! Please login to continue.',
                      context,
                    );
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => const MainWrapper()),
                      (route) => false,
                    );
                  } else if (state is AuthLoginFailure) {
                    _hideLoadingDialog();
                    AppUtils.showCustomToastError(
                      'Register failed! Please check your email and password again.',
                      context,
                    );
                  }
                },
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(
                        "Create Your Account",
                        style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 30.h,
                      ),
                      FormRegisterWidget(
                        formKey: _formKey,
                        emailController: emailController,
                        usernameController: usernameController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                        isObscured: isObscured,
                        onTap: () {
                          setState(() {
                            isObscured = !isObscured;
                          });
                        },
                        validateEmail: _validateEmail,
                        validatePassword: _validatePassword,
                        validateConfirmPassword: _validateConfirmPassword,
                      ),
                      SizedBox(height: 30.h),
                      const DividerWidget(),
                      SizedBox(height: 30.h),
                      const SocialLoginWidget(),
                      30.verticalSpace,
                      TextSignUpBottomWidget(
                        callback: () {
                          Navigator.pushNamed(context, RoutesName.login);
                        },
                        text1: 'Already have an account?',
                        text2: 'Sign in now',
                      ),
                      SizedBox(height: 14.h), // Add some space at the bottom
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
