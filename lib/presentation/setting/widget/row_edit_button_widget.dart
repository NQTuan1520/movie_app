import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/domain/auth/entity/user_entity.dart';
import 'package:tuannq_movie/manager/color.dart';
import 'package:tuannq_movie/presentation/setting/edit_username_screen.dart';

class RowEditButtonSectionWidget extends StatelessWidget {
  const RowEditButtonSectionWidget({
    super.key,
    required UserEntity user,
  }) : _user = user;

  final UserEntity _user;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'general_information'.tr(),
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w300, color: Colors.grey),
        ),
        GestureDetector(
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditUsernameScreen(user: _user),
              ),
            );
          },
          child: Text(
            'edit'.tr(),
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: TAppColor.primaryColor),
          ),
        )
      ],
    );
  }
}
