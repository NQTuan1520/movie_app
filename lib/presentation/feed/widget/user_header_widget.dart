import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';
import 'package:tuannq_movie/domain/shared/entity/shared_entity.dart';
import 'package:tuannq_movie/manager/utils/utils.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_bloc/shared_bloc.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_bloc/shared_event.dart';

class UserHeader extends StatelessWidget {
  final SharedEntity sharedItem;
  final String uid;
  final User user;
  const UserHeader({super.key, required this.sharedItem, required this.uid, required this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Row(
        children: [
          Row(
            children: [
              SizedBox(
                height: 40.h,
                width: 40.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: CachedNetworkImage(imageUrl: sharedItem.avatar ?? AppConstant.defaultImageAvatar),
                ),
              ),
              10.horizontalSpace,
              Text(
                sharedItem.email ?? 'No name',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
          const Spacer(),
          PopupMenuButton<String>(
            onSelected: (String value) {
              if (value == 'Edit') {
                AppUtils.showBottomDialogShared(context, sharedItem, user);
              } else if (value == 'Delete') {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('move_to_trash'.tr()),
                      content: Text('it_will_be'.tr()),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<SharedBloc>().add(
                                  DeleteSharedEvent(id: sharedItem.id ?? ''),
                                );
                            context.read<SharedBloc>().add(
                                  const GetAllSharedEvent(),
                                );
                            Navigator.pop(context);
                          },
                          child: const Text('Delete'),
                        ),
                      ],
                    );
                  },
                );
              } else if (value == 'Report') {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Report post'),
                      content: const Text('Do you want to report this post?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Implement report functionality
                            Navigator.pop(context);
                          },
                          child: const Text('Report'),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return sharedItem.uid == uid
                  ? <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Edit',
                        child: Row(
                          children: [
                            Icon(Icons.edit),
                            SizedBox(width: 8),
                            Text('Edit post'),
                          ],
                        ),
                      ),
                      const PopupMenuItem<String>(
                        value: 'Delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete post'),
                          ],
                        ),
                      ),
                    ]
                  : <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'Report',
                        child: Row(
                          children: [
                            Icon(Icons.report, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Report this post'),
                          ],
                        ),
                      ),
                    ];
            },
            icon: const Icon(Icons.more_vert),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            elevation: 5,
          ),
        ],
      ),
    );
  }
}
