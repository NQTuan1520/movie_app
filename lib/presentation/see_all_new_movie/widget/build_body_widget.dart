import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/presentation/see_all_new_movie/bloc/new_movie/new_movie_state.dart';

import 'package:tuannq_movie/presentation/see_all_new_movie/widget/genres_widget.dart';
import 'package:tuannq_movie/presentation/see_all_new_movie/widget/new_movie_section_widget.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class BuildBodyNewMovieWidget extends StatelessWidget {
  final NewMovieState state;
  final String uid;
  final RefreshController refreshController;
  const BuildBodyNewMovieWidget({super.key, required this.state, required this.uid, required this.refreshController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GenresWidget(
          state: state,
        ),
        16.verticalSpace,
        NewMovieSectionWidget(
          refreshController: refreshController,
          uid: uid,
          state: state,
        ),
      ],
    );
  }
}
