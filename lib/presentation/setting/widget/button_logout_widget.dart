import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/data/local/keyword/datasource/keyword_db_helper.dart';
import 'package:tuannq_movie/data/local/movie/datasource/cached_db_helper.dart';
import 'package:tuannq_movie/data/local/tv_show/datasource/cached_db_tv_show_hepler.dart';
import 'package:tuannq_movie/manager/color.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_bloc.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_event.dart';
import 'package:tuannq_movie/presentation/auth/login/login_screen.dart';

class ButtonLogoutWidget extends StatelessWidget {
  const ButtonLogoutWidget({
    super.key,
    required FirebaseAuth auth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 60.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        shape: BoxShape.rectangle,
        color: TAppColor.whiteGreyColor,
      ),
      margin: EdgeInsets.only(right: 16.w),
      child: Center(
        child: TextButton(
          onPressed: () {
            logout(context);
          },
          child: Text(
            'log_out'.tr(),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }

  Future<void> logout(BuildContext context) async {
    final databaseHelper = DatabaseHelper();
    final tvDatabaseCached = DatabaseTvShowCachedHelper();
    await KeywordDbHelper().deleteAllKeywords();

    await databaseHelper.deleteAllMovies();
    await tvDatabaseCached.deleteAllTvShow();

    // ignore: use_build_context_synchronously
    context.read<AuthBloc>().add(AuthLogout());

    Navigator.pushAndRemoveUntil(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false);
  }
}
