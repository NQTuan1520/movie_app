import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/di/injection.dart';
import 'package:tuannq_movie/domain/movie/usecase/movie_usecase.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/see_all_new_movie/bloc/new_movie/new_movie_bloc.dart';
import 'package:tuannq_movie/presentation/see_all_new_movie/bloc/new_movie/new_movie_event.dart';
import 'package:tuannq_movie/presentation/see_all_new_movie/bloc/new_movie/new_movie_state.dart';
import 'package:tuannq_movie/presentation/see_all_new_movie/widget/build_body_widget.dart';
import 'package:tuannq_movie/presentation/see_all_new_movie/widget/error_widget.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class SeeAllNewMovieScreen extends StatefulWidget {
  const SeeAllNewMovieScreen({super.key});

  @override
  State<SeeAllNewMovieScreen> createState() => _SeeAllNewMovieScreenState();
}

class _SeeAllNewMovieScreenState extends State<SeeAllNewMovieScreen> {
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
    return BlocProvider(
      create: (context) => NewMovieBloc(sl<MovieUseCase>())
        ..add(
          const GetNewMoviesEvent(isRefresh: false),
        ),
      child: BlocConsumer<NewMovieBloc, NewMovieState>(
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
            return const ErrorNewMovieWidget();
          }
          return Scaffold(
            appBar: AppBar(
              title: Text('all_new_movie'.tr()),
              centerTitle: false,
            ),
            body: BuildBodyNewMovieWidget(refreshController: _refreshController, uid: uid, state: state),
          );
        },
      ),
    );
  }
}
