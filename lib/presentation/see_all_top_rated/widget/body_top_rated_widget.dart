import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';
import 'package:tuannq_movie/presentation/detail_movie/screen/details_movie_screen.dart';
import 'package:tuannq_movie/presentation/see_all_top_rated/bloc/top_rated/top_rated_movie_bloc.dart';
import 'package:tuannq_movie/presentation/see_all_top_rated/bloc/top_rated/top_rated_movie_event.dart';
import 'package:tuannq_movie/presentation/see_all_top_rated/bloc/top_rated/top_rated_movie_state.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class BodyTopRatedWidget extends StatelessWidget {
  final RefreshController refreshController;
  final TopRatedMovieState state;
  final String uid;
  const BodyTopRatedWidget({super.key, required this.refreshController, required this.state, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.h, vertical: 16.0.h),
      child: Column(
        children: [
          16.verticalSpace,
          Expanded(
            child: SmartRefresher(
              controller: refreshController,
              onRefresh: () {
                context.read<TopRatedMovieBloc>().add(const GetTopRatedMovieEvent(isRefresh: true));
              },
              onLoading: () {
                context.read<TopRatedMovieBloc>().add(
                      const LoadMoreTopRatedMovieEvent(),
                    );
              },
              footer: const ClassicFooter(
                loadStyle: LoadStyle.ShowWhenLoading,
              ),
              enablePullUp: true,
              enablePullDown: true,
              child: ListView.builder(
                itemCount: state.moviesTopRated!.length,
                itemBuilder: (context, index) {
                  final movie = state.moviesTopRated![index];
                  if (state.minVoteAverage != null && movie.voteAverage! < state.minVoteAverage!) {
                    return Container();
                  }

                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: ((context) => MovieDetailScreen(idMovie: movie.id ?? 0, uid: uid)),
                        ),
                      );
                    },
                    child: Container(
                        margin: EdgeInsets.only(bottom: 12.w),
                        height: 250.h,
                        child: Row(
                          children: [
                            Hero(
                              tag: movie.id.toString(),
                              child: Container(
                                height: 250.h,
                                width: 150.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(16.r),
                                  child: CachedNetworkImage(
                                    imageUrl: '${AppConstant.imagePathUrlOriginal}${movie.posterPath}',
                                    width: 250.w,
                                    height: 200.h,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      movie.title ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    16.verticalSpace,
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                        ),
                                        6.horizontalSpace,
                                        Text(
                                          movie.voteAverage!.toStringAsFixed(1),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
