import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/core/constant/app_constant.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/manager/widget/custom_spin_widget.dart';
import 'package:tuannq_movie/presentation/detail_movie/screen/details_movie_screen.dart';
import 'package:tuannq_movie/presentation/downloaded_video/screen/see_download_video.dart';
import 'package:tuannq_movie/presentation/fab_screen/bloc/favourite_bloc/favourite_bloc.dart';
import 'package:tuannq_movie/presentation/fab_screen/bloc/favourite_bloc/favourite_event.dart';
import 'package:tuannq_movie/presentation/fab_screen/bloc/favourite_bloc/favourite_state.dart';

class LayoutFavoriteWidget extends StatelessWidget {
  const LayoutFavoriteWidget({
    super.key,
    required this.uid,
  });

  final String uid;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<FavouriteBloc>(context),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SavedVideosScreen(),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.download),
                            8.horizontalSpace,
                            Text(
                              'download'.tr(),
                              style: TextStyle(fontSize: 12.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                26.verticalSpace,
                Expanded(
                  child: BlocConsumer<FavouriteBloc, FavouriteState>(
                    listener: (context, state) {
                      if (state.status == Status.failure) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed: ${state.message}'),
                            duration: const Duration(seconds: 1),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state.status == Status.loading && state.loadingItemId == null) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state.status == Status.failure) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Failed to fetch users: ${state.message}'),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<FavouriteBloc>().add(GetFavourites(uid));
                                },
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        );
                      } else if (state.status == Status.success || state.status == Status.deleteSuccess) {
                        if (state.favourites.isEmpty) {
                          return const Center(child: Text('No data'));
                        }
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12.w,
                            mainAxisSpacing: 12.h,
                            childAspectRatio: 0.7, // Adjust this ratio to fit your design
                          ),
                          itemCount: state.favourites.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            final user = state.favourites[index];
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MovieDetailScreen(
                                      uid: uid,
                                      idMovie: user.id ?? 0,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 200.h,
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
                                              '${AppConstant.imagePathUrlOriginal}${user.posterPath}',
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
                                          child: state.loadingItemId == user.id
                                              ? SpinCustomWidget(sized: 20.r) // Show spinner for the loading item
                                              : ClipRRect(
                                                  borderRadius: BorderRadius.circular(18.0),
                                                  child: IconButton(
                                                    padding: const EdgeInsets.all(6.0),
                                                    icon: Icon(
                                                      Icons.clear,
                                                      color: Colors.white,
                                                      size: 22.r,
                                                    ),
                                                    onPressed: () {
                                                      context.read<FavouriteBloc>().add(
                                                            RemoveFavourite(uid, user.id ?? 0),
                                                          );
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
                                              user.title ?? 'No title',
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
                              ),
                            );
                          },
                        );
                      } else {
                        return const Center(child: Text('No data'));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
