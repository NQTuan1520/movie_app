import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/manager/color.dart';

class TitleNoStateWidget extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;
  const TitleNoStateWidget({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? TAppColor.whiteLightColor
                : TAppColor.darkFadeBlueColor,
          ),
        ),
        SizedBox(width: 8.w),
        IconButton(
          onPressed: () {
            onTap();
          },
          icon: Icon(
            size: 20.sp,
            Icons.arrow_forward_ios,
            color: Theme.of(context).brightness == Brightness.dark
                ? TAppColor.whiteLightColor
                : TAppColor.darkFadeBlueColor,
          ),
        ),
      ],
    );
  }
}
