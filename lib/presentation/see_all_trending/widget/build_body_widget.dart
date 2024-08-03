import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/presentation/home/bloc/genres/genres_bloc.dart';
import 'package:tuannq_movie/presentation/see_all_trending/bloc/trending_movie/trending_movie_state.dart';
import 'package:tuannq_movie/presentation/see_all_trending/widget/genres_section_widget.dart';
import 'package:tuannq_movie/presentation/see_all_trending/widget/movie_trending_section_widget.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class BuildBodyWidget extends StatelessWidget {
  final TrendingMovieState state;
  final String uid;
  final RefreshController refreshController;
  const BuildBodyWidget({super.key, required this.state, required this.uid, required this.refreshController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GenresSectionWidget(
          state: state,
          genresBloc: context.read<GenresBloc>(),
          selectedTimeWindow: state.timeWindow!,
        ),
        16.verticalSpace,
        MovieTrendingSectionWidget(
          refreshController: refreshController,
          uid: uid,
          state: state,
        ),
      ],
    );
  }
}
