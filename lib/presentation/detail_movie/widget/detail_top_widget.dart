import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../domain/favourite/entity/user_favourite_entity.dart';
import '../../../domain/shared/entity/shared_entity.dart';
import '../../../manager/color.dart';
import '../../../manager/enum/status_enum.dart';
import '../../../manager/utils/utils.dart';
import '../../../manager/widget/custom_spin_widget.dart';
import '../../../manager/widget/expand_text_detail_widget.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_state.dart';
import '../../fab_screen/bloc/favourite_bloc/favourite_bloc.dart';
import '../../fab_screen/bloc/favourite_bloc/favourite_event.dart';
import '../../fab_screen/bloc/favourite_bloc/favourite_state.dart';
import '../../feed/bloc/shared_bloc/shared_bloc.dart';
import '../../feed/bloc/shared_bloc/shared_event.dart';
import '../../feed/bloc/shared_bloc/shared_state.dart';
import '../../home/widget/shimmer_popular_item.dart';
import '../bloc/detail_movie/detail_of_movie_bloc.dart';
import '../bloc/detail_movie/detail_of_movie_state.dart';

class DetailTopWidget extends StatefulWidget {
  final String uid;
  final User user;
  final int idMovie;
  const DetailTopWidget({
    super.key,
    required this.uid,
    required this.user,
    required this.idMovie,
  });

  @override
  State<DetailTopWidget> createState() => _DetailTopWidgetState();
}

class _DetailTopWidgetState extends State<DetailTopWidget> {
  int get idMovie => widget.idMovie;
  String get uid => widget.uid;
  User get user => widget.user;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  String generateRandomText(int length) {
    const String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  void _showBottomDialogShared(
    BuildContext context,
    GestureTapCallback onTap,
    String title,
    String posterPath,
  ) {
    final controller = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
      ),
      backgroundColor:
          Theme.of(context).brightness == Brightness.dark ? TAppColor.darkBlueColor : TAppColor.whiteLightColor,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.5.h,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_downward, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16.0.r),
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark
                        ? TAppColor.darkFadeBlueColor.withOpacity(0.01)
                        : Colors.grey[200],
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthAuthenticated) {
                        final userInfor = state.user;
                        return Form(
                          key: formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    height: 45.h,
                                    width: 45.w,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20.r),
                                      child: CachedNetworkImage(imageUrl: userInfor.image),
                                    ),
                                  ),
                                  10.horizontalSpace,
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        user.email ?? 'No name',
                                        style: TextStyle(
                                          color: Theme.of(context).brightness == Brightness.dark
                                              ? TAppColor.whiteLightColor
                                              : TAppColor.darkFadeBlueColor,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        'Share everything you want!',
                                        style: TextStyle(
                                          color: Theme.of(context).brightness == Brightness.dark
                                              ? TAppColor.greyColor
                                              : TAppColor.greyColor,
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              20.verticalSpace,
                              TextFormField(
                                controller: controller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a description about your post';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  hintText: 'Write something...',
                                  hintStyle: TextStyle(
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? TAppColor.greyColor
                                        : TAppColor.greyColor,
                                  ),
                                  border: InputBorder.none,
                                ),
                                maxLines: 5,
                              ),
                              10.verticalSpace,
                              ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState?.validate() == true) {
                                    final String id = generateRandomText(5);

                                    final entity = SharedEntity(
                                      id: id,
                                      uid: uid,
                                      title: title,
                                      titleShared: controller.text,
                                      posterPath: posterPath,
                                      idMovie: idMovie,
                                      email: widget.user.email,
                                      avatar: widget.user.photoURL,
                                      like: 0,
                                      username: userInfor.username,
                                      isLike: false,
                                    );

                                    context.read<SharedBloc>().add(PostSharedEvent(sharedEntity: entity));

                                    Navigator.pop(context);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(vertical: 15.0.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28.r),
                                  ),
                                ),
                                child: const Text('Share'),
                              ),
                            ],
                          ),
                        );
                      }
                      return Container();
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailOfMovieBloc, DetailOfMovieState>(
      buildWhen: (previous, current) =>
          previous.movieDetail.id != current.movieDetail.id || previous.status != current.status,
      builder: (context, state) {
        final movieItem = state.movieDetail;
        if (state.status == Status.loading) {
          return const ShimmerMovieItem();
        } else if (state.status == Status.failure) {
          return const SizedBox.shrink();
          // return Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text('Error: ${state.errorMessage}'),
          //       ElevatedButton(
          //         onPressed: () {},
          //         child: const Text('Reload'),
          //       ),
          //     ],
          //   ),
          // );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    movieItem.genres != null ? movieItem.genres!.map((genre) => genre.name).join(' • ') : 'No genres',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w300,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? TAppColor.whiteLightColor
                          : TAppColor.darkFadeBlueColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            16.verticalSpace,
            Text(
              movieItem.title ?? 'No overview',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).brightness == Brightness.dark
                    ? TAppColor.whiteLightColor
                    : TAppColor.darkFadeBlueColor,
              ),
            ),
            10.verticalSpace,
            ExpandableText(text: movieItem.overview ?? 'No overview'),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(right: 10.w),
                    height: 1.h,
                    width: double.infinity,
                    color: TAppColor.greyColor,
                  ),
                ),
                Row(
                  children: [
                    BlocConsumer<FavouriteBloc, FavouriteState>(
                      listener: (context, state) {
                        if (state.status == Status.loading) {
                          // Show loading indicator if needed
                          SpinCustomWidget(
                            sized: 50.r,
                          );
                        } else if (state.status == Status.success) {
                          AppUtils.showCustomToastSuccess(
                            'Successfully added to favourites!',
                            context,
                          );
                        } else if (state.status == Status.deleteSuccess) {
                          AppUtils.showCustomToastSuccess(
                            'Successfully removed favourites!',
                            context,
                          );
                        } else if (state.status == Status.failure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to add to favourites!'),
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        final isFavourite = state.favourites.any((favourite) => favourite.id == idMovie);
                        return Container(
                          width: 40.w,
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Theme.of(context).brightness == Brightness.dark
                                ? TAppColor.darkFadeBlueColor
                                : TAppColor.whiteGreyColor,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? TAppColor.darkFadeBlueColor
                                  : TAppColor.whiteGreyColor,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.favorite,
                                color: isFavourite ? Colors.red : Colors.black,
                              ),
                              onPressed: () {
                                if (isFavourite) {
                                  context.read<FavouriteBloc>().add(
                                        RemoveFavourite(uid, idMovie),
                                      );
                                } else {
                                  final movie = UserFavouriteEntity(
                                    id: idMovie,
                                    title: movieItem.title,
                                    posterPath: movieItem.posterPath,
                                  );
                                  context.read<FavouriteBloc>().add(AddFavourite(uid, movie));
                                }
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    10.horizontalSpace,
                    BlocConsumer<SharedBloc, SharedState>(
                      listener: (context, state) {
                        if (state.status == Status.loading) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Loading...'),
                            ),
                          );
                        } else if (state.status == Status.success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Shared successfully!'),
                            ),
                          );
                        } else if (state.status == Status.failure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Shared failed!'),
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            _showBottomDialogShared(
                                context, () {}, movieItem.title ?? 'Title', movieItem.posterPath ?? '');
                          },
                          child: Container(
                            height: 40.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? TAppColor.darkFadeBlueColor
                                  : TAppColor.whiteGreyColor,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.share_outlined,
                                color: TAppColor.primaryColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                )
              ],
            )
          ],
        );
      },
    );
  }
}
