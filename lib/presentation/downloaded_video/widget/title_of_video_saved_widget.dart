import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../manager/color.dart';

class TitleOfVideoSavedWidget extends StatelessWidget {
  const TitleOfVideoSavedWidget({
    super.key,
    required this.video,
  });

  final Map<String, String> video;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            video['name'] ?? 'NaN',
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
        ],
      ),
    );
  }
}
