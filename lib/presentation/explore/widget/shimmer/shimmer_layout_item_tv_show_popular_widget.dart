import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTvShowPopularItemWidget extends StatelessWidget {
  const ShimmerTvShowPopularItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180.h,
            width: 120.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          8.verticalSpace,
          Container(
            width: 120.w,
            height: 20.h,
            color: Colors.white,
          ),
          4.verticalSpace,
          Container(
            width: 80.w,
            height: 20.h,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
