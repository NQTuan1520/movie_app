import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/domain/auth/entity/user_entity.dart';
import 'package:tuannq_movie/manager/widget/custom_spin_widget.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_bloc.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_event.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_state.dart';
import 'package:tuannq_movie/presentation/setting/widget/form_input_new_username_widget.dart';

class EditUsernameScreen extends StatefulWidget {
  final UserEntity user;
  const EditUsernameScreen({super.key, required this.user});

  @override
  // ignore: library_private_types_in_public_api
  _EditUsernameScreenState createState() => _EditUsernameScreenState();
}

class _EditUsernameScreenState extends State<EditUsernameScreen> {
  late TextEditingController _usernameController;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.user.username);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            UpdateUsernameEvent(username: _usernameController.text),
          );
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUpdateUsernameSuccess) {
            Navigator.pop(context, _usernameController.text);
            _showSnackBar('update_username_suceess'.tr());
          } else if (state is AuthUpdateUsernameFailure) {
            _showSnackBar('Update username failed, Please try again');
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return SpinCustomWidget(
                sized: 50.r,
              );
            }
            return SafeArea(
              child: FormInputNewUsernameWidget(
                formKey: _formKey,
                usernameController: _usernameController,
                submit: _submit,
              ),
            );
          },
        ),
      ),
    );
  }
}
