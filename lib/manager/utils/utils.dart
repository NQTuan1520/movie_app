import 'dart:async';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../di/injection.dart';
import '../../domain/comment/entity/comment_entity.dart';
import '../../domain/comment/usecase/comment_use_case.dart';
import '../../domain/review/usecase/review_usecase.dart';
import '../../domain/shared/entity/shared_entity.dart';
import '../../presentation/auth/bloc/auth_bloc.dart';
import '../../presentation/auth/bloc/auth_state.dart';
import '../../presentation/commment/bloc/comeent/comment_bloc.dart';
import '../../presentation/commment/bloc/comeent/comment_event.dart';
import '../../presentation/commment/bloc/comeent/comment_state.dart';
import '../../presentation/detail_movie/bloc/review/review_bloc.dart';
import '../../presentation/detail_movie/bloc/review/review_event.dart';
import '../../presentation/detail_movie/bloc/review/review_state.dart';
import '../../presentation/explore/bloc/remote/searchMovieBloc/search_movie_bloc.dart';
import '../../presentation/explore/bloc/remote/searchMovieBloc/search_movie_event.dart';
import '../../presentation/feed/widget/bottom_form_dialog_widget.dart';
import '../../presentation/feed/widget/close_button_bottom_dialog_widget.dart';
import '../color.dart';
import '../enum/region_enum.dart';
import '../enum/status_enum.dart';
import '../enum/year_enum.dart';
import '../widget/custom_spin_widget.dart';
import '../widget/custom_toast.dart';

class AppUtils {
  AppUtils._();

  static void showCustomToastError(String message, BuildContext context) {
    showCustomToast(
      message: message,
      context: context,
      gradientColors: [
        const Color(0xFFFF4444),
        const Color(0xFFCC0000),
      ], // Red to Light Red gradient
    );
  }

  static void showCustomToastSuccess(String message, BuildContext context) {
    showCustomToast(
      message: message,
      context: context,
      gradientColors: [
        const Color(0xFF00C851), // Green color
        const Color(0xFF007E33),
      ], // Green to Light Green gradient
    );
  }

