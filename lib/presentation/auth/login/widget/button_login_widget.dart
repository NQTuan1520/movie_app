import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';

class ButtonLoginWidget extends StatelessWidget {
  const ButtonLoginWidget({
    super.key,
    required GlobalKey<FormState> formKey,
    required this.emailController,
    required this.passwordController,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.h),
        child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                context
                    .read<AuthBloc>()
                    .add(AuthLogin(email: emailController.text, password: passwordController.text));
              }
            },
            child: const Text('Login')));
  }
}
