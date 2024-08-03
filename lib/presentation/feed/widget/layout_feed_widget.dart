import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/manager/widget/custom_spin_widget.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_bloc/shared_bloc.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_bloc/shared_event.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_bloc/shared_state.dart';
import 'package:tuannq_movie/presentation/feed/widget/error_status_widget.dart';
import 'package:tuannq_movie/presentation/feed/widget/post_body_image_widget.dart';
import 'package:tuannq_movie/presentation/feed/widget/post_bottom_widget.dart';
import 'package:tuannq_movie/presentation/feed/widget/user_header_widget.dart';

class LayoutFeedWidget extends StatelessWidget {
  const LayoutFeedWidget({
    super.key,
    required this.uid,
    required this.user,
  });
  final User user;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('enjoy_feed'.tr()),
        actions: [
          IconButton(
            onPressed: () {
              context.read<SharedBloc>().add(const GetAllSharedEvent());
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<SharedBloc, SharedState>(
          listener: (context, state) {
            if (state.status == Status.failure) {
              const ErrorStatusWidget();
            }
          },
          builder: (context, state) {
            if (state.status == Status.loading) {
              return Center(
                child: SpinCustomWidget(sized: 50.r),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.shared!.length,
              itemBuilder: (context, index) {
                final sharedItem = state.shared![index];
                return Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserHeader(sharedItem: sharedItem, uid: uid, user: user),
                      5.verticalSpace,
                      PostBodyImageWidget(sharedItem: sharedItem, uid: uid),
                      5.verticalSpace,
                      PostBottomWidget(
                        sharedItem: sharedItem,
                        uid: uid,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
