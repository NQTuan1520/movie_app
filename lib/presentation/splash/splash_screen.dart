import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';
import 'package:tuannq_movie/manager/router/main_wrapper.dart';
import 'package:tuannq_movie/manager/widget/custom_spin_widget.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_bloc.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_state.dart';
import 'package:tuannq_movie/presentation/auth/login/login_screen.dart';
import 'package:tuannq_movie/presentation/splash/widget/backdrop_filter_blur_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  void _navigateTo(BuildContext context, Widget widget) {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => widget), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            SpinCustomWidget(sized: 50.r);
          }
          if (state is AuthAuthenticated) {
            _navigateTo(context, const MainWrapper());
          } else if (state is AuthUnauthenticated) {
            _navigateTo(context, const LoginScreen());
          } else if (state is AuthError) {
            return;
          }
        },
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: Image.asset(
                AppConstant.coverImage,
                fit: BoxFit.cover,
              ),
            ),

            // Blur effect
            const Positioned.fill(child: BackdropFilterBlurWidget()),
            // Overlay with dots
            const Center(
              child: SpinCustomWidget(
                sized: 80.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
