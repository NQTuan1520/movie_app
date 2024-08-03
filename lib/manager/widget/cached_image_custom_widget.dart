import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/app_constant.dart';
import '../../presentation/home/widget/place_holder_image_widget.dart';
import '../../presentation/trailer/screen/trailer_watch_screen.dart';
import 'custom_spin_widget.dart';

class CachedImageCustomWidget extends StatelessWidget {
  const CachedImageCustomWidget({
    super.key,
    required this.widget,
    required this.imageUrl,
  });

  final String imageUrl;

  final WatchTrailerScreen widget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: '${AppConstant.imagePathUrlOriginal}$imageUrl',
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
            child: Center(
              child: SpinCustomWidget(sized: 50.r),
            ),
          ),
        ),
      ),
      errorWidget: (context, url, error) => const PlaceholderImage(),
    );
  }
}
