import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/manager/color.dart';
import 'package:tuannq_movie/presentation/see_all_trending/bloc/trending_movie/trending_movie_bloc.dart';
import 'package:tuannq_movie/presentation/see_all_trending/bloc/trending_movie/trending_movie_event.dart';
import 'package:tuannq_movie/presentation/see_all_trending/bloc/trending_movie/trending_movie_state.dart';

class DropDownTimeSectionWidget extends StatelessWidget {
  final TrendingMovieState state;
  const DropDownTimeSectionWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.0.w),
      padding: EdgeInsets.symmetric(horizontal: 16.0.w),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(8.0.r),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: state.timeWindow,
          icon: const Icon(Icons.arrow_drop_down, color: TAppColor.primaryColor),
          items: const [
            DropdownMenuItem(value: 'day', child: Text('Day')),
            DropdownMenuItem(value: 'week', child: Text('Week')),
          ],
          onChanged: (value) {
            context.read<TrendingMovieBloc>().add(
                  GetTrendingMoviesEvent(
                    isRefresh: true,
                    timeWindow: value!,
                  ),
                );
          },
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black,
            fontSize: 16.0.sp,
            fontWeight: FontWeight.w500,
          ),
          dropdownColor: Theme.of(context).brightness == Brightness.dark ? Colors.grey[800] : Colors.white,
        ),
      ),
    );
  }
}
