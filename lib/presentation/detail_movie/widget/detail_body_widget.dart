import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../manager/enum/status_enum.dart';
import '../bloc/detail_movie/detail_of_movie_bloc.dart';
import '../bloc/detail_movie/detail_of_movie_state.dart';

class DetailBodyWidget extends StatelessWidget {
  const DetailBodyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailOfMovieBloc, DetailOfMovieState>(builder: (context, detailState) {
      if (detailState.status == Status.failure) {
        return const SizedBox.shrink();
      } else if (detailState.status == Status.loading) {
        return const CircularProgressIndicator();
      } else if (detailState.status == Status.success) {
        List<String> keywords =
            detailState.movieDetail.tagline!.split(RegExp(r'[. ]+')).where((s) => s.isNotEmpty).toList();

        List<String> hashtags = keywords.map((keyword) => '#$keyword').toList();

        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Audio Track: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                5.horizontalSpace,
                Text('English', style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp)),
              ],
            ),
            10.verticalSpace,
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Tag for: ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
                5.horizontalSpace,
                Expanded(
                  child: Text(
                      maxLines: 1,
                      hashtags.join(' '),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp)),
                ),
              ],
            ),
          ],
        );
      }
      return const SizedBox.shrink();
    });
  }
}
