import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //divider or continue with social
        const Expanded(
          child: Divider(
            color: Colors.white,
            thickness: 1,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 12.w),
          child: Text(
            'Or Continue With',
            style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w400),
          ),
        ),
        const Expanded(
          child: Divider(
            color: Colors.white,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
