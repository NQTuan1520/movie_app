import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth_bloc.dart';
import '../../bloc/auth_event.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;

  const SquareTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    // void _showLoadingDialog() {
    //   print("da show dialog");
    //   showDialog(
    //     context: context,
    //     barrierDismissible: false,
    //     builder: (BuildContext context) {
    //       return const Center(
    //         child: SpinCustomWidget(
    //           sized: 50,
    //         ),
    //       );
    //     },
    //   );
    // }
    //
    // void _hideLoadingDialog() {
    //   if (Navigator.of(context, rootNavigator: true).canPop()) {
    //     Navigator.of(context, rootNavigator: true).pop();
    //   }
    // }

    // return BlocConsumer<AuthBloc, AuthState>(
    //   listener: (context, state) {
    //     if (state is AuthLoading) {
    //       print(state);
    //       _showLoadingDialog();
    //     } else if (state is AuthLoginFailure) {
    //       _hideLoadingDialog();
    //       AppUtils.showCustomToastError(
    //         'Login failed! Please check your email and password again.',
    //         context,
    //       );
    //     } else if (state is AuthAuthenticated) {
    //       _hideLoadingDialog();
    //       AppUtils.showCustomToastSuccess(
    //         'Login success! Enjoy your free time !!.',
    //         context,
    //       );
    //       Navigator.pushAndRemoveUntil(context,
    //           MaterialPageRoute(builder: (context) => const MainWrapper()), (route) => false);
    //     }
    //     return;
    //   },
    //   builder: (context, state) {
    //     return BlocBuilder<AuthBloc, AuthState>(
    //       builder: (context, state) {
    //         return GestureDetector(
    //           onTap: () {
    //             context.read<AuthBloc>().add(LoginWithGoogleEvent());
    //           },
    //           child: Container(
    //             padding: EdgeInsets.all(14),
    //             decoration: BoxDecoration(
    //               shape: BoxShape.circle,
    //               border: Border.all(color: Colors.white),
    //               color: Colors.transparent,
    //             ),
    //             child: Image.asset(
    //               imagePath,
    //               height: 30,
    //             ),
    //           ),
    //         );
    //       },
    //     );
    //   },
    // );
    return GestureDetector(
      onTap: () {
        context.read<AuthBloc>().add(LoginWithGoogleEvent());
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white),
          color: Colors.transparent,
        ),
        child: Image.asset(
          imagePath,
          height: 30,
        ),
      ),
    );
  }
}
