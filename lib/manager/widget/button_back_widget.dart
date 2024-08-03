import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color.dart';

class ButtonBackWidget extends StatelessWidget {
  const ButtonBackWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 8.w, top: 8.h),
      width: 40.w,
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Theme.of(context).brightness == Brightness.dark ? TAppColor.whiteLightColor : TAppColor.whiteGreyColor,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
