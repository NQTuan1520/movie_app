import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/creadit/entity/credit_entity.dart';
import '../../../manager/color.dart';

class TextDetailOrTitleWidget extends StatelessWidget {
  final double sized;
  final String text;
  const TextDetailOrTitleWidget({super.key, required this.credit, required this.sized, required this.text});

  final CreditEntity credit;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: sized.sp,
        fontWeight: FontWeight.bold,
        color:
            Theme.of(context).brightness == Brightness.dark ? TAppColor.whiteLightColor : TAppColor.darkFadeBlueColor,
      ),
    );
  }
}
