import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/domain/shared/entity/shared_entity.dart';
import 'package:tuannq_movie/manager/color.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_bloc/shared_bloc.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_bloc/shared_event.dart';

class BottomDialogFormWidget extends StatelessWidget {
  const BottomDialogFormWidget({
    super.key,
    required this.formKey,
    required this.user,
    required this.controller,
    required this.shared,
  });
  final SharedEntity shared;
  final GlobalKey<FormState> formKey;
  final User user;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0.r),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.dark
            ? TAppColor.darkFadeBlueColor.withOpacity(0.01)
            : Colors.grey[200],
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 45.h,
                  width: 45.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: CachedNetworkImage(
                        imageUrl: user.photoURL ??
                            'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?w=740&t=st=1718808548~exp=1718809148~hmac=a03c64ae84f93beff4f553c19ed05f830cb8c9cb60c0696018cc967ba94f06c1'),
                  ),
                ),
                10.horizontalSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.email ?? 'No name',
                      style: TextStyle(
                        color: Theme.of(context).brightness == Brightness.dark
                            ? TAppColor.whiteLightColor
                            : TAppColor.darkFadeBlueColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      'Share everything you want!',
                      style: TextStyle(
                        color:
                            Theme.of(context).brightness == Brightness.dark ? TAppColor.greyColor : TAppColor.greyColor,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ],
                )
              ],
            ),
            20.verticalSpace,
            TextFormField(
              controller: controller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'please_enter_des'.tr();
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: 'write_st'.tr(),
                hintStyle: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark ? TAppColor.greyColor : TAppColor.greyColor,
                ),
                border: InputBorder.none,
              ),
              maxLines: 5,
            ),
            10.verticalSpace,
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState?.validate() == true) {
                  final entity = shared.copyWith(
                    titleShared: controller.text,
                  );

                  context.read<SharedBloc>().add(UpdateSharedEvent(sharedEntity: entity, id: entity.id ?? ''));
                  context.read<SharedBloc>().add(const GetAllSharedEvent());
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15.0.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28.r),
                ),
              ),
              child: const Text('Share'),
            ),
          ],
        ),
      ),
    );
  }
}
