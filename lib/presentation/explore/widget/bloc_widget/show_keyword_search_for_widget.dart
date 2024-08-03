import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/manager/color.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/keywordBloc/keyword_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/remote/keywordBloc/keyword_state.dart';

class ShowKeywordSearchForWidget extends StatelessWidget {
  final TextEditingController searchController;
  const ShowKeywordSearchForWidget({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeywordBloc, KeywordState>(
      builder: (context, state) {
        return searchController.text.isNotEmpty && state.status != Status.loading
            ? Text(
                '${'search_for'.tr()} "${searchController.text}"',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? TAppColor.whiteLightColor
                      : TAppColor.darkFadeBlueColor,
                ),
              )
            : const SizedBox.shrink();
      },
    );
  }
}
