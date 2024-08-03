import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/creadit/entity/credit_entity.dart';

class QuickFactOfCreditWidget extends StatelessWidget {
  const QuickFactOfCreditWidget({
    super.key,
    required this.credit,
  });

  final CreditEntity credit;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('popularities'.tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
          5.horizontalSpace,
          Text(credit.person!.popularity!.toStringAsFixed(2),
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp)),
        ],
      ),
      10.verticalSpace,
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('credit_title'.tr(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
          5.horizontalSpace,
          Expanded(
            child: Text(
                maxLines: 1,
                credit.creditEntityType!.toUpperCase(),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp)),
          ),
        ],
      ),
    ]);
  }
}
