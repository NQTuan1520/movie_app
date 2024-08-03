import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';
import 'package:tuannq_movie/domain/favourite/entity/user_favourite_entity.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/manager/widget/custom_dialog_widget.dart';
import 'package:tuannq_movie/manager/widget/custom_spin_widget.dart';
import 'package:tuannq_movie/presentation/detail_movie/screen/details_movie_screen.dart';
import 'package:tuannq_movie/presentation/fab_screen/bloc/favourite_bloc/favourite_bloc.dart';
import 'package:tuannq_movie/presentation/fab_screen/bloc/favourite_bloc/favourite_event.dart';
import 'package:tuannq_movie/presentation/fab_screen/bloc/favourite_bloc/favourite_state.dart';
import 'package:tuannq_movie/presentation/home/bloc/movie/movie_state.dart';

// ignore: must_be_immutable
class TrendingMoviesWidget extends StatefulWidget {
  final String uid;
  final User user;
  MovieState state;

  TrendingMoviesWidget({required this.uid, required this.user, super.key, required this.state});

  @override
  State<TrendingMoviesWidget> createState() => _TrendingMoviesWidgetState();
}

class _TrendingMoviesWidgetState extends State<TrendingMoviesWidget> {
  //create getter for state
  MovieState get state => widget.state;
  String get uid => widget.uid;
  User get user => widget.user;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 220.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.trendingMovies.length,
          itemBuilder: (context, index) {
            final movieItem = state.trendingMovies[index];
            return GestureDetector(
              onTap: () {
                if (user.isAnonymous) {
                  showDialog(
                      context: context,
                      builder: ((context) =>
                          CustomDialogWidget(titleWarning: 'this_features'.tr(), submitCallback: () {})));
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MovieDetailScreen(idMovie: movieItem.id ?? 0, uid: widget.uid),
                  ),
                );
              },
              child: MovieItemWidget(
                imagePathUrl: AppConstant.imagePathUrlOriginal,
                posterPath: movieItem.posterPath ?? '',
                title: movieItem.title ?? 'No title !',
                movieId: movieItem.id ?? 0,
                uid: uid,
                user: user,
              ),
            );
          },
        ));
  }
}

class MovieItemWidget extends StatefulWidget {
  final String imagePathUrl;
  final String posterPath;
  final String title;
  final int movieId;
  final String uid;
  final User user;

  const MovieItemWidget({
    super.key,
    required this.imagePathUrl,
    required this.posterPath,
    required this.title,
    required this.movieId,
    required this.uid,
    required this.user,
  });

  @override
  State<MovieItemWidget> createState() => _MovieItemWidgetState();
}

class _MovieItemWidgetState extends State<MovieItemWidget> {
  bool isFavourite = false;
  //create getter for variables
  String get imagePathUrl => widget.imagePathUrl;
  String get posterPath => widget.posterPath;
  String get title => widget.title;
  int get movieId => widget.movieId;
  String get uid => widget.uid;
  User get user => widget.user;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavouriteBloc, FavouriteState>(
      listenWhen: (previous, current) => previous.status != current.status || previous.favourites != current.favourites,
      listener: (context, state) {
        if (state.status == Status.loading) {
          SpinCustomWidget(
            sized: 50.r,
          );
        }
      },
      builder: (context, state) {
        isFavourite = state.favourites.any((favourite) => favourite.id == movieId);
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
                        '$imagePathUrl$posterPath',
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
                          if (user.isAnonymous) {
                            showDialog(
                                context: context,
                                builder: ((context) => CustomDialogWidget(
                                    titleWarning:
                                        'This feature is available for registered users only. Please sign in to continue.',
                                    submitCallback: () {})));
                            return;
                          }
                          if (isFavourite) {
                            context.read<FavouriteBloc>().add(RemoveFavourite(uid, movieId));
                          } else {
                            final movie = UserFavouriteEntity(
                              id: movieId,
                              title: title,
                              posterPath: posterPath,
                            );
                            context.read<FavouriteBloc>().add(AddFavourite(uid, movie));
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
                        title.isNotEmpty ? title : 'No title',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.white,
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

// SizedBox(
//   height: 220.h,
//   child: BlocBuilder<MovieBloc, MovieState>(
//     buildWhen: (previous, current) =>
//         previous.status != current.status ||
//         previous.trendingMovies != current.trendingMovies ||
//         previous.timeWindow != current.timeWindow,
//     builder: (context, state) {
//       if (state.status == Status.loading) {
//         return ListView.builder(
//           scrollDirection: Axis.horizontal,
//           itemCount: 5,
//           itemBuilder: (context, index) => ShimmerMovieListItem(),
//         );
//       } else if (state.status == Status.failure) {
//         return Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text('Error: ${state.errMessage}'),
//               ElevatedButton(
//                 onPressed: _reloadTrendingMovies,
//                 child: const Text('Reload'),
//               ),
//             ],
//           ),
//         );
//       }
//
//       return ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: state.trendingMovies.length,
//         itemBuilder: (context, index) {
//           final movieItem = state.trendingMovies[index];
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => MovieDetailScreen(entity: movieItem),
//                 ),
//               );
//             },
//             child: BlocBuilder<FavouriteBloc, FavouriteState>(
//               buildWhen: (previous, current) =>
//                   previous.favouriteIds != current.favouriteIds,
//               builder: (context, state) {
//                 final isFav =
//                     state.favouriteIds.contains(movieItem.id.toString());
//
//                 if (state.status == Status.loading) {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 } else if (state.status == Status.success) {
//                   return MovieItemWidget(
//                     imagePathUrl: AppConstant.imagePathUrlOriginal,
//                     posterPath: movieItem.posterPath ?? '',
//                     title: movieItem.title ?? 'No title',
//                     isFavorite: isFav,
//                     onTap: () {
//                       final idFavorite = state.userFavouriteEntities
//                           .firstWhere(
//                             (element) => element.movieId == movieItem.id,
//                             orElse: () => null,
//                           )
//                           ?.id;
//                       if (isFav) {
//                         context.read<FavouriteBloc>().add(
//                               RemoveFavouriteEvent(idFavorite.toString()),
//                             );
//                         context
//                             .read<FavouriteBloc>()
//                             .add(GetFavouriteEvent(uid));
//                       } else {
//                         final userFavouriteEntity = UserFavouriteEntity(
//                           movieId: movieItem.id ?? 0,
//                           userUid: uid,
//                         );
//                         context.read<FavouriteBloc>().add(
//                               AddFavouriteEvent(userFavouriteEntity),
//                             );
//                         context.read<FavouriteBloc>().add(
//                               GetFavouriteEvent(uid),
//                             );
//                       }
//                     },
//                     movieId: movieItem.id ?? 0,
//                   );
//                 }
//                 return Container();
//               },
//             ),
//           );
//         },
//       );
//     },
//   ),
// ),
