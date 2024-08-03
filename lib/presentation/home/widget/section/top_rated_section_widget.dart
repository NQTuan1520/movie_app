import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';
import 'package:tuannq_movie/domain/movie/entity/movie_entity.dart';
import 'package:tuannq_movie/manager/widget/custom_dialog_widget.dart';
import 'package:tuannq_movie/presentation/detail_movie/screen/details_movie_screen.dart';
import 'package:tuannq_movie/presentation/see_all_top_rated/screen/see_all_top_rated_screen.dart';
import 'package:tuannq_movie/presentation/home/widget/movie_top_rated_item_widget.dart';
import 'package:tuannq_movie/presentation/home/widget/title_no_state_widget.dart';

class TopRatedSectionWidget extends StatelessWidget {
  const TopRatedSectionWidget({
    super.key,
    required this.user,
    required this.moviesTopRated,
  });

  final User user;
  final List<MovieEntity> moviesTopRated;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        children: [
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     Text(
          //       'top_rated'.tr(),
          //       style: TextStyle(
          //         fontSize: 20.sp,
          //         fontWeight: FontWeight.bold,
          //         color: Theme.of(context).brightness == Brightness.dark
          //             ? TAppColor.whiteLightColor
          //             : TAppColor.darkFadeBlueColor,
          //       ),
          //     ),
          //   ],
          // ),
          TitleNoStateWidget(
              text: 'top_rated'.tr(),
              onTap: () {
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) => const SeeAllTopRatedScreen(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return ScaleTransition(
                      scale: animation,
                      child: child,
                    );
                  },
                ));
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (_) => const SeeAllTopRatedScreen(),
                //   ),
                // );
              }),
          16.verticalSpace,
          SizedBox(
            height: 220.h,
            width: double.infinity,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: moviesTopRated.length,
              itemBuilder: (context, index) {
                final movieItem = moviesTopRated[index];
                return TopRatedMovieListItemWidget(
                  imagePathUrl: AppConstant.imagePathUrlOriginal,
                  posterPath: movieItem.posterPath ?? '',
                  title: movieItem.title ?? 'No title',
                  voteAverage: movieItem.voteAverage ?? 0.0,
                  popularity: movieItem.popularity ?? 0.0,
                  onTap: () {
                    if (user.isAnonymous) {
                      showDialog(
                          context: context,
                          builder: ((context) =>
                              CustomDialogWidget(titleWarning: 'this_features'.tr(), submitCallback: () {})));
                      return;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MovieDetailScreen(idMovie: movieItem.id ?? 0, uid: user.uid),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
