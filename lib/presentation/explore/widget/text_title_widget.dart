import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/manager/color.dart';

class TextTitleExploreWidget extends StatelessWidget {
  final String title;
  const TextTitleExploreWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      // 'TV Shows Airing Today',
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.bold,
        color:
            Theme.of(context).brightness == Brightness.dark ? TAppColor.whiteLightColor : TAppColor.darkFadeBlueColor,
      ),
    );
  }
}
