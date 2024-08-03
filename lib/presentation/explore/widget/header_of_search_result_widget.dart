import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../manager/color.dart';
import '../result_of_search_by_keyword.dart';

class HeaderOfSearchResultWidget extends StatelessWidget {
  const HeaderOfSearchResultWidget({
    super.key,
    required this.widget,
  });

  final ResultMovieOfSearchByKeyword widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'search_for'.tr(),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).brightness == Brightness.dark
                ? TAppColor.whiteLightColor
                : TAppColor.darkFadeBlueColor,
          ),
        ),
        Text(
          '`${widget.keywordSearched}`',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).brightness == Brightness.dark
                ? TAppColor.whiteLightColor
                : TAppColor.darkFadeBlueColor,
          ),
        ),
      ],
    );
  }
}
