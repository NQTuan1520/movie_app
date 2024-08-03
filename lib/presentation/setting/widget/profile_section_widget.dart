import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/manager/color.dart';
import 'package:tuannq_movie/manager/widget/custom_spin_widget.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_bloc.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_state.dart';
import 'package:tuannq_movie/presentation/setting/profile_detail_screen.dart';

class ProfileSectionWidget extends StatelessWidget {
  const ProfileSectionWidget({
    super.key,
    required this.user,
    required this.context,
  });

  final User user;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          if (authState is AuthAuthenticated) {
            return Row(
              children: [
                AvatarUserWidget(user: user, state: authState),
                16.horizontalSpace,
                InfoUserWidget(state: authState)
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}

class InfoUserWidget extends StatelessWidget {
  final AuthAuthenticated state;
  const InfoUserWidget({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'hello'.tr(),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Row(
            children: [
              Flexible(
                child: Text(
                  state.user.username,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              SizedBox(
                width: 10.w,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProfileDetailScreen(
                                user: state.user,
                              )));
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? TAppColor.darkFadeBlueColor
                        : TAppColor.whiteGreyColor,
                  ),
                  child: Icon(
                    Icons.edit,
                    size: 16.r,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class AvatarUserWidget extends StatelessWidget {
  AuthAuthenticated state;

  AvatarUserWidget({
    super.key,
    required this.user,
    required this.state,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 96.h,
      width: 96.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50.0),
        child: CachedNetworkImage(
          imageUrl: state.user.image,
          fit: BoxFit.cover,
          progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
            padding: const EdgeInsetsDirectional.only(end: 14),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                width: MediaQuery.of(context).size.width / 3,
                height: double.maxFinite,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.08),
                ),
                child: Center(
                  child: SpinCustomWidget(sized: 50.r),
                ),
              ),
            ),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      ),
    );
  }
}
