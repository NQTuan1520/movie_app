import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';
import 'package:tuannq_movie/manager/color.dart';
import 'package:tuannq_movie/presentation/home/bloc/people/people_bloc.dart';
import 'package:tuannq_movie/presentation/home/bloc/people/people_state.dart';
import 'package:tuannq_movie/presentation/home/widget/actor_item_widget.dart';

class PopularPeopleSectionWidget extends StatelessWidget {
  const PopularPeopleSectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'popular_celebrities'.tr(),
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).brightness == Brightness.dark
                  ? TAppColor.whiteLightColor
                  : TAppColor.darkFadeBlueColor,
            ),
          ),
          16.verticalSpace,
          SizedBox(
            height: 120.h,
            child: BlocBuilder<PeopleBloc, PeopleState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status || previous.peopleList != current.peopleList,
              builder: (context, peopleState) {
                return SizedBox(
                  height: 120.h,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: peopleState.peopleList.length,
                    itemBuilder: (context, index) {
                      final person = peopleState.peopleList[index];
                      return PeopleListItemWidget(
                        id: person.id ?? 0,
                        imagePathUrl: AppConstant.imagePathUrlOriginal,
                        profilePath: person.profilePath ?? '',
                        name: person.name ?? 'No name',
                      );
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
