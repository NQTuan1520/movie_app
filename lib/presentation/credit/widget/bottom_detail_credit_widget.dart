import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/creadit/entity/credit_entity.dart';
import '../../../manager/color.dart';

class BottomDetailCreditWidget extends StatelessWidget {
  const BottomDetailCreditWidget({
    super.key,
    required this.credit,
  });

  final CreditEntity credit;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            '• ${credit.job}',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w300,
              color: Theme.of(context).brightness == Brightness.dark
                  ? TAppColor.whiteLightColor
                  : TAppColor.darkFadeBlueColor,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          credit.person!.gender == 1
              ? 'Female'
              : credit.person!.gender == 2
                  ? 'Male'
                  : 'Not specified',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w300,
            color: Theme.of(context).brightness == Brightness.dark
                ? TAppColor.whiteLightColor
                : TAppColor.darkFadeBlueColor,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
