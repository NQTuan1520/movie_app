import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerTrendingWidget extends StatelessWidget {
  const ShimmerTrendingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.red[600]!,
      highlightColor: Colors.red[100]!,
      child: GridView.builder(
        padding: EdgeInsets.zero,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0.w,
          mainAxisSpacing: 16.0.h,
          childAspectRatio: 0.7,
        ),
        itemCount: 6,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0.w),
                color: Colors.white,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0.w),
                color: Colors.white,
              ),
            ],
          );
        },
      ),
    );
  }
}
