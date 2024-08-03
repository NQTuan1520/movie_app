import 'dart:typed_data';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/domain/auth/entity/user_entity.dart';
import 'package:tuannq_movie/manager/utils/utils.dart';
import 'package:tuannq_movie/manager/widget/custom_spin_widget.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_bloc.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_event.dart';
import 'package:tuannq_movie/presentation/auth/bloc/auth_state.dart';
import 'package:tuannq_movie/presentation/setting/widget/row_edit_button_widget.dart';
import 'package:tuannq_movie/presentation/setting/widget/row_email_section_widget.dart';
import 'package:tuannq_movie/presentation/setting/widget/row_image_section_widget.dart';
import 'package:tuannq_movie/presentation/setting/widget/row_username_section_widget.dart';
import 'package:tuannq_movie/presentation/setting/widget/title_guide_change_email_widget.dart';
import 'package:image_picker/image_picker.dart';

class ProfileDetailScreen extends StatefulWidget {
  final UserEntity user;
  const ProfileDetailScreen({super.key, required this.user});

  @override
  State<ProfileDetailScreen> createState() => _ProfileDetailScreenState();
}

class _ProfileDetailScreenState extends State<ProfileDetailScreen> {
  UserEntity get user => widget.user;
  late UserEntity _user;
  Uint8List? image;
  @override
  void initState() {
    super.initState();
    _user = user;
    context.read<AuthBloc>().add(GetInformationEvent());
  }

  void selectedImage() async {
    Uint8List img = await AppUtils.pickImage(ImageSource.gallery);
    setState(() {
      image = img;
    });
    if (!mounted) return;
    context.read<AuthBloc>().add(
          UpdateImageEvent(image: image!),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is UpdateImageProfileSuccess) {
                AppUtils.showCustomToastSuccess(
                  'success_chane_image'.tr(),
                  context,
                );
              }
            },
            builder: (context, state) {
              if (state is UpdateImageProfileLoading) {
                return SpinCustomWidget(sized: 50.r);
              }
              final userInformation = state is AuthAuthenticated ? state.user : _user;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowImageSectionWidget(
                    image: image,
                    userInformation: userInformation,
                    selectedImage: selectedImage,
                  ),
                  26.verticalSpace,
                  Text(
                    'your_profile'.tr(),
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600),
                  ),
                  16.verticalSpace,
                  const TitleGuideUserMailWidget(),
                  26.verticalSpace,
                  RowEditButtonSectionWidget(user: userInformation),
                  26.verticalSpace,
                  RowUserNameSectionWidget(userInformation: userInformation),
                  26.verticalSpace,
                  RowEmailSectionWidget(userInformation: userInformation),
                  26.verticalSpace,
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
