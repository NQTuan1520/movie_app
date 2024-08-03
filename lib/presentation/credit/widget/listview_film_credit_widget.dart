import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constant/app_constant.dart';
import '../../../domain/creadit/entity/credit_entity.dart';
import '../../../manager/color.dart';
import '../../../manager/widget/custom_spin_widget.dart';
import '../../home/widget/place_holder_image_widget.dart';
import '../bloc/credit_detail_bloc/credit_detail_state.dart';

class ListViewFilmOfCreditWidget extends StatelessWidget {
  final CreditDetailState state;
  const ListViewFilmOfCreditWidget({super.key, required this.credit, required this.state});

  final CreditEntity credit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160.h,
      child: ListView.builder(
          itemCount: state.creditEntity.media!.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(right: 12.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: Stack(children: [
                  Container(
                    height: 160.h,
                    width: MediaQuery.of(context).size.width / 1.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: '${AppConstant.imagePathUrlW500}${credit.media![index].posterPath}',
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => ClipRRect(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.08),
                            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
                        padding: const EdgeInsetsDirectional.only(end: 14),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width / 3,
                            height: double.maxFinite,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.08),
                            ),
                            child: const Center(
                              child: SpinCustomWidget(sized: 50),
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => const PlaceholderImage(),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: 45.h,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              credit.media![index].firstAirDate ?? '',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w300,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? TAppColor.whiteLightColor
                                    : TAppColor.whiteGreyColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${credit.media![index].originalName}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? TAppColor.whiteLightColor
                                    : TAppColor.whiteGreyColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            );
          }),
    );
  }
}
