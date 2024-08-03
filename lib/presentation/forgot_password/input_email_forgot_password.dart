import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';
import 'package:tuannq_movie/manager/widget/custom_spin_widget.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_bloc.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_event.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_state.dart';

class InputEmailToResetPassword extends StatefulWidget {
  const InputEmailToResetPassword({super.key});

  @override
  State<InputEmailToResetPassword> createState() => _InputEmailToResetPasswordState();
}

class _InputEmailToResetPasswordState extends State<InputEmailToResetPassword> {
  final emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(ForgotPasswordEvent(email: emailController.text));
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordSuccess) {
            Navigator.pop(context);
            _showSnackBar(context, 'send_email_reset_success'.tr());
          } else if (state is ResetPasswordFailure) {
            _showSnackBar(context, state.message);
          }
        },
        builder: (context, state) {
          if (state is ResetPasswordLoading) {
            return Center(child: SpinCustomWidget(sized: 50.r));
          }
          return SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'please_enter_email'.tr(),
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    16.verticalSpace,
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppConstant.hintTextFormResetPassword;
                        }
                        return null;
                      },
                      onFieldSubmitted: (value) => _submit(),
                      style: TextStyle(fontSize: 22.sp),
                      decoration: const InputDecoration(
                        hintText: AppConstant.hintHere,
                        border: InputBorder.none,
                      ),
                    ),
                    16.verticalSpace,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
