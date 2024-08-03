import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_constant.dart';
import '../../../di/injection.dart';
import '../../../domain/detail_people/usecase/detail_person_usecase.dart';
import '../../../manager/color.dart';
import '../../../manager/enum/status_enum.dart';
import '../../../manager/widget/button_back_widget.dart';
import '../../../manager/widget/custom_spin_widget.dart';
import '../../../manager/widget/layout_error_widget.dart';
import '../../home/widget/place_holder_image_widget.dart';
import '../bloc/detail_persion/detail_person_bloc.dart';
import '../bloc/detail_persion/detail_person_event.dart';
import '../bloc/detail_persion/detail_person_state.dart';

class DetailPersonScreen extends StatefulWidget {
  final int personId;
  const DetailPersonScreen({super.key, required this.personId});

  @override
  State<DetailPersonScreen> createState() => _DetailPersonScreenState();
}

class _DetailPersonScreenState extends State<DetailPersonScreen> {
  int get personID => widget.personId;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DetailPersonBloc(
        sl<DetailPersonUsecase>(),
      )..add(GetDetailOfPersonEvent(personID)),
      child: Scaffold(
        body: BlocBuilder<DetailPersonBloc, DetailPersonState>(
          builder: (context, state) {
            if (state.status == Status.loading) {
              return SpinCustomWidget(sized: 50.r);
            } else if (state.status == Status.failure) {
              return ErrorLayoutWidget(
                tap: () {
                  context.read<DetailPersonBloc>().add(GetDetailOfPersonEvent(personID));
                },
                message: 'Oops ! Please try again later',
              );
            } else if (state.status == Status.success) {
              final credit = state.personDetail;
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    expandedHeight: AppConstant.defaultExpandedHeight.h,
                    leading: const ButtonBackWidget(),
                    pinned: true,
                    flexibleSpace: Stack(
                      fit: StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: '${AppConstant.imagePathUrlW500}${credit!.profilePath ?? ''}',
                          fit: BoxFit.cover,
                          imageBuilder: (context, imageProvider) => ClipRRect(
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: double.maxFinite,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.08),
                                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                          ),
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
                          errorWidget: (context, url, error) => const PlaceholderImage(),
                        ),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.0, 1.0),
                              end: Alignment(0.0, 0.0),
                              colors: <Color>[
                                Color(0x60000000),
                                Color(0x00000000),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text(
                                  '• ${credit.knownForDepartment ?? ''}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300,
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? TAppColor.whiteLightColor
                                        : TAppColor.darkFadeBlueColor,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                credit.gender == 1
                                    ? 'Female'.tr()
                                    : credit.gender == 2
                                        ? 'Male'.tr()
                                        : 'Not specified',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w300,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? TAppColor.whiteLightColor
                                      : TAppColor.darkFadeBlueColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          10.verticalSpace,
                          Text(
                            credit.name ?? 'NaN',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? TAppColor.whiteLightColor
                                  : TAppColor.darkFadeBlueColor,
                            ),
                          ),
                          16.verticalSpace,
                          ExpandableText(
                            text: credit.biography ?? '',
                          ),
                          16.verticalSpace,
                          Text(
                            'Quick fact'.tr(),
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? TAppColor.whiteLightColor
                                  : TAppColor.darkFadeBlueColor,
                            ),
                          ),
                          20.verticalSpace,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Birth City: '.tr(),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                              ),
                              5.horizontalSpace,
                              Expanded(
                                child: Text(
                                  credit.placeOfBirth ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp),
                                ),
                              ),
                            ],
                          ),
                          16.verticalSpace,
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Birthday: '.tr(),
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
                              ),
                              5.horizontalSpace,
                              Expanded(
                                child: Text(
                                  credit.birthday ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14.sp),
                                ),
                              ),
                            ],
                          ),
                          16.verticalSpace,
                          //Wrap and chip
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              for (var i = 0; i < credit.alsoKnownAs!.length; i++)
                                Chip(
                                  label: Text(
                                    credit.alsoKnownAs![i],
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Theme.of(context).brightness == Brightness.dark
                                          ? TAppColor.whiteLightColor
                                          : TAppColor.darkFadeBlueColor,
                                    ),
                                  ),
                                  backgroundColor: Theme.of(context).brightness == Brightness.dark
                                      ? TAppColor.darkFadeBlueColor
                                      : TAppColor.whiteLightColor,
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class ExpandableText extends StatefulWidget {
  final String text;

  const ExpandableText({super.key, required this.text});

  @override
  // ignore: library_private_types_in_public_api
  _ExpandableTextState createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;
  final int _maxLines = 5;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          child: ConstrainedBox(
            constraints: _isExpanded ? const BoxConstraints() : BoxConstraints(maxHeight: 16.sp * 7 + (3 * 7)),
            child: Text(
              widget.text,
              maxLines: _isExpanded ? null : _maxLines,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).brightness == Brightness.dark
                    ? TAppColor.whiteLightColor
                    : TAppColor.darkFadeBlueColor,
              ),
              softWrap: true,
              overflow: TextOverflow.fade,
            ),
          ),
        ),
        InkWell(
          child: Text(
            _isExpanded ? 'Show less ⤴' : 'More ⤵',
            style: TextStyle(
              color: TAppColor.primaryColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
        ),
      ],
    );
  }
}
