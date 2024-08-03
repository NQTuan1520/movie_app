import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constant/app_constant.dart';
import '../../../domain/tv_show_detail/enitty/tv_detail_entity.dart';
import '../../../manager/color.dart';
import '../../../manager/widget/button_back_widget.dart';
import '../../../manager/widget/custom_spin_widget.dart';
import '../../home/widget/place_holder_image_widget.dart';

class AppBarSectionWidget extends StatelessWidget {
  const AppBarSectionWidget({
    super.key,
    required this.tvDetail,
    required this.lastAirYear,
  });

  final TVDetailEntity tvDetail;
  final String lastAirYear;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: AppConstant.expandedHeightDetailTV.h,
      leading: const ButtonBackWidget(),
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: '${AppConstant.imagePathUrlW500}${tvDetail.backdropPath}',
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
                    child: SpinCustomWidget(sized: 50.r),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const PlaceholderImage(),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
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
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      tvDetail.name ?? 'No title',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    10.verticalSpace,
                    Text(
                      tvDetail.overview ?? 'No date',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    10.verticalSpace,
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 16.w, // space between items horizontally
                      runSpacing: 10.h, // space between rows
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.calendar_month,
                              color: Colors.white,
                              size: 26.sp,
                            ),
                            8.horizontalSpace,
                            Text(
                              lastAirYear,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.hourglass_bottom,
                              color: Colors.white,
                              size: 26.sp,
                            ),
                            8.horizontalSpace,
                            Text(
                              '${tvDetail.seasons!.length.toString()} seasons',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.movie_creation,
                              color: Colors.white,
                              size: 26.sp,
                            ),
                            8.horizontalSpace,
                            // map to get genres
                            Flexible(
                              child: Text(
                                tvDetail.genres != null
                                    ? tvDetail.genres!.map((e) => e.name).toList().join(', ')
                                    : 'No genres',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    26.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              const Icon(Icons.play_arrow),
                              8.horizontalSpace,
                              const Text(
                                'Play',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            ],
                          ),
                        ),
                        16.horizontalSpace,
                        // Container(
                        //   height: 48.h,
                        //   width: 48.w,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(24.r),
                        //   ),
                        //   child: const Icon(
                        //     Icons.download_rounded,
                        //     color: TAppColor.primaryColor,
                        //   ),
                        // ),
                        16.horizontalSpace,
                        GestureDetector(
                          onTap: () {
                            _launchUrl(tvDetail.homepage!, context);
                          },
                          child: Container(
                            height: 48.h,
                            width: 48.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24.r),
                            ),
                            child: const Icon(
                              Icons.link,
                              color: TAppColor.primaryColor,
                            ),
                          ),
                        ),
                        16.horizontalSpace,
                        // Container(
                        //   height: 48.h,
                        //   width: 48.w,
                        //   decoration: BoxDecoration(
                        //     color: Colors.white,
                        //     borderRadius: BorderRadius.circular(24.r),
                        //   ),
                        //   child: const Icon(
                        //     Icons.favorite_border,
                        //     color: TAppColor.primaryColor,
                        //   ),
                        // )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url, BuildContext context) async {
    if (url.isNotEmpty) {
      final Uri? uri = Uri.tryParse(url);
      if (uri != null && await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        // ignore: use_build_context_synchronously
        _showErrorDialog(context, 'Opps !! No url found');
      }
    } else {
      _showErrorDialog(context, 'Opps !! No url found');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
