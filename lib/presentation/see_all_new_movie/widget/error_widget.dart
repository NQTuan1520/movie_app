import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/manager/widget/layout_error_widget.dart';
import 'package:tuannq_movie/presentation/home/bloc/genres/genres_bloc.dart';
import 'package:tuannq_movie/presentation/home/bloc/genres/genres_event.dart';
import 'package:tuannq_movie/presentation/see_all_new_movie/bloc/new_movie/new_movie_bloc.dart';
import 'package:tuannq_movie/presentation/see_all_new_movie/bloc/new_movie/new_movie_event.dart';

class ErrorNewMovieWidget extends StatelessWidget {
  const ErrorNewMovieWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ErrorLayoutWidget(
        tap: () {
          context.read<NewMovieBloc>().add(const GetNewMoviesEvent(isRefresh: false));

          context.read<GenresBloc>().add(const GetGenres());
        },
        message: 'Error. Tap to reload');
  }
}
