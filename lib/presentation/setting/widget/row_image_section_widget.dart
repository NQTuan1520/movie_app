import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/domain/auth/entity/user_entity.dart';

import 'package:tuannq_movie/presentation/setting/widget/button_pick_image_widget.dart';
import 'package:tuannq_movie/presentation/setting/widget/image_load_section_widget.dart';
import 'package:tuannq_movie/presentation/setting/widget/image_memory_to_show_widget.dart';

class RowImageSectionWidget extends StatelessWidget {
  final Uint8List? image;
  final UserEntity userInformation;
  final GestureTapCallback selectedImage;
  const RowImageSectionWidget(
      {super.key, required this.image, required this.userInformation, required this.selectedImage});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            image != null
                ? ImageMemoryFromGalleryWidget(image: image)
                : ImageLoadFromDataWidget(userInformation: userInformation),
            Positioned(
              bottom: 0,
              right: 5,
              child: ButtonPickImage(
                selectedImage: selectedImage,
              ),
            ),
          ],
        ),
        16.horizontalSpace,
      ],
    );
  }
}
