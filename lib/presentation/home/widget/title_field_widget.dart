import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/manager/color.dart';
import 'package:tuannq_movie/presentation/home/bloc/movie/movie_state.dart';
import 'package:tuannq_movie/presentation/see_all_trending/screen/see_all_trending_screen.dart';

class TitleField extends StatelessWidget {
  const TitleField({
    super.key,
    required this.title,
    required this.state,
  });

  final String title;
  final MovieState state;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? TAppColor.whiteLightColor
                : TAppColor.darkFadeBlueColor,
          ),
        ),
        SizedBox(width: 8.w),
        IconButton(
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const SeeAllTrendingScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return ScaleTransition(
                  scale: animation,
                  child: child,
                );
              },
            ));
          },
          icon: Icon(
            size: 20.sp,
            Icons.arrow_forward_ios,
            color: Theme.of(context).brightness == Brightness.dark
                ? TAppColor.whiteLightColor
                : TAppColor.darkFadeBlueColor,
          ),
        ),
        // CustomSegmentedControl(
        //   selectedSegment: state.timeWindow ?? 'day',
        //   onSegmentChanged: (newTimeWindow) {
        //     context.read<MovieBloc>().add(ChangeTimeWindowEvent(newTimeWindow));
        //   },
        // ),
      ],
    );
  }
}
