import 'dart:async';
// ignore: depend_on_referenced_packages

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';
import 'package:tuannq_movie/core/internet/bloc/internet/internet_bloc.dart';
import 'package:tuannq_movie/core/internet/bloc/internet/internet_event.dart';
import 'package:tuannq_movie/core/internet/bloc/internet/internet_state.dart';
import 'package:tuannq_movie/core/time_tracking/time_tracker.dart';
import 'package:tuannq_movie/data/local/movie/datasource/cached_db_helper.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/manager/utils/utils.dart';
import 'package:tuannq_movie/manager/widget/custom_spin_widget.dart';
import 'package:tuannq_movie/manager/widget/layout_error_widget.dart';
import 'package:tuannq_movie/presentation/fab_screen/bloc/favourite_bloc/favourite_bloc.dart';
import 'package:tuannq_movie/presentation/fab_screen/bloc/favourite_bloc/favourite_event.dart';
import 'package:tuannq_movie/presentation/home/bloc/movie/movie_bloc.dart';
import 'package:tuannq_movie/presentation/home/bloc/movie/movie_event.dart';
import 'package:tuannq_movie/presentation/home/bloc/movie/movie_state.dart';
import 'package:tuannq_movie/presentation/home/bloc/people/people_bloc.dart';
import 'package:tuannq_movie/presentation/home/bloc/people/people_event.dart';
import 'package:tuannq_movie/presentation/home/widget/section/app_bar_section_widget.dart';
import 'package:tuannq_movie/presentation/home/widget/section/new_movie_section_widget.dart';
import 'package:tuannq_movie/presentation/home/widget/section/popular_people_section_widget.dart';
import 'package:tuannq_movie/presentation/home/widget/section/top_rated_section_widget.dart';
import 'package:tuannq_movie/presentation/home/widget/section/trending_section_widget.dart';

// ignore: unused_import
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  bool isFavorite = false;
  final String _selectedTimeWindow = AppConstant.defaultTimeWindows;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  // final notifController = NotificationController();

  @override
  void initState() {
    super.initState();
    context.read<InternetBloc>().add(CheckInternet());

    user = _auth.currentUser!;
    _loadInitialData();
    TimeTracker().startTracking();
  }

  @override
  void dispose() {
    TimeTracker().stopTracking();

    super.dispose();
  }

  void _loadInitialData() {
    context.read<MovieBloc>().add(const GetMoviesUpcomingEvent());
    context.read<MovieBloc>().add(const GetMoviesPopularEvent());
    context.read<MovieBloc>().add(GetMoviesTrendingEvent(timeWindow: _selectedTimeWindow));
    context.read<PeopleBloc>().add(const GetPopularPeopleEvent());
    context.read<MovieBloc>().add(const GetMoviesTopRatedEvent());
    context.read<FavouriteBloc>().add(GetFavourites(user.uid));
  }

  Future<void> _refreshData() async {
    final databaseHelper = DatabaseHelper();
    await databaseHelper.deleteAllMovies();
    _loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<InternetBloc, InternetState>(
        listener: (context, state) {
          if (state is InternetConnectionFailure) {
            AppUtils.showSnackbarInternetSuccess(context);
          } else if (state is InternetConnectionSuccess) {
            AppUtils.showSnackbarInternetFailed(context);
          }
        },
        child: RefreshIndicator(
          onRefresh: _refreshData,
          child: BlocBuilder<MovieBloc, MovieState>(
            builder: (context, state) {
              if (state.status == Status.loading) {
                return SpinCustomWidget(sized: 50.r);
              } else if (state.status == Status.failure) {
                return ErrorLayoutWidget(
                  tap: () {
                    _refreshData();
                  },
                  message: 'Oops ! Somethings wrong. Please try again!',
                );
              } else if (state.status == Status.success) {
                final moviesToShow = state.popularMovies.take(5).toList();
                final moviesTopRated = state.topRatedMovies;
                final moviesUpcoming = state.upcomingMovies;
                return CustomScrollView(
                  slivers: <Widget>[
                    HomeAppBarWidget(
                      pageController: _pageController,
                      moviesToShow: moviesToShow,
                      user: user,
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          TrendingSectionWidget(
                            user: user,
                            state: state,
                          ),
                          NewMovieSectionWidget(
                            user: user,
                            moviesUpcoming: moviesUpcoming,
                          ),
                          const PopularPeopleSectionWidget(),
                          TopRatedSectionWidget(
                            user: user,
                            moviesTopRated: moviesTopRated,
                          ),
                        ],
                      ),
                    ),
                    // Additional content can be added here
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
