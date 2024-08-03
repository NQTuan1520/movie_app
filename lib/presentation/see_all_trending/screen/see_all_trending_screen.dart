import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/di/injection.dart';
import 'package:tuannq_movie/domain/genres/usecase/genres_usecase.dart';
import 'package:tuannq_movie/domain/movie/usecase/movie_usecase.dart';
import 'package:tuannq_movie/presentation/home/bloc/genres/genres_event.dart';
import 'package:tuannq_movie/presentation/see_all_trending/bloc/trending_movie/trending_movie_bloc.dart';
import 'package:tuannq_movie/presentation/see_all_trending/bloc/trending_movie/trending_movie_event.dart';
import 'package:tuannq_movie/presentation/see_all_trending/bloc/trending_movie/trending_movie_state.dart';

import 'package:tuannq_movie/presentation/see_all_trending/widget/build_body_widget.dart';
import 'package:tuannq_movie/presentation/see_all_trending/widget/dropdown_time_sectio_widget.dart';
import 'package:tuannq_movie/presentation/see_all_trending/widget/error_layout_widget.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/home/bloc/genres/genres_bloc.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class SeeAllTrendingScreen extends StatefulWidget {
  const SeeAllTrendingScreen({super.key});

  @override
  State<SeeAllTrendingScreen> createState() => _SeeAllTrendingScreenState();
}

class _SeeAllTrendingScreenState extends State<SeeAllTrendingScreen> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  late String uid;

  @override
  void initState() {
    uid = FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              TrendingMovieBloc(sl<MovieUseCase>())..add(const GetTrendingMoviesEvent(isRefresh: false)),
        ),
        BlocProvider(
          create: (context) => GenresBloc(sl<GenresUseCase>())..add(const GetGenres()),
        ),
      ],
      child: Scaffold(
        body: BlocConsumer<TrendingMovieBloc, TrendingMovieState>(
          listener: (context, state) {
            if (!state.isRefresh!) {
              _refreshController.refreshCompleted();
            }
            if (!state.isLoadMore!) {
              _refreshController.loadComplete();
            }
          },
          builder: (context, state) {
            if (state.status == Status.failure) {
              return const BuildErrorLayoutWidget();
            }
            return Scaffold(
              appBar: AppBar(
                title: Text('all_trending'.tr()),
                centerTitle: false,
                actions: [
                  DropDownTimeSectionWidget(state: state),
                ],
              ),
              body: BuildBodyWidget(
                state: state,
                uid: uid,
                refreshController: _refreshController,
              ),
            );
          },
        ),
      ),
    );
  }
}
