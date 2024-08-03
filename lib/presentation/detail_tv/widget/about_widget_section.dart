import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_constant.dart';
import '../../../domain/tv_show_detail/enitty/tv_detail_entity.dart';
import '../../../manager/color.dart';
import '../../../manager/enum/status_enum.dart';
import '../../credit/screen/credit_detail_screen.dart';
import '../bloc/cast_tv/cast_tv_bloc.dart';
import '../bloc/cast_tv/cast_tv_event.dart';
import '../bloc/cast_tv/cast_tv_state.dart';

class AboutSectionWidget extends StatefulWidget {
  final TVDetailEntity tvDetailEntity;
  const AboutSectionWidget({super.key, required this.tvDetailEntity});

  @override
  State<AboutSectionWidget> createState() => _AboutSectionWidgetState();
}

class _AboutSectionWidgetState extends State<AboutSectionWidget> {
  TVDetailEntity get tvDetailEntity => widget.tvDetailEntity;

  @override
  void initState() {
    super.initState();
    context.read<CastTvBloc>().add(GetCastTVDetailEvent(tvDetailEntity.id!));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'storyline'.tr(),
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
            12.verticalSpace,
            ExpandableText(
              text: widget.tvDetailEntity.overview ?? 'NaN',
            ),
            12.verticalSpace,
            Text(
              'network'.tr(),
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
            12.verticalSpace,
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: widget.tvDetailEntity.networks!
                  .map(
                    (network) => Chip(
                      label: Text(network.name!),
                    ),
                  )
                  .toList(),
            ),
            12.verticalSpace,
            Text(
              'Languages'.tr(),
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
            12.verticalSpace,
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: widget.tvDetailEntity.languages!
                  .map(
                    (language) => Chip(
                      label: Text(language),
                    ),
                  )
                  .toList(),
            ),
            12.verticalSpace,
            Text(
              'Cast'.tr(),
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
            12.verticalSpace,
            SizedBox(
              height: 68.h,
              width: double.infinity,
              child: BlocBuilder<CastTvBloc, CastTvState>(
                builder: (context, state) {
                  if (state.status == Status.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.status == Status.success) {
                    final cast = state.cast ?? [];
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final castItem = cast[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreditDetailScreen(
                                  id: castItem.creditId.toString(),
                                ),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(right: 16.w),
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey[800]
                                  : TAppColor.primaryColor.withOpacity(0.050),
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.0.r),
                              child: Row(
                                children: [
                                  ClipOval(
                                    child: castItem.profilePath != null && castItem.profilePath!.isNotEmpty
                                        ? Image.network(
                                            '${AppConstant.imagePathUrlW500}${castItem.profilePath}',
                                            width: 60.w,
                                            height: 60.h,
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return const Icon(
                                                Icons.person,
                                                size: 60,
                                              );
                                            },
                                          )
                                        : const Icon(
                                            Icons.person,
                                            size: 60,
                                          ),
                                  ),
                                  16.horizontalSpace,
                                  Text(
                                    castItem.name!,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).brightness == Brightness.dark
                                          ? TAppColor.whiteLightColor
                                          : TAppColor.darkFadeBlueColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      itemCount: cast.length,
                    );
                  } else if (state.status == Status.failure) {
                    return Center(
                      child: Text(state.message!),
                    );
                  }
                  return Container();
                },
              ),
            ),
            12.verticalSpace,
            Text(
              'country_of_origin'.tr(),
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
            ),
            12.verticalSpace,
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: widget.tvDetailEntity.originCountry!
                  .map(
                    (country) => Chip(
                      label: Text(country),
                    ),
                  )
                  .toList(),
            ),
          ],
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
            constraints: _isExpanded ? const BoxConstraints() : BoxConstraints(maxHeight: 16.sp * 5 + (3 * 5)),
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
