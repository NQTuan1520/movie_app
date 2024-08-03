import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/manager/color.dart';

class PreferenceItemWidget extends StatelessWidget {
  const PreferenceItemWidget({
    super.key,
    required this.context,
    required this.icon,
    required this.title,
    required this.trailing,
  });

  final BuildContext context;
  final IconData icon;
  final String title;
  final Widget trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(38),
        shape: BoxShape.rectangle,
        color: Theme.of(context).brightness == Brightness.dark ? TAppColor.darkFadeBlueColor : TAppColor.whiteGreyColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon),
            SizedBox(width: 16.w),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Spacer(),
            trailing,
          ],
        ),
      ),
    );
  }
}
