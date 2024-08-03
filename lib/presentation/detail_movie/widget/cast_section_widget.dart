import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_constant.dart';
import '../../../manager/color.dart';
import '../../../manager/enum/status_enum.dart';
import '../../credit/screen/credit_detail_screen.dart';
import '../../home/widget/shimmer_actor_widget.dart';
import '../bloc/cast/cast_bloc.dart';
import '../bloc/cast/cast_state.dart';

class CastSectionWidget extends StatelessWidget {
  const CastSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CastBloc, CastState>(builder: (context, castState) {
      if (castState.status == Status.loading) {
        return const ShimmerPeopleListItem();
      } else if (castState.status == Status.success) {
        return SizedBox(
          height: 150.h,
          child: ListView.builder(
              itemCount: castState.casts.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final cast = castState.casts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => CreditDetailScreen(id: cast.creditId)));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 150.h,
                        width: 100.w,
                        padding: EdgeInsets.only(right: 16.w),
                        margin: EdgeInsets.only(right: 16.w),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: CachedNetworkImage(
                                imageUrl:
                                    cast.profilePath == null && cast.profilePath == '' && cast.profilePath == 'null'
                                        ? 'https://www.svgrepo.com/show/452030/avatar-default.svg'
                                        : '${AppConstant.imagePathUrlOriginal}${cast.profilePath}',
                                width: 85.w,
                                height: 85.h,
                                fit: BoxFit.cover,
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                            SizedBox(height: 5.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  cast.knownForDepartment ?? 'No name',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w300,
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? TAppColor.whiteLightColor
                                        : TAppColor.darkFadeBlueColor,
                                  ),
                                ),
                                7.verticalSpace,
                                Text(
                                  cast.originalName ?? 'No name',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.sp,
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
                      ),
                    ],
                  ),
                );
              }),
        );
      } else {
        return const SizedBox.shrink();
        // return Center(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text('Error: ${castState.messageError}'),
        //       ElevatedButton(
        //         onPressed: () {},
        //         child: const Text('Reload'),
        //       ),
        //     ],
        //   ),
        // );
      }
    });
  }
}
