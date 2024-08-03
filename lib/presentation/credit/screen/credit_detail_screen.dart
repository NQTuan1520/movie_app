import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_constant.dart';
import '../../../di/injection.dart';
import '../../../domain/creadit/usecase/credit_usecase.dart';
import '../../../manager/color.dart';
import '../../../manager/enum/status_enum.dart';
import '../../../manager/widget/button_back_widget.dart';
import '../../../manager/widget/custom_spin_widget.dart';
import '../bloc/credit_detail_bloc/credit_detail_bloc.dart';
import '../bloc/credit_detail_bloc/credit_detail_event.dart';
import '../bloc/credit_detail_bloc/credit_detail_state.dart';
import '../widget/banner_sliver_appbar_credit_widget.dart';
import '../widget/bottom_detail_credit_widget.dart';
import '../widget/listview_film_credit_widget.dart';
import '../widget/quick_fact_widget.dart';
import '../widget/title_or_detail_widget.dart';

class CreditDetailScreen extends StatefulWidget {
  const CreditDetailScreen({super.key, required this.id});

  final String? id;

  @override
  State<CreditDetailScreen> createState() => _CreditDetailScreenState();
}

class _CreditDetailScreenState extends State<CreditDetailScreen> {
  //create getter for id
  String get id => widget.id ?? '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreditDetailBloc(sl<CreditUseCase>())..add(GetDetailCreditEvent(id: id)),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
                expandedHeight: AppConstant.defaultExpandedHeight.h,
                leading: const ButtonBackWidget(),
                pinned: true,
                flexibleSpace: const BannerSliverAppBarCreditWidget()),
            SliverToBoxAdapter(
              child: BlocBuilder<CreditDetailBloc, CreditDetailState>(
                builder: (context, state) {
                  if (state.status == Status.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.status == Status.failure) {
                    return SpinCustomWidget(
                      sized: 55.r,
                    );
                  } else if (state.status == Status.success) {
                    final credit = state.creditEntity;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BottomDetailCreditWidget(credit: credit),
                          16.verticalSpace,
                          TextDetailOrTitleWidget(
                            credit: credit,
                            sized: 20.sp,
                            text: credit.person!.originalName ?? 'NaN',
                          ),
                          10.verticalSpace,
                          TextDetailOrTitleWidget(
                            credit: credit,
                            sized: 14,
                            text: 'Department: ${credit.department}',
                          ),
                          16.verticalSpace,
                          TextDetailOrTitleWidget(
                            credit: credit,
                            sized: 20,
                            text: 'filmography'.tr(),
                          ),
                          16.verticalSpace,
                          ListViewFilmOfCreditWidget(
                            credit: credit,
                            state: state,
                          ),
                          16.verticalSpace,
                          TextDetailOrTitleWidget(
                            credit: credit,
                            sized: 20,
                            text: 'quick_fact'.tr(),
                          ),
                          16.verticalSpace,
                          QuickFactOfCreditWidget(credit: credit)
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            )
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
