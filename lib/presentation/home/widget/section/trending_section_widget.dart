import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/presentation/home/bloc/movie/movie_state.dart';
import 'package:tuannq_movie/presentation/home/widget/title_field_widget.dart';
import 'package:tuannq_movie/presentation/home/widget/trending_movie_widget.dart';


class TrendingSectionWidget extends StatelessWidget {
  const TrendingSectionWidget(
      {super.key, required this.user, required this.state});
  final MovieState state;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          TitleField(
            title: 'trending'.tr(),
            state: state,
          ),
          16.verticalSpace,
          TrendingMoviesWidget(
            uid: user.uid,
            user: user,
            state: state,
          ),
        ],
      ),
    );
  }
}
