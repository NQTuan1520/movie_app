import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/manager/widget/layout_error_widget.dart';
import 'package:tuannq_movie/presentation/home/bloc/genres/genres_bloc.dart';
import 'package:tuannq_movie/presentation/home/bloc/genres/genres_event.dart';
import 'package:tuannq_movie/presentation/see_all_top_rated/bloc/top_rated/top_rated_movie_bloc.dart';
import 'package:tuannq_movie/presentation/see_all_top_rated/bloc/top_rated/top_rated_movie_event.dart';

class ErrorLayoutTopRatedWidget extends StatelessWidget {
  const ErrorLayoutTopRatedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrorLayoutWidget(
        tap: () {
          context.read<TopRatedMovieBloc>().add(const GetTopRatedMovieEvent(isRefresh: false));
          context.read<GenresBloc>().add(const GetGenres());
        },
        message: "Error. Tap to reload");
  }
}
