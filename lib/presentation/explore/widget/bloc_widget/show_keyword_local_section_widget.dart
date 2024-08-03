import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/manager/color.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/explore/bloc/local/bloc/keyword/keyword_local_bloc.dart';
import 'package:tuannq_movie/presentation/explore/bloc/local/bloc/keyword/keyword_local_event.dart';
import 'package:tuannq_movie/presentation/explore/bloc/local/bloc/keyword/keyword_local_state.dart';

class ShowKeywordLocalSectionWidget extends StatelessWidget {
  final TextEditingController controller;
  final GestureTapCallback onSearchChanged;
  const ShowKeywordLocalSectionWidget({super.key, required this.controller, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeywordLocalBloc, KeywordLocalState>(
      builder: (context, stateLocal) {
        if (stateLocal.status == Status.failure) {
          return Center(child: Text(stateLocal.message.toString()));
        } else if (stateLocal.status == Status.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (stateLocal.status == Status.success && stateLocal.listKeyword.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'last_search'.tr(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                  color: Theme.of(context).brightness == Brightness.dark
                      ? TAppColor.whiteLightColor
                      : TAppColor.darkFadeBlueColor,
                ),
              ),
              16.verticalSpace,
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 4.0,
                  children: stateLocal.listKeyword.map((keyword) {
                    return GestureDetector(
                      onTap: () {
                        controller.text = keyword.name ?? 'NaN';
                        onSearchChanged();
                      },
                      child: Chip(
                        label: Text(keyword.name ?? 'NaN',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? TAppColor.whiteLightColor
                                  : TAppColor.darkFadeBlueColor,
                            )),
                        deleteIcon: const Icon(Icons.clear),
                        onDeleted: () {
                          context.read<KeywordLocalBloc>().add(RemoveKeywordEvent(idKeyword: keyword.id!));
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
