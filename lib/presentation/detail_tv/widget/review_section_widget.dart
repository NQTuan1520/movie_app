import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_constant.dart';
import '../../../domain/tv_show_detail/enitty/tv_detail_entity.dart';
import '../../../manager/enum/status_enum.dart';
import '../../../manager/widget/custom_spin_widget.dart';
import '../bloc/review/review_tv_bloc.dart';
import '../bloc/review/review_tv_event.dart';
import '../bloc/review/review_tv_state.dart';

class ReviewSectionWidget extends StatefulWidget {
  final TVDetailEntity tvDetailEntity;
  const ReviewSectionWidget({super.key, required this.tvDetailEntity});

  @override
  State<ReviewSectionWidget> createState() => _ReviewSectionWidgetState();
}

class _ReviewSectionWidgetState extends State<ReviewSectionWidget> {
  TVDetailEntity get tvDetailEntity => widget.tvDetailEntity;

  @override
  void initState() {
    super.initState();
    context.read<ReviewTvBloc>().add(GetReviewTVShowEvent(tvDetailEntity.id ?? 0));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Reviews',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          16.verticalSpace,
          SizedBox(
            width: double.infinity,
            height: 100.h,
            child: BlocBuilder<ReviewTvBloc, ReviewTvState>(
              builder: (context, state) {
                if (state.status == Status.loading) {
                  return SpinCustomWidget(sized: 50.r);
                } else if (state.status == Status.failure) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          'Error: ${state.message}',
                          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            context.read<ReviewTvBloc>().add(
                                  GetReviewTVShowEvent(tvDetailEntity.id ?? 0),
                                );
                          },
                          child: const Text('Retry'),
                        )
                      ],
                    ),
                  );
                } else if (state.status == Status.success) {
                  final reviewList = state.reviewList ?? [];
                  if (reviewList.isEmpty) {
                    return const Center(child: Text('No review'));
                  }
                  return ListView.builder(
                    itemCount: reviewList.length,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final review = reviewList[index];
                      return Container(
                        width: 350.w,
                        margin: EdgeInsets.only(right: 16.w),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 30.r,
                              backgroundImage: NetworkImage(
                                review.authorDetails?.avatarPath == null
                                    ? AppConstant.defaultImageAvatar
                                    : '${AppConstant.imagePathUrlOriginal}${review.authorDetails?.avatarPath}',
                              ),
                            ),
                            16.horizontalSpace,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        review.author ?? '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      8.horizontalSpace,
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 20.r,
                                          ),
                                          3.horizontalSpace,
                                          Text(
                                            review.authorDetails?.rating.toString() ?? '',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  8.verticalSpace,
                                  Text(
                                    review.content ?? '',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
