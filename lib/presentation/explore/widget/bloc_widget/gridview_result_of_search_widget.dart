import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';
import 'package:tuannq_movie/manager/color.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/detail_movie/screen/details_movie_screen.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/searchMovieBloc/search_movie_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/searchMovieBloc/search_movie_state.dart';
import 'package:tuannq_movie/presentation/explore/widget/shimmer/shimmer_item_air_today_widget.dart';
import 'package:tuannq_movie/presentation/explore/widget/shimmer/shimmer_layout_item_tv_show_popular_widget.dart';

class GridviewResultSearchWidget extends StatelessWidget {
  const GridviewResultSearchWidget({
    super.key,
    required this.uid,
  });

  final String uid;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchMovieBloc, SearchMovieState>(
      builder: (context, state) {
        if (state.status == Status.loading) {
          return const ShimmerTvShowPopularItemWidget();
        } else if (state.status == Status.success) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: AppConstant.defaultCrossAxisCount,
              childAspectRatio: AppConstant.defaultChildAspectRatio,
              mainAxisSpacing: AppConstant.defaultMainAxisSpacing,
              crossAxisSpacing: AppConstant.defaultCrossAxisSpacing,
            ),
            itemCount: state.movies.length,
            itemBuilder: (context, index) {
              final movieItem = state.movies[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(
                          idMovie: movieItem.id ?? 0,
                          uid: uid,
                        ),
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
                          imageUrl: '${AppConstant.imagePathUrlOriginal}${movieItem.posterPath}',
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
                        movieItem.originalTitle ?? 'No title',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? TAppColor.whiteLightColor
                              : TAppColor.darkFadeBlueColor,
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
