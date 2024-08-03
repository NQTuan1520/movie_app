import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/manager/widget/layout_error_widget.dart';
import 'package:tuannq_movie/presentation/home/bloc/genres/genres_bloc.dart';
import 'package:tuannq_movie/presentation/home/bloc/genres/genres_event.dart';
import 'package:tuannq_movie/presentation/see_all_trending/bloc/trending_movie/trending_movie_bloc.dart';
import 'package:tuannq_movie/presentation/see_all_trending/bloc/trending_movie/trending_movie_event.dart';

class BuildErrorLayoutWidget extends StatelessWidget {
  const BuildErrorLayoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ErrorLayoutWidget(
        tap: () {
          context.read<TrendingMovieBloc>().add(const GetTrendingMoviesEvent(isRefresh: false));
          context.read<GenresBloc>().add(const GetGenres());
        },
        message: 'Oops! Something went wrong. Please try again!',
      ),
    );
  }
}
