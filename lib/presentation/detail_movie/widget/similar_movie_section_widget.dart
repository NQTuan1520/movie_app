import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/app_constant.dart';
import '../../../domain/favourite/entity/user_favourite_entity.dart';
import '../../../manager/enum/status_enum.dart';
import '../../../manager/widget/custom_spin_widget.dart';
import '../../fab_screen/bloc/favourite_bloc/favourite_bloc.dart';
import '../../fab_screen/bloc/favourite_bloc/favourite_event.dart';
import '../../fab_screen/bloc/favourite_bloc/favourite_state.dart';
import '../../home/widget/shimmer_movie_item_list_widget.dart';
import '../bloc/similar_movie/similar_movie_bloc.dart';
import '../bloc/similar_movie/similar_movie_state.dart';
import '../screen/details_movie_screen.dart';

class SimilarMovieSectionWidget extends StatelessWidget {
  const SimilarMovieSectionWidget(
      {super.key,
      required this.widget,
      required this.uid,
      required this.idMovie});

  final String uid;
  final MovieDetailScreen widget;
  final int idMovie;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220.h,
      child: BlocBuilder<SimilarMovieBloc, SimilarMovieState>(
        key: UniqueKey(),
        buildWhen: (previous, current) =>
            previous.status != current.status ||
            previous.listMovie != current.listMovie,
        builder: (context, state) {
          if (state.status == Status.loading) {
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) => const ShimmerMovieListItem(),
            );
          } else if (state.status == Status.failure) {
            return const SizedBox.shrink();
            // return Center(
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text('Error: ${state.message}'),
            //       ElevatedButton(
            //         onPressed: () {
            //           context
            //               .read<SimilarMovieBloc>()
            //               .add(GetSimilarMovieListEvent(id: idMovie));
            //         },
            //         child: const Text('Reload'),
            //       ),
            //     ],
            //   ),
            // );
          }

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: state.listMovie!.length,
            itemBuilder: (context, index) {
              final movieItem = state.listMovie![index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MovieDetailScreen(
                        idMovie: movieItem.id ?? 0,
                        uid: uid,
                      ),
                    ),
                  );
                },
                child: SimilarMovieItemWidget(
                  imagePathUrl: AppConstant.imagePathUrlOriginal,
                  posterPath: movieItem.posterPath ?? '',
                  title: movieItem.title ?? 'No title',
                  movieId: movieItem.id ?? 0,
                  uid: widget.uid,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SimilarMovieItemWidget extends StatefulWidget {
  final String imagePathUrl;
  final String posterPath;
  final String title;
  final int movieId;
  final String uid;

  const SimilarMovieItemWidget(
      {super.key,
      required this.imagePathUrl,
      required this.posterPath,
      required this.title,
      required this.movieId,
      required this.uid});

  @override
  State<SimilarMovieItemWidget> createState() => _SimilarMovieItemWidgetState();
}

class _SimilarMovieItemWidgetState extends State<SimilarMovieItemWidget> {
  bool isFavourite = false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteBloc, FavouriteState>(
      listenWhen: (previous, current) =>
          previous.status != current.status ||
          previous.favourites != current.favourites,
      listener: (context, state) {
        if (state.status == Status.loading) {
          Center(
            child: SpinCustomWidget(
              sized: 50.r,
            ),
          );
          // Xử lý khi đang tải
        }
      },
      builder: (context, state) {
        isFavourite =
            state.favourites.any((favourite) => favourite.id == widget.movieId);
        return Container(
          margin: EdgeInsets.only(right: 12.w),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Stack(
              children: [
                Container(
                  width: 150.w,
                  height: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.08),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        '${widget.imagePathUrl}${widget.posterPath}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 10.w,
                  top: 5.h,
                  child: Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18.0),
                      child: IconButton(
                        padding: const EdgeInsets.all(6.0),
                        icon: Icon(
                          Icons.favorite,
                          color: isFavourite ? Colors.red : Colors.white,
                          size: 22.r,
                        ),
                        onPressed: () {
                          if (isFavourite) {
                            context.read<FavouriteBloc>().add(
                                RemoveFavourite(widget.uid, widget.movieId));
                          } else {
                            final movie = UserFavouriteEntity(
                              id: widget.movieId,
                              title: widget.title,
                              posterPath: widget.posterPath,
                            );
                            context
                                .read<FavouriteBloc>()
                                .add(AddFavourite(widget.uid, movie));
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 150.w,
                    height: 35.h,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    child: Center(
                      child: Text(
                        widget.title.isNotEmpty ? widget.title : 'No title',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
