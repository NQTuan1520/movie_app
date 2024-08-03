import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';
import 'package:tuannq_movie/presentation/detail_movie/screen/details_movie_screen.dart';
import 'package:tuannq_movie/presentation/see_all_trending/bloc/trending_movie/trending_movie_bloc.dart';
import 'package:tuannq_movie/presentation/see_all_trending/bloc/trending_movie/trending_movie_event.dart';
import 'package:tuannq_movie/presentation/see_all_trending/bloc/trending_movie/trending_movie_state.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';
import 'package:shimmer/shimmer.dart';

class MovieTrendingSectionWidget extends StatelessWidget {
  const MovieTrendingSectionWidget({
    super.key,
    required this.refreshController,
    required this.uid,
    required this.state,
  });

  final RefreshController refreshController;
  final String uid;
  final TrendingMovieState state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SmartRefresher(
          controller: refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () {
            context.read<TrendingMovieBloc>().add(GetTrendingMoviesEvent(
                  timeWindow: state.timeWindow ?? 'day',
                  isRefresh: true,
                  isLoading: false,
                ));
          },
          onLoading: () {
            context.read<TrendingMovieBloc>().add(const LoadMoreTrendingMoviesEvent());
          },
          child: GridView.builder(
            key: ValueKey<int>(state.selectedGenreId ?? 0),
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0.w,
              mainAxisSpacing: 16.0.h,
              childAspectRatio: 0.7,
            ),
            itemCount: state.trendingMovies?.length ?? 0,
            itemBuilder: (context, index) {
              final movieList = state.trendingMovies ?? [];
              final movie = movieList[index];
              return GridTile(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: ((context) => MovieDetailScreen(idMovie: movie.id ?? 0, uid: uid))));
                    // Navigate to movie detail screen
                  },
                  child: SizedBox(
                    height: 200.h,
                    width: 160.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 250.h,
                            width: 160.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16.0.r),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.0.r),
                              child: Hero(
                                tag: movie.id.toString(),
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
                        ),
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
            },
          )),
    );
  }
}
