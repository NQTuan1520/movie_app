import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class ImageMemoryFromGalleryWidget extends StatelessWidget {
  const ImageMemoryFromGalleryWidget({
    super.key,
    required this.image,
  });

  final Uint8List? image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96.h,
      width: 96.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: Image.memory(
          image!,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
