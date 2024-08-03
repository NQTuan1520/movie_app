import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_constant.dart';
import '../../../domain/tv_show_detail/enitty/tv_detail_entity.dart';
import '../../../manager/enum/status_enum.dart';
import '../../../manager/widget/custom_spin_widget.dart';
import '../bloc/similar_tv_show/similar_tv_show_bloc.dart';
import '../bloc/similar_tv_show/similar_tv_show_event.dart';
import '../bloc/similar_tv_show/similar_tv_show_state.dart';
import '../screen/detail_tv_screen.dart';

class SimilarTvShowSectionWidget extends StatefulWidget {
  final TVDetailEntity tvDetailEntity;
  const SimilarTvShowSectionWidget({super.key, required this.tvDetailEntity});

  @override
  State<SimilarTvShowSectionWidget> createState() => _SimilarTvShowSectionWidgetState();
}

class _SimilarTvShowSectionWidgetState extends State<SimilarTvShowSectionWidget> {
  @override
  void initState() {
    super.initState();
    context.read<SimilarTvShowBloc>().add(GetSimilarTVEvent(widget.tvDetailEntity.id.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Recommended for you',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            26.verticalSpace,
            SizedBox(
              width: double.infinity,
              height: 300.h,
              child: BlocBuilder<SimilarTvShowBloc, SimilarTvShowState>(
                builder: (context, state) {
                  if (state.status == Status.loading) {
                    return Center(
                      child: SpinCustomWidget(
                        sized: 50.r,
                      ),
                    );
                  } else if (state.status == Status.failure) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                              context
                                  .read<SimilarTvShowBloc>()
                                  .add(GetSimilarTVEvent(widget.tvDetailEntity.id.toString()));
                            },
                            child: const Text('Retry'),
                          )
                        ],
                      ),
                    );
                  } else if (state.status == Status.success) {
                    final similarList = state.tvShows ?? [];

                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemCount: similarList.length,
                        itemBuilder: (context, index) {
                          final tvShow = similarList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailTvScreen(
                                    idTvShow: tvShow.id ?? 0,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 16.w),
                              child: SizedBox(
                                width: 150.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8.r),
                                      child: CachedNetworkImage(
                                        imageUrl: tvShow.posterPath == null
                                            ? AppConstant.defaultImageAvatar
                                            : 'https://image.tmdb.org/t/p/w500${tvShow.posterPath}',
                                        width: 150.w,
                                        height: 200.h,
                                        fit: BoxFit.cover,
                                        errorListener: (value) {},
                                        errorWidget: (context, url, error) {
                                          return Image.asset('assets/img/oops.png');
                                        },
                                      ),
                                    ),
                                    8.verticalSpace,
                                    Text(
                                      tvShow.name ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      tvShow.firstAirDate ?? '',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.grey,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  }

                  return const SizedBox.shrink();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
