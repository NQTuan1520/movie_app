import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/di/injection.dart';
import 'package:tuannq_movie/domain/genres/usecase/genres_usecase.dart';
import 'package:tuannq_movie/domain/movie/usecase/movie_usecase.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/home/bloc/genres/genres_bloc.dart';
import 'package:tuannq_movie/presentation/home/bloc/genres/genres_event.dart';
import 'package:tuannq_movie/presentation/see_all_top_rated/bloc/top_rated/top_rated_movie_bloc.dart';
import 'package:tuannq_movie/presentation/see_all_top_rated/bloc/top_rated/top_rated_movie_event.dart';
import 'package:tuannq_movie/presentation/see_all_top_rated/bloc/top_rated/top_rated_movie_state.dart';
import 'package:tuannq_movie/presentation/see_all_top_rated/widget/body_top_rated_widget.dart';
import 'package:tuannq_movie/presentation/see_all_top_rated/widget/error_layout_widget.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class SeeAllTopRatedScreen extends StatefulWidget {
  const SeeAllTopRatedScreen({super.key});

  @override
  State<SeeAllTopRatedScreen> createState() => _SeeAllTopRatedScreenState();
}

class _SeeAllTopRatedScreenState extends State<SeeAllTopRatedScreen> {
  final RefreshController _refreshController = RefreshController(initialRefresh: false);
  late String uid;

  @override
  void initState() {
    uid = FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TopRatedMovieBloc(
            sl<MovieUseCase>(),
          )..add(const GetTopRatedMovieEvent(isRefresh: false)),
        ),
        BlocProvider(
          create: (context) => GenresBloc(sl<GenresUseCase>())..add(const GetGenres()),
        ),
      ],
      child: BlocConsumer<TopRatedMovieBloc, TopRatedMovieState>(
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
            return const ErrorLayoutTopRatedWidget();
          }
          return Scaffold(
              appBar: AppBar(
                title: Text('top_rated_movie'.tr()),
              ),
              body: BodyTopRatedWidget(
                refreshController: _refreshController,
                state: state,
                uid: uid,
              ));
        },
      ),
    );
  }
}
