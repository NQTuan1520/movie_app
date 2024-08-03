import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';
import 'package:tuannq_movie/domain/shared/entity/shared_entity.dart';
import 'package:tuannq_movie/manager/color.dart';
import 'package:tuannq_movie/presentation/detail_movie/screen/details_movie_screen.dart';

class PostBodyImageWidget extends StatelessWidget {
  const PostBodyImageWidget({
    super.key,
    required this.sharedItem,
    required this.uid,
  });

  final SharedEntity sharedItem;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SizedBox(
        height: 350.h,
        width: double.infinity,
        child: ClipRRect(
          child: CachedNetworkImage(
            imageUrl: '${AppConstant.imagePathUrlOriginal}${sharedItem.posterPath}',
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Column(
              children: [
                25.verticalSpace,
                const Icon(Icons.error),
                Text('something_wrong'.tr()),
              ],
            ),
          ),
        ),
      ),
      Positioned(
          top: 10.h,
          right: 10.w,
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MovieDetailScreen(idMovie: sharedItem.idMovie ?? 0, uid: uid),
                ),
              );
            },
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: const Icon(Icons.ads_click_outlined, color: TAppColor.primaryColor),
            ),
          ))
    ]);
  }
}
