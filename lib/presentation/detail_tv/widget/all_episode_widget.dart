import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_constant.dart';
import '../../../domain/tv_show_detail/enitty/tv_detail_entity.dart';
import '../../../manager/color.dart';
import '../../../manager/widget/custom_spin_widget.dart';
import '../../home/widget/place_holder_image_widget.dart';

class AllEpisodeWidget extends StatelessWidget {
  final Season episode;
  const AllEpisodeWidget({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 130.h,
          margin: EdgeInsets.symmetric(horizontal: 8.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Row(
                    children: [
                      Container(
                        height: 70.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: episode.posterPath == null
                              ? AppConstant.defaultImageAvatar
                              : '${AppConstant.imagePathUrlW500}${episode.posterPath}',
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) => ClipRRect(
                            borderRadius: BorderRadius.circular(20.r),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                            child: SpinCustomWidget(sized: 50.r),
                          ),
                          errorWidget: (context, url, error) => const PlaceholderImage(),
                        ),
                      ),
                      10.horizontalSpace,
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              episode.name ?? 'NaN',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? TAppColor.whiteLightColor
                                    : TAppColor.darkFadeBlueColor,
                              ),
                            ),
                            10.verticalSpace,
                            Text(
                              '${episode.episodeCount.toString()} episode',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w300,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? TAppColor.whiteLightColor
                                    : TAppColor.darkFadeBlueColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                  // IconButton(
                  //   icon: const Icon(Icons.download_for_offline_outlined),
                  //   onPressed: () {},
                  // ),
                ],
              ),
              10.verticalSpace,
              Text(
                episode.overview!.isEmpty ? 'No overview available' : episode.overview.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w300),
              )
            ],
          ),
        ),
      ),
    );
  }
}
