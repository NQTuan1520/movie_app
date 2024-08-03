import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../manager/color.dart';
import '../../../manager/enum/status_enum.dart';
import '../../../manager/widget/custom_spin_widget.dart';
import '../bloc/review/review_bloc.dart';
import '../bloc/review/review_state.dart';

class ReviewsSectionWidget extends StatelessWidget {
  const ReviewsSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReviewBloc, ReviewState>(
      builder: (context, reviewState) {
        final reviewToShowList = reviewState.reviews.take(3).toList();
        if (reviewState.status == Status.loading) {
          return SpinCustomWidget(sized: 50.r);
        } else if (reviewState.status == Status.success) {
          return ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: reviewToShowList.length,
              itemBuilder: (context, index) {
                final review = reviewToShowList[index];
                return Container(
                  height: 120.h,
                  margin: EdgeInsets.only(bottom: 10.h),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${review.authorDetails!.username}  •  ${review.createdAt}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? TAppColor.whiteLightColor.withOpacity(0.2)
                                  : TAppColor.darkFadeBlueColor.withOpacity(0.2),
                            ),
                          ),
                          5.verticalSpace,
                          Text(
                            review.content ?? 'No content',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? TAppColor.whiteLightColor
                                  : TAppColor.darkFadeBlueColor,
                            ),
                          ),
                          5.verticalSpace,
                          Row(
                            children: [
                              const Icon(Icons.star, color: Colors.amber),
                              5.horizontalSpace,
                              Text(
                                review.authorDetails!.rating != null
                                    ? '${review.authorDetails!.rating!.toStringAsFixed(1)}/10'
                                    : '0/10',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? TAppColor.whiteLightColor
                                      : TAppColor.darkFadeBlueColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        } else if (reviewState.status == Status.failure) {
          return const SizedBox.shrink();
          // return Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text('Error: ${reviewState.message}'),
          //       ElevatedButton(
          //         onPressed: () {},
          //         child: const Text('Reload'),
          //       ),
          //     ],
          //   ),
          // );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
