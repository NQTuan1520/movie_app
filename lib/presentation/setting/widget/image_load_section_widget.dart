import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/domain/auth/entity/user_entity.dart';
import 'package:tuannq_movie/manager/widget/custom_spin_widget.dart';

class ImageLoadFromDataWidget extends StatelessWidget {
  const ImageLoadFromDataWidget({
    super.key,
    required this.userInformation,
  });

  final UserEntity userInformation;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96.h,
      width: 96.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: CachedNetworkImage(
          imageUrl: userInformation.image,
          fit: BoxFit.cover,
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
                child: Center(
                  child: SpinCustomWidget(sized: 50.r),
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
