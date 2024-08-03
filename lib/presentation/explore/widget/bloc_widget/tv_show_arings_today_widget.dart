import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/detail_tv/screen/detail_tv_screen.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/tvShowBloc/tvshow_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/tvShowBloc/tvshow_state.dart';
import 'package:tuannq_movie/presentation/explore/widget/shimmer/shimmer_carousel_widget.dart';
import 'package:tuannq_movie/presentation/explore/widget/shimmer/shimmer_item_air_today_widget.dart';

class TvShowsAiringToday extends StatelessWidget {
  const TvShowsAiringToday({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TvshowBloc, TvshowState>(
      builder: (context, state) {
        if (state.status == Status.loading) {
          return const ShimmerCarouselWidget();
        } else if (state.status == Status.success) {
          final tvAirTodayList = state.tvShowList;
          return Container(
            margin: EdgeInsets.only(top: 16.h),
            width: double.infinity,
            child: CarouselSlider.builder(
              itemCount: tvAirTodayList!.length,
              itemBuilder: (context, itemIndex, pageViewIndex) {
                final tvShowItem = state.tvShowList![itemIndex];
                return Stack(children: [
                  InkWell(
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
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        height: 200.h,
                        child: CachedNetworkImage(
                          imageUrl: '${AppConstant.imagePathUrlOriginal}${tvShowItem.backdropPath}',
                          fit: BoxFit.cover,
                          filterQuality: FilterQuality.high,
                          placeholder: (context, url) => const ShimmerItemAirTodayWidget(),
                          errorWidget: (context, url, error) => const Center(
                            child: Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10.h,
                    left: 0,
                    child: Container(
                      width: 150.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(10.r), bottomRight: Radius.circular(10.r)),
                      ),
                      child: Center(
                        child: Text(
                          tvShowItem.originalName ?? 'No title',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ]);
              },
              options: CarouselOptions(
                  height: 200,
                  autoPlay: true,
                  viewportFraction: 0.9, // Adjusted to take up more horizontal space
                  autoPlayCurve: Curves.fastOutSlowIn,
                  autoPlayAnimationDuration: const Duration(seconds: 2),
                  enableInfiniteScroll: true,
                  reverse: false,
                  pageSnapping: true,
                  aspectRatio: 16 / 9,
                  initialPage: 0,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  scrollDirection: Axis.horizontal),
            ),
          );
        } else {
          return const Center(
            child: Text('No data'),
          );
        }
      },
    );
  }
}
