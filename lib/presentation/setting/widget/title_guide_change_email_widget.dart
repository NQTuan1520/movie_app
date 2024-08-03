import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';

class TitleGuideUserMailWidget extends StatelessWidget {
  const TitleGuideUserMailWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      height: 100.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Image.asset(
            AppConstant.securityImage,
            width: 60.w,
          ),
          16.horizontalSpace,
          Expanded(
            child: Text(
              'you_can_not_change_email'.tr(),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          )
        ],
      ),
    );
  }
}