  static void showCustomToast({
    required String message,
    required BuildContext context,
    required List<Color> gradientColors,
  }) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).size.height * 0.1,
        left: 20.w,
        right: 20.w,
        child: Material(
          color: Colors.transparent,
          child: CustomToast(
            message: message,
            gradientColors: gradientColors,
            context: context,
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 4), () {
      overlayEntry.remove();
    });
  }

  static void showFilterDialog(BuildContext context, String keywordSearched) {
    final searchMovieBloc = BlocProvider.of<SearchMovieBloc>(context);
    final isAdultTemp = ValueNotifier<bool>(searchMovieBloc.state.isAdult);
    final primaryReleaseYearTemp =
        ValueNotifier<Year>(Year.values.firstWhere((year) => year.year == searchMovieBloc.state.primaryReleaseYear));
    final regionTemp =
        ValueNotifier<Region>(Region.values.firstWhere((region) => region.name == searchMovieBloc.state.region));

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
      ),
      backgroundColor:
          Theme.of(context).brightness == Brightness.dark ? TAppColor.darkFadeBlueColor : TAppColor.whiteLightColor,
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.5.h,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
            child: Column(
              children: <Widget>[
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                20.verticalSpace,
                Center(
                  child: Text(
                    'Sort & Filter',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? TAppColor.whiteLightColor
                          : TAppColor.darkFadeBlueColor,
                    ),
                  ),
                ),
                20.verticalSpace,
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Region',
                            style: TextStyle(
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? TAppColor.whiteLightColor
                                    : TAppColor.darkFadeBlueColor,
                                fontSize: 16)),
                        10.verticalSpace,
                        ValueListenableBuilder(
                          valueListenable: regionTemp,
                          builder: (context, Region region, _) {
                            return Wrap(
                              spacing: 8.0,
                              runSpacing: 4.0,
                              children: Region.values.map((Region value) {
                                return ChoiceChip(
                                  label: Text(value.name,
                                      style: TextStyle(
                                        color: Theme.of(context).brightness == Brightness.dark
                                            ? TAppColor.whiteLightColor
                                            : TAppColor.darkFadeBlueColor,
                                      )),
                                  selected: region == value,
                                  onSelected: (bool selected) {
                                    if (selected) {
                                      regionTemp.value = value;
                                    }
                                  },
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  selectedColor: TAppColor.primaryColor,
                                  backgroundColor: Theme.of(context).brightness == Brightness.dark
                                      ? TAppColor.darkFadeBlueColor
                                      : TAppColor.whiteGreyColor,
                                );
                              }).toList(),
                            );
                          },
                        ),
                        20.verticalSpace,
                        Text('Release Year',
                            style: TextStyle(
                                color: Theme.of(context).brightness == Brightness.dark
                                    ? TAppColor.whiteLightColor
                                    : TAppColor.darkFadeBlueColor,
                                fontSize: 16)),
                        10.verticalSpace,
                        ValueListenableBuilder(
                          valueListenable: primaryReleaseYearTemp,
                          builder: (context, Year primaryReleaseYear, _) {
                            return Wrap(
                              spacing: 8.0,
                              runSpacing: 4.0,
                              children: Year.values.map((Year value) {
                                return ChoiceChip(
                                  label: Text(value.year,
                                      style: TextStyle(
                                          color: Theme.of(context).brightness == Brightness.dark
                                              ? TAppColor.whiteLightColor
                                              : TAppColor.darkFadeBlueColor,
                                          fontWeight: FontWeight.w500)),
                                  selected: primaryReleaseYear == value,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  onSelected: (bool selected) {
                                    if (selected) {
                                      primaryReleaseYearTemp.value = value;
                                    }
                                  },
                                  selectedColor: TAppColor.primaryColor,
                                  backgroundColor: Theme.of(context).brightness == Brightness.dark
                                      ? TAppColor.darkFadeBlueColor
                                      : TAppColor.whiteGreyColor,
                                );
                              }).toList(),
                            );
                          },
                        ),
                        20.verticalSpace,
                        ValueListenableBuilder(
                          valueListenable: isAdultTemp,
                          builder: (context, bool isAdult, _) {
                            return SwitchListTile(
                              title: Text('Include Adult',
                                  style: TextStyle(
                                    color: Theme.of(context).brightness == Brightness.dark
                                        ? TAppColor.whiteLightColor
                                        : TAppColor.darkFadeBlueColor,
                                  )),
                              value: isAdult,
                              onChanged: (bool value) {
                                isAdultTemp.value = value;
                              },
                              activeColor: TAppColor.primaryColor,
                              inactiveThumbColor: Colors.grey,
                              inactiveTrackColor: Colors.grey[600],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 10.w),
                            side: BorderSide(color: TAppColor.primaryColor, width: 1.w)),
                        onPressed: () {
                          final searchBloc = BlocProvider.of<SearchMovieBloc>(context);
                          searchBloc.add(
                            GetMovieBySearchEvent(
                              query: keywordSearched,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: Text('Reset',
                            style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? TAppColor.primaryColor
                                  : TAppColor.primaryColor,
                            )),
                      ),
                    ),
                    20.horizontalSpace,
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TAppColor.primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 10.w),
                        ),
                        onPressed: () {
                          final searchBloc = BlocProvider.of<SearchMovieBloc>(context);
                          searchBloc.add(
                            FilteredGetMovieBySearchEvent(
                              query: keywordSearched,
                              isAdult: isAdultTemp.value,
                              primaryReleaseYear: primaryReleaseYearTemp.value.year,
                              region: regionTemp.value.name,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        child: Text('Apply',
                            style: TextStyle(
                              color: Theme.of(context).brightness == Brightness.dark
                                  ? TAppColor.whiteLightColor
                                  : TAppColor.whiteLightColor,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showBottomDialogToShowAllReview({required BuildContext context, required int id}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.r)),
      ),
      backgroundColor:
          Theme.of(context).brightness == Brightness.dark ? TAppColor.darkFadeBlueColor : TAppColor.whiteLightColor,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.75, // Increased height for more content
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            child: BlocProvider(
              create: (context) => ReviewBloc(sl<ReviewUseCase>())
                ..add(
                  GetReviewEvent(id),
                ),
              child: BlocBuilder<ReviewBloc, ReviewState>(
                builder: (context, state) {
                  if (state.status == Status.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.status == Status.success) {
                    if (state.reviews.isEmpty) {
                      return const Center(
                        child: Text("No Data Found"),
                      );
                    } else {
                      return Stack(
                        children: [
                          Positioned(
                            top: 5.h,
                            left: 5.w,
                            child: Container(
                              width: 40.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(20.r),
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.arrow_downward, color: Colors.white),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                'All Reviews',
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).brightness == Brightness.dark
                                      ? TAppColor.whiteLightColor
                                      : TAppColor.darkFadeBlueColor,
                                ),
                              ),
                              SizedBox(height: 16.h),
                              Expanded(
                                child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: state.reviews.length,
                                  itemBuilder: (context, index) {
                                    final review = state.reviews[index];
                                    return Container(
                                      padding: EdgeInsets.all(12.w),
                                      margin: EdgeInsets.only(bottom: 12.h),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).brightness == Brightness.dark
                                            ? TAppColor.darkFadeBlueColor.withOpacity(0.2)
                                            : TAppColor.whiteLightColor.withOpacity(0.9),
                                        borderRadius: BorderRadius.circular(12.r),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${review.authorDetails!.username} • ${review.createdAt}',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).brightness == Brightness.dark
                                                  ? TAppColor.whiteLightColor.withOpacity(0.6)
                                                  : TAppColor.darkFadeBlueColor.withOpacity(0.6),
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Text(
                                            review.content ?? 'No content',
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Theme.of(context).brightness == Brightness.dark
                                                  ? TAppColor.whiteLightColor
                                                  : TAppColor.darkFadeBlueColor,
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Row(
                                            children: [
                                              Icon(Icons.star, color: Colors.amber, size: 20.w),
                                              SizedBox(width: 8.w),
                                              Text(
                                                review.authorDetails!.rating != null
                                                    ? '${review.authorDetails!.rating!.toStringAsFixed(1)}/10'
                                                    : '0/10',
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).brightness == Brightness.dark
                                                      ? TAppColor.whiteLightColor
                                                      : TAppColor.darkFadeBlueColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    }
                  } else {
                    return Center(
                      child: Text(
                        'No reviews available',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? TAppColor.whiteLightColor
                              : TAppColor.darkFadeBlueColor,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  static void showDialogAnonymous(BuildContext context, User user, Function() callback) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Anonymous user'),
          content: const Text('You are not logged in. Please log in to perform this action.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                callback();
              },
              child: const Text('Log in'),
            ),
          ],
        );
      },
    );
  }

  static void showBottomDialogShared(BuildContext context, SharedEntity shared, User user) {
    final controller = TextEditingController(text: shared.titleShared);
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
                const CloseBottomDialogWidget(),
                BottomDialogFormWidget(
                  formKey: formKey,
                  user: user,
                  controller: controller,
                  shared: shared,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static String? validateEmail(String? value) {
    const emailRegex = r'^[^@]+@[^@]+\.[^@]+';
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(emailRegex).hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? formatTimestamp(String? timestamp) {
    if (timestamp == null || timestamp.isEmpty) return null;
    // Assuming the timestamp is in a standard format like 'yyyy-MM-ddTHH:mm:ss'
    final DateTime dateTime = DateTime.parse(timestamp);
    // Format the date as 'dd/MM/yyyy'
    final String formattedDate = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
    return formattedDate;
  }

  static String generateRandomText(int length) {
    const String chars = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random rnd = Random();
    return String.fromCharCodes(Iterable.generate(length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));
  }

  static void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: SpinCustomWidget(
            sized: 50,
          ),
        );
      },
    );
  }

  static pickImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: imageSource);
    if (file != null) {
      return await file.readAsBytes();
    }
  }

  static void showCommentBottomSheet(BuildContext context, String postId, SharedEntity sharedItem, String uid) {
    final commentController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    String? parentId;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.9, // Adjust this value as needed
          minChildSize: 0.3, // Adjust this value as needed
          maxChildSize: 0.9, // Adjust this value as needed
          expand: false,
          builder: (context, scrollController) {
            return SafeArea(
              child: BlocProvider(
                create: (context) => CommentBloc(sl<CommentUseCase>())..add(GetCommentsRequested(postId)),
                child: BlocBuilder<CommentBloc, CommentState>(
                  builder: (context, commentState) {
                    if (commentState.status == CommentStatus.loading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (commentState.status == CommentStatus.success) {
                      return Column(
                        children: [
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                20.verticalSpace,
                                Container(
                                  height: 3.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[500],
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                ),
                                10.verticalSpace,
                                Text(
                                  "Comments",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(),
                          const SizedBox(height: 10),
                          Expanded(
                            child: commentState.comments!.isEmpty
                                ? const Center(
                                    child: Text('No comments in here'),
                                  )
                                : ListView.builder(
                                    itemCount: commentState.comments!.length,
                                    itemBuilder: (context, index) {
                                      final comment = commentState.comments![index];
                                      if (commentState.comments!.isEmpty && commentState.comments == []) {
                                        return const Center(
                                          child: Text('No comments'),
                                        );
                                      }
                                      if (comment.parentId != null) {
                                        // Skip replies in main list
                                        return Container();
                                      }
                                      return Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 16.h,
                                          vertical: 8.w,
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 40,
                                                  height: 40,
                                                  child: CircleAvatar(
                                                    backgroundImage: CachedNetworkImageProvider(comment.avatar ?? ''),
                                                  ),
                                                ),
                                                16.horizontalSpace,
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            comment.username ?? 'No name',
                                                            style:
                                                                TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          10.horizontalSpace,
                                                          Text(
                                                            AppUtils.formatTimestamp(comment.timestamp) ?? 'No time',
                                                            style: TextStyle(
                                                              color: Colors.grey,
                                                              fontSize: 10.sp,
                                                            ),
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                      8.verticalSpace,
                                                      Text(comment.content ?? 'No content'),
                                                      8.verticalSpace,
                                                      GestureDetector(
                                                        onTap: () {
                                                          context.read<CommentBloc>().add(
                                                                ReplyToCommentRequested(comment),
                                                              );
                                                          parentId = comment.id;
                                                        },
                                                        child: Text(
                                                          "Reply",
                                                          style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                                                        ),
                                                      ),
                                                      8.verticalSpace,
                                                      // Display replies
                                                      ...commentState.comments!
                                                          .where((reply) => reply.parentId == comment.id)
                                                          .map(
                                                            (reply) => Padding(
                                                              padding: const EdgeInsets.only(top: 8.0),
                                                              child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(
                                                                    width: 30,
                                                                    height: 30,
                                                                    child: CircleAvatar(
                                                                      backgroundImage: CachedNetworkImageProvider(
                                                                          reply.avatar ?? ''),
                                                                    ),
                                                                  ),
                                                                  16.horizontalSpace,
                                                                  Expanded(
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              reply.username ?? 'No name',
                                                                              style: TextStyle(
                                                                                fontWeight: FontWeight.bold,
                                                                                fontSize: 14.sp,
                                                                              ),
                                                                              overflow: TextOverflow.ellipsis,
                                                                            ),
                                                                            10.horizontalSpace,
                                                                            SizedBox(
                                                                              width: 40.w,
                                                                              child: Text(
                                                                                AppUtils.formatTimestamp(
                                                                                        reply.timestamp) ??
                                                                                    'No time',
                                                                                style: TextStyle(
                                                                                  color: Colors.grey,
                                                                                  fontSize: 10.sp,
                                                                                ),
                                                                                overflow: TextOverflow.ellipsis,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        8.verticalSpace,
                                                                        Text(reply.content ?? 'No content'),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          if (parentId != null)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Replying to ${commentState.replyingTo!.username}',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) {
                              if (state is AuthAuthenticated) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Form(
                                    key: formKey,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        //circle avatar
                                        SizedBox(
                                          width: 40,
                                          height: 40,
                                          child: CircleAvatar(
                                            backgroundImage: CachedNetworkImageProvider(
                                              state.user.image,
                                            ),
                                          ),
                                        ),
                                        10.horizontalSpace,
                                        Expanded(
                                          child: TextFormField(
                                            controller: commentController,
                                            validator: (value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter a comment';
                                              }
                                              return null;
                                            },
                                            decoration: const InputDecoration(
                                              hintText: 'Add a comment...',
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            color: Colors.blue,
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                          child: Center(
                                            child: IconButton(
                                              icon: const Icon(
                                                Icons.arrow_upward_outlined,
                                                color: Colors.white,
                                              ),
                                              onPressed: () {
                                                if (formKey.currentState?.validate() == true) {
                                                  final String id = AppUtils.generateRandomText(5);

                                                  final comment = CommentEntity(
                                                    id: id,
                                                    postId: sharedItem.id ?? '',
                                                    uid: uid,
                                                    email: state.user.email,
                                                    avatar: state.user.image,
                                                    content: commentController.text,
                                                    timestamp: DateTime.now().toString(),
                                                    parentId: parentId,
                                                    username: state.user.username,
                                                  );

                                                  context.read<CommentBloc>().add(AddCommentRequested(comment));
                                                  // Lấy thông tin của chủ bài viết (user B)
                                                  // final String postOwnerUid =
                                                  //     sharedItem.uid ??
                                                  //         ""; // Giả sử bạn đã có thông tin này trong sharedItem
                                                  // final String commenterName =
                                                  //     state.user.username;

                                                  // // Gửi thông báo đến chủ bài viết
                                                  // AwesomeNotifications()
                                                  //     .createNotification(
                                                  //   content:
                                                  //       NotificationContent(
                                                  //     id: 10,
                                                  //     channelKey:
                                                  //         'basic_channel',
                                                  //     title:
                                                  //         '$commenterName đã comment vào bài viết của bạn',
                                                  //     body: 'Hãy xem ngay!',
                                                  //     payload: {
                                                  //       'postOwnerUid':
                                                  //           postOwnerUid
                                                  //     },
                                                  //   ),
                                                  // );

                                                  commentController.clear();
                                                  parentId = null;
                                                  // context.read<CommentBloc>().add(
                                                  //     RefreshCommentRequested(
                                                  //         sharedItem.id ??
                                                  //             ''));
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                              return Container();
                            },
                          ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  static void timerSidler(Timer timer, int currentPage, PageController pageController, int lengthOfMovieToShow) {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (currentPage < lengthOfMovieToShow - 1) {
        currentPage++;
      } else {
        currentPage = 0;
      }

      pageController.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    });
  }

  static void showSnackbarInternetSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
      content: const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.wifi_off, color: Colors.white),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'No internet connection',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.redAccent,
      duration: const Duration(days: 365),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(16),
    ));
  }

  static void showSnackbarInternetFailed(BuildContext context) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: SnackBarAction(
          label: 'Close',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
        content: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.wifi, color: Colors.white),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Internet connection',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.greenAccent,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
