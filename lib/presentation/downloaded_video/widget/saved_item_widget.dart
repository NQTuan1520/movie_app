import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/presentation/downloaded_video/widget/title_of_video_saved_widget.dart';

import 'image_to_play_widget.dart';

class SavedItemWidget extends StatelessWidget {
  final Map<String, String> video;
  final GestureTapCallback onTap;

  const SavedItemWidget({
    super.key,
    required this.video,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      child: Container(
        height: 100.h,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        child: Row(
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
                    child: ImageToPlayWidget(
                      video: video,
                      onTap: () {
                        onTap();
                      },
                    ),
                  ),
                  10.horizontalSpace,
                  TitleOfVideoSavedWidget(video: video),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
