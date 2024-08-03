import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/domain/auth/entity/user_entity.dart';

class RowUserNameSectionWidget extends StatelessWidget {
  const RowUserNameSectionWidget({
    super.key,
    required this.userInformation,
  });

  final UserEntity userInformation;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.only(right: 56.w),
          child: Text(
            'Username',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        Flexible(
          child: Text(
            userInformation.username,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        )
      ],
    );
  }
}
