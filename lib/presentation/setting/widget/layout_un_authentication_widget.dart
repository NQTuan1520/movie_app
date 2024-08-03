import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tuannq_movie/presentation/auth/login/login_screen.dart';

class LayoutUnAuthenticationWidget extends StatelessWidget {
  const LayoutUnAuthenticationWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('please_login'.tr()),
        ElevatedButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => const LoginScreen()), (route) => false);
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}
