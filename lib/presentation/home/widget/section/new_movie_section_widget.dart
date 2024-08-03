import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';
import 'package:tuannq_movie/domain/movie/entity/movie_entity.dart';
import 'package:tuannq_movie/manager/widget/custom_dialog_widget.dart';
import 'package:tuannq_movie/presentation/detail_movie/screen/details_movie_screen.dart';
import 'package:tuannq_movie/presentation/see_all_new_movie/screen/see_all_new_movie_screen.dart';

import 'package:tuannq_movie/presentation/home/widget/movie_up_coming_item_widget.dart';
import 'package:tuannq_movie/presentation/home/widget/title_no_state_widget.dart';

class NewMovieSectionWidget extends StatelessWidget {
  const NewMovieSectionWidget({
    super.key,
    required this.user,
    required this.moviesUpcoming,
  });
  final List<MovieEntity> moviesUpcoming;
  final User user;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TitleNoStateWidget(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => const SeeAllNewMovieScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return ScaleTransition(
                    scale: animation,
                    child: child,
                  );
                },
              ));
            },
            text: 'new_releases'.tr(),
          ),
          16.verticalSpace,
          SizedBox(
            height: 220.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: moviesUpcoming.length,
              itemBuilder: (context, index) {
                final movieItem = moviesUpcoming[index];
                return MovieListItemWidget(
                  imagePathUrl: AppConstant.imagePathUrlOriginal,
                  posterPath: movieItem.posterPath ?? '',
                  releaseDate: movieItem.releaseDate ?? 'No date',
                  title: movieItem.title ?? 'No title',
                  onTap: () {
                    if (user.isAnonymous) {
                      showDialog(
                          context: context,
                          builder: ((context) =>
                              CustomDialogWidget(titleWarning: 'this_features'.tr(), submitCallback: () {})));
                      return;
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MovieDetailScreen(
                            idMovie: movieItem.id ?? 0,
                            uid: user.uid,
                          ),
                        ),
                      );
                    }
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
