import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../manager/widget/custom_spin_widget.dart';
import '../../home/widget/place_holder_image_widget.dart';

class ImageToPlayWidget extends StatelessWidget {
  final Map<String, String> video;
  final GestureTapCallback onTap;
  const ImageToPlayWidget({super.key, required this.video, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: video['image'] ?? '',
          fit: BoxFit.cover,
          imageBuilder: (context, imageProvider) => ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Container(
                  color: Colors.black.withOpacity(0.2),
                ),
              ),
            ),
          ),
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: SpinCustomWidget(sized: 50.r),
          ),
          errorWidget: (context, url, error) => const PlaceholderImage(),
        ),
        Center(
          child: IconButton(
            onPressed: () {
              onTap();
            },
            icon: const Icon(
              Icons.play_circle,
            ),
          ),
        )
      ],
    );
  }
}
