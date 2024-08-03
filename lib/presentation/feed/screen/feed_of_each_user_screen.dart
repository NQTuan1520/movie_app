import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/di/injection.dart';
import 'package:tuannq_movie/domain/shared/usecase/shared_usecase.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/manager/widget/custom_spin_widget.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_persion/shared_persion_bloc.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_persion/shared_persion_event.dart';
import 'package:tuannq_movie/presentation/feed/bloc/shared_persion/shared_persion_state.dart';
import 'package:tuannq_movie/presentation/feed/widget/error_status_widget.dart';
import 'package:tuannq_movie/presentation/feed/widget/post_body_image_widget.dart';
import 'package:tuannq_movie/presentation/feed/widget/post_bottom_widget.dart';
import 'package:tuannq_movie/presentation/feed/widget/user_header_widget.dart';

class FeedOfEachUserScreen extends StatefulWidget {
  const FeedOfEachUserScreen({super.key});

  @override
  State<FeedOfEachUserScreen> createState() => _FeedOfEachUserScreenState();
}

class _FeedOfEachUserScreenState extends State<FeedOfEachUserScreen> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  String uid = '';
  User user = FirebaseAuth.instance.currentUser!;

  @override
  void initState() {
    super.initState();

    user = FirebaseAuth.instance.currentUser!;
    uid = user.uid;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SharedPersonBloc(
        sl<SharedPostUseCase>(),
      )..add(GetShareEventById(uid: uid)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('your_feed'.tr()),
          actions: [
            IconButton(
              onPressed: () {
                context.read<SharedPersonBloc>().add(GetShareEventById(uid: uid));
              },
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: SafeArea(
          child: BlocConsumer<SharedPersonBloc, SharedPersonState>(
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
              return state.shared!.isEmpty
                  ? const Center(
                      child: Text('No post yet'),
                    )
                  : ListView.builder(
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
                              10.verticalSpace,
                              PostBodyImageWidget(sharedItem: sharedItem, uid: uid),
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
      ),
    );
  }
}
