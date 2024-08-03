import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../color.dart';

class CustomDialogWidget extends StatelessWidget {
  final String titleWarning;
  final GestureTapCallback submitCallback;

  const CustomDialogWidget({super.key, required this.titleWarning, required this.submitCallback});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          CardDialog(
            titleWarning: titleWarning,
            submitCallback: submitCallback,
          ),
        ],
      ),
    );
  }
}

class CardDialog extends StatelessWidget {
  const CardDialog({
    super.key,
    required this.titleWarning,
    required this.submitCallback,
  });

  final String titleWarning;
  final GestureTapCallback submitCallback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
      margin: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark
              ? TAppColor.darkFadeBlueColor
              : TAppColor.darkFadeBlueColor,
          borderRadius: BorderRadius.circular(12.r)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/img/danger.png',
            width: 70.w,
          ),
          20.verticalSpace,
          Text(
            'Alert',
            style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w500, color: const Color(0xFFEC5B5B)),
          ),
          5.verticalSpace,
          Text(
            titleWarning,
            textAlign: TextAlign.center,
            style: TextStyle(
              color:
                  Theme.of(context).brightness == Brightness.dark ? TAppColor.whiteGreyColor : TAppColor.whiteGreyColor,
              fontWeight: FontWeight.w300,
            ),
          ),
          32.verticalSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 22.w),
                      foregroundColor: const Color(0xFFEC5B5B),
                      side: const BorderSide(color: Color(0xFFEC5B5B))),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('I understand'),
                ),
              ),
              // 10.horizontalSpace,
              // Expanded(
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       padding:
              //           EdgeInsets.symmetric(vertical: 8.h, horizontal: 22.w),
              //       foregroundColor: const Color(0xFF2A303E),
              //       backgroundColor: const Color(0xFF5BEC84),
              //     ),
              //     onPressed: submitCallback,
              //     child: const Text('Yes'),
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}
