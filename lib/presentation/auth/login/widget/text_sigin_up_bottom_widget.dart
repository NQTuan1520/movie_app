import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../manager/color.dart';

class TextSignUpBottomWidget extends StatelessWidget {
  final GestureTapCallback callback;
  const TextSignUpBottomWidget({
    super.key,
    required this.callback,
    required this.text1,
    required this.text2,
  });

  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text1,
          style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w400),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: callback,
          child: Text(
            text2,
            style: const TextStyle(
              color: TAppColor.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
