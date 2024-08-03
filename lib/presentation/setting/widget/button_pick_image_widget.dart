import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/manager/color.dart';

class ButtonPickImage extends StatelessWidget {
  final GestureTapCallback selectedImage;
  const ButtonPickImage({super.key, required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35.h,
      width: 35.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: Theme.of(context).brightness == Brightness.dark ? TAppColor.darkFadeBlueColor : TAppColor.whiteGreyColor,
      ),
      child: Center(
        child: IconButton(
          onPressed: () {
            selectedImage();
          },
          icon: const Icon(
            Icons.camera_alt_outlined,
          ),
        ),
      ),
    );
  }
}
