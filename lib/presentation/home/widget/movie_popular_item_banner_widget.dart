import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';
import 'package:tuannq_movie/manager/color.dart';
import 'package:tuannq_movie/presentation/home/widget/genre_chip_widget.dart';
import 'package:tuannq_movie/presentation/home/widget/place_holder_image_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MovieItem extends StatelessWidget {
  final dynamic movieItem;
  final PageController pageController;
  final GestureTapCallback onTap;

  const MovieItem({
    super.key,
    required this.movieItem,
    required this.pageController,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        CachedNetworkImage(
          imageUrl: '${AppConstant.imagePathUrlOriginal}${movieItem.posterPath}',
          fit: BoxFit.cover,
          imageBuilder: (context, imageProvider) => ClipRRect(
            child: Container(
              width: MediaQuery.of(context).size.width / 3,
              height: double.maxFinite,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.08),
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
                child: const Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) => const PlaceholderImage(),
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
          child: MovieInfo(
            movieItem: movieItem,
            onTap: onTap,
          ),
        ),
        Positioned(
          right: 16.w,
          bottom: 16.h,
          child: SmoothPageIndicator(
            controller: pageController,
            count: 5,
            effect: const WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              activeDotColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class MovieInfo extends StatelessWidget {
  final dynamic movieItem;
  final GestureTapCallback onTap;

  const MovieInfo({super.key, required this.movieItem, required this.onTap});

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
        Text(
          movieItem.title ?? 'No title',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 30.sp,
            fontWeight: FontWeight.bold,
            color:
                Theme.of(context).brightness == Brightness.dark ? TAppColor.whiteLightColor : TAppColor.whiteLightColor,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GenreChip(label: '${movieItem.releaseDate}'),
            ElevatedButton(
              onPressed: onTap,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.all(20.w),
              ),
              child: const Icon(Icons.play_arrow),
            ),
          ],
        ),
      ],
    );
  }
}
