import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/detail_tv/screen/detail_tv_screen.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/tvShowPopularBloc/tv_show_popular_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/tvShowPopularBloc/tv_show_popular_state.dart';
import 'package:tuannq_movie/presentation/explore/widget/shimmer/shimmer_item_air_today_widget.dart';
import 'package:tuannq_movie/presentation/explore/widget/shimmer/shimmer_layout_item_tv_show_popular_widget.dart';

import '../../../../core/constant/app_constant.dart';

class TvShowsMostPopular extends StatelessWidget {
  const TvShowsMostPopular({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvShowPopularBloc, TvShowPopularState>(
      builder: (context, popularTvShowState) {
        if (popularTvShowState.status == Status.loading) {
          return const ShimmerTvShowPopularItemWidget();
        } else if (popularTvShowState.status == Status.success) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.45,
              mainAxisSpacing: 36.h,
              crossAxisSpacing: 16.w,
            ),
            itemCount: popularTvShowState.tvShowListPopular!.length,
            itemBuilder: (context, index) {
              final tvShowItem = popularTvShowState.tvShowListPopular![index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        DetailTvScreen(idTvShow: tvShowItem.id ?? 0),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return ScaleTransition(
                        scale: animation,
                        child: child,
                      );
                    },
                  ));
                },
                child: Column(
                  children: [
                    SizedBox(
                      height: 180.h,
                      width: 120.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: '${AppConstant.imagePathUrlOriginal}${tvShowItem.posterPath}',
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          placeholder: (context, url) => const ShimmerItemAirTodayWidget(),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                    8.verticalSpace,
                    SizedBox(
                      width: 120.w,
                      child: Text(
                        tvShowItem.originalName ?? 'No title',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
