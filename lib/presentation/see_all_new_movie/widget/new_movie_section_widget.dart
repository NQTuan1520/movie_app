import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';
import 'package:tuannq_movie/presentation/detail_movie/screen/details_movie_screen.dart';
import 'package:tuannq_movie/presentation/see_all_new_movie/bloc/new_movie/new_movie_bloc.dart';
import 'package:tuannq_movie/presentation/see_all_new_movie/bloc/new_movie/new_movie_event.dart';
import 'package:tuannq_movie/presentation/see_all_new_movie/bloc/new_movie/new_movie_state.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shimmer/shimmer.dart';

class NewMovieSectionWidget extends StatelessWidget {
  const NewMovieSectionWidget({
    super.key,
    required RefreshController refreshController,
    required this.uid,
    required this.state,
  }) : _refreshController = refreshController;

  final RefreshController _refreshController;
  final String uid;
  final NewMovieState state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SmartRefresher(
        controller: _refreshController,
        enablePullDown: true,
        enablePullUp: true,
        onRefresh: () {
          context.read<NewMovieBloc>().add(const GetNewMoviesEvent(isRefresh: true));
        },
        onLoading: () {
          context.read<NewMovieBloc>().add(const LoadMoreNewMoviesEvent());
        },
        child: StaggeredGrid.count(
          crossAxisCount: 4,
          crossAxisSpacing: 8.0.w,
          mainAxisSpacing: 16.0.h,
          children: state.newMovies?.map((movie) {
                final bool isShortItem = state.newMovies!.indexOf(movie) % 2 == 0;
                return StaggeredGridTile.fit(
                  crossAxisCellCount: 2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => MovieDetailScreen(idMovie: movie.id ?? 0, uid: uid))));
                    },
                    child: SizedBox(
                      height: isShortItem ? 200.h : 300.h,
                      width: 160.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              height: isShortItem ? 150.h : 250.h,
                              width: 160.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16.0.r),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16.0.r),
                                child: CachedNetworkImage(
                                  imageUrl: '${AppConstant.imagePathUrlW500}${movie.posterPath}',
                                  placeholder: (context, url) => Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      color: Colors.white,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          8.verticalSpace,
                          SizedBox(
                            width: 160.w,
                            child: Text(
                              movie.title ?? '',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList() ??
              [],
        ),
      ),
    );
  }
}
