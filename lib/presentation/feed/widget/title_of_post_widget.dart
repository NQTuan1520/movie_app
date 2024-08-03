import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/domain/shared/entity/shared_entity.dart';

class TitleOfPostWidget extends StatelessWidget {
  const TitleOfPostWidget({
    super.key,
    required this.sharedItem,
  });

  final SharedEntity sharedItem;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(sharedItem.username ?? 'No name', style: const TextStyle(fontWeight: FontWeight.bold)),
        7.horizontalSpace,
        Flexible(
          child: Text(
            "${sharedItem.titleShared}",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
