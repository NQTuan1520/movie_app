import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';

class ButtonRegisterWidget extends StatelessWidget {
  const ButtonRegisterWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.usernameController,
    required this.passwordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController usernameController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
      child: ElevatedButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            context.read<AuthBloc>().add(
                  AuthRegister(
                    email: emailController.text,
                    username: usernameController.text,
                    password: passwordController.text,
                  ),
                );
          }
        },
        child: const Text('Sign Up'),
      ),
    );
  }
}
