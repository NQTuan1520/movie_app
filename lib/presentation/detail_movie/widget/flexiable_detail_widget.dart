import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_constant.dart';
import '../../../manager/color.dart';
import '../../../manager/enum/status_enum.dart';
import '../../../manager/widget/custom_spin_widget.dart';
import '../../home/widget/genre_chip_widget.dart';
import '../../home/widget/shimmer_popular_item.dart';
import '../../trailer/screen/trailer_watch_screen.dart';
import '../bloc/detail_movie/detail_of_movie_bloc.dart';
import '../bloc/detail_movie/detail_of_movie_state.dart';
import '../bloc/image/image_bloc.dart';
import '../bloc/image/image_state.dart';

class FlexibleDetailMovieWidget extends StatefulWidget {
  final GestureTapCallback onTap;
  const FlexibleDetailMovieWidget({super.key, required this.pageController, required this.onTap});

  final PageController pageController;

  @override
  State<FlexibleDetailMovieWidget> createState() => _FlexibleDetailMovieWidgetState();
}

class _FlexibleDetailMovieWidgetState extends State<FlexibleDetailMovieWidget> {
  late Timer timer;
  int _currentPage = 0;

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 5 - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      widget.pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailOfMovieBloc, DetailOfMovieState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        final movieItem = state.movieDetail;
        if (state.status == Status.loading) {
          return const ShimmerMovieItem();
        } else if (state.status == Status.failure) {
          return AlertDialog(
            title: const Text("Some things wrong please try again"),
            actions: [
              IconButton(
                  onPressed: () {
                    widget.onTap();
                  },
                  icon: const Icon(Icons.refresh))
            ],
          );
        }
        return BlocBuilder<ImageBloc, ImageState>(
          builder: (context, imageState) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                PageView.builder(
                  controller: widget.pageController,
                  itemCount: imageState.imageList.length,
                  itemBuilder: (context, index) {
                    if (imageState.imageList.isEmpty) {
                      return const Icon(Icons.error);
                    }
                    return CachedNetworkImage(
                      imageUrl: imageState.imageList[index].filePath != null &&
                              imageState.imageList[index].filePath!.isNotEmpty &&
                              imageState.imageList[index].filePath!.isNotEmpty
                          ? '${AppConstant.imagePathUrlOriginal}${imageState.imageList[index].filePath}'
                          : '${movieItem.posterPath}',
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => ClipRRect(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.08),
                            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
                        padding: const EdgeInsetsDirectional.only(end: 14),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: double.maxFinite,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.08),
                            ),
                            child: Center(
                              child: SpinCustomWidget(sized: 50.r),
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    );
                  },
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.0, 1.0),
                      end: Alignment(0.0, 0.0),
                      colors: <Color>[
                        Color(0x60000000),
                        Color(0x00000000),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 16.w,
                  right: 16.w,
                  bottom: 36.h,
                  child: MovieInfo(movieItem: movieItem),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class MovieInfo extends StatelessWidget {
  final dynamic movieItem;

  const MovieInfo({super.key, required this.movieItem});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 80.w,
          height: 30.h,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                SizedBox(width: 4.w),
                Text(
                  '${movieItem.voteAverage!.toStringAsFixed(1)}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GenreChip(label: '${movieItem.releaseDate}'),
          ],
        ),
        10.verticalSpace,
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WatchTrailerScreen(
                                movie: movieItem,
                              )));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                        topLeft: Radius.circular(20.r),
                        bottomLeft: Radius.circular(20.r)),
                  ),
                  padding: EdgeInsets.all(15.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.movie_filter, color: TAppColor.primaryColor),
                    10.horizontalSpace,
                    Text(
                      'watch_trailer'.tr(),
                      style: TextStyle(fontWeight: FontWeight.w600, color: TAppColor.primaryColor, fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
