import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../manager/color.dart';

class TitleWithSeeAllWidget extends StatelessWidget {
  final GestureTapCallback callback;
  final String title;
  final String seeAll;
  const TitleWithSeeAllWidget({super.key, required this.callback, required this.title, required this.seeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? TAppColor.whiteLightColor
                : TAppColor.darkFadeBlueColor,
          ),
        ),
        GestureDetector(
          onTap: callback,
          child: Text(
            seeAll,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              color: Theme.of(context).brightness == Brightness.dark
                  ? TAppColor.whiteLightColor
                  : TAppColor.darkFadeBlueColor,
            ),
          ),
        ),
      ],
    );
  }
}
