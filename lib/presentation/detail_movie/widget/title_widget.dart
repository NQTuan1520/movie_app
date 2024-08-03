import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../manager/color.dart';

class TitleWidget extends StatelessWidget {
  final String title;
  const TitleWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
        color:
            Theme.of(context).brightness == Brightness.dark ? TAppColor.whiteLightColor : TAppColor.darkFadeBlueColor,
      ),
    );
  }
}
