import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/manager/color.dart';
import 'package:tuannq_movie/presentation/detail_people/screen/detail_persion_screen.dart';

class PeopleListItemWidget extends StatelessWidget {
  final String imagePathUrl;
  final String profilePath;
  final String name;
  final int id;

  const PeopleListItemWidget(
      {super.key, required this.imagePathUrl, required this.profilePath, required this.name, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => DetailPersonScreen(personId: id),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100.w,
            height: 120.h,
            margin: EdgeInsets.only(right: 16.w),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: CachedNetworkImage(
                    imageUrl: '$imagePathUrl$profilePath',
                    width: 85.w,
                    height: 85.h,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Container(
                      width: 85.w,
                      height: 85.h,
                      color: TAppColor.greyColor,
                      child: Icon(
                        Icons.person,
                        color: TAppColor.whiteLightColor,
                        size: 50.sp,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.isNotEmpty ? name : 'No name',
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
  }
}
