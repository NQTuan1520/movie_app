import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/presentation/auth/login/widget/social_login_button_widget.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';

class SocialLoginWidget extends StatelessWidget {
  const SocialLoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // google button
        const SquareTile(imagePath: 'assets/img/google.png'),

        const SizedBox(width: 25),

        // apple button
        GestureDetector(
          onTap: () {
            context.read<AuthBloc>().add(SignInAnonymouslyEvent());
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
              color: Colors.transparent,
            ),
            child: Image.asset(
              'assets/img/spy.png',
              height: 30,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
