import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/manager/color.dart';

class TopRatedMovieListItemWidget extends StatelessWidget {
  final String imagePathUrl;
  final String posterPath;
  final String title;
  final double voteAverage;
  final double popularity;
  final GestureTapCallback onTap;

  const TopRatedMovieListItemWidget({
    super.key,
    required this.imagePathUrl,
    required this.posterPath,
    required this.title,
    required this.voteAverage,
    required this.popularity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: 12.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Container(
                    width: 150.w,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          '$imagePathUrl$posterPath',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0.w,
                  top: 15.h,
                  child: Container(
                    width: 76.w,
                    height: 26.h,
                    decoration: const BoxDecoration(
                      color: TAppColor.primaryColor, // Use your primary color here
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 24.r,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            voteAverage.toStringAsFixed(1),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? TAppColor.whiteLightColor
                                  : TAppColor.whiteLightColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title.isNotEmpty ? title : 'No title',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? TAppColor.whiteLightColor
                        : TAppColor.darkFadeBlueColor,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.remove_red_eye_outlined,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? TAppColor.whiteLightColor
                          : TAppColor.darkFadeBlueColor,
                      size: 16.r,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      popularity.toStringAsFixed(0),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).brightness == Brightness.dark
                            ? TAppColor.whiteLightColor
                            : TAppColor.darkFadeBlueColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 35.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: TAppColor.primaryColor,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'watch_now'.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: TAppColor.primaryColor,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
