import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/presentation/home/bloc/genres/genres_bloc.dart';
import 'package:tuannq_movie/presentation/home/bloc/genres/genres_state.dart';
import 'package:tuannq_movie/presentation/see_all_new_movie/bloc/new_movie/new_movie_bloc.dart';
import 'package:tuannq_movie/presentation/see_all_new_movie/bloc/new_movie/new_movie_event.dart';
import 'package:tuannq_movie/presentation/see_all_new_movie/bloc/new_movie/new_movie_state.dart';

class GenresWidget extends StatefulWidget {
  final NewMovieState state;
  const GenresWidget({
    super.key,
    required this.state,
  });

  @override
  State<GenresWidget> createState() => _GenresWidgetState();
}

class _GenresWidgetState extends State<GenresWidget> {
  int? _selectedGenreId;

  @override
  void initState() {
    super.initState();
    _selectedGenreId = widget.state.selectedGenreId;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GenresBloc, GenresState>(
      builder: (context, genresState) {
        if (genresState.status == Status.loading) {
          return const CircularProgressIndicator();
        } else if (genresState.status == Status.success) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0.h),
              child: Row(
                children: [
                  ...genresState.genres!.map((genre) {
                    return Container(
                      margin: EdgeInsets.only(right: 8.0.w),
                      child: ChoiceChip(
                        label: Text(genre.name ?? ''),
                        selected: _selectedGenreId == genre.id,
                        onSelected: (selected) {
                          setState(() {
                            if (_selectedGenreId == genre.id) {
                              _selectedGenreId = null;

                              context.read<NewMovieBloc>().add(
                                    const GetNewMoviesEvent(
                                      isRefresh: true,
                                      isSelectedAll: true,
                                    ),
                                  );
                            } else {
                              _selectedGenreId = genre.id;
                              context.read<NewMovieBloc>().add(
                                    FilterNewMoviesEvent(
                                      genre.id ?? 0,
                                    ),
                                  );
                            }
                          });
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),
          );
        } else {
          return const Center(child: Text('Failed to load genres'));
        }
      },
    );
  }
}
