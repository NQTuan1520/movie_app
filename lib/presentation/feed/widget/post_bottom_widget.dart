import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/di/injection.dart';
import 'package:tuannq_movie/domain/comment/usecase/comment_use_case.dart';
import 'package:tuannq_movie/domain/like_post/usecase/like_post_use_case.dart';
import 'package:tuannq_movie/domain/shared/entity/shared_entity.dart';
import 'package:tuannq_movie/manager/enum/like_status_enum.dart';
import 'package:tuannq_movie/manager/utils/utils.dart';
import 'package:tuannq_movie/presentation/commment/bloc/comeent/comment_bloc.dart';
import 'package:tuannq_movie/presentation/commment/bloc/comeent/comment_event.dart';
import 'package:tuannq_movie/presentation/commment/bloc/comeent/comment_state.dart';
import 'package:tuannq_movie/presentation/detail_movie/screen/details_movie_screen.dart';
import 'package:tuannq_movie/presentation/feed/bloc/like/like_post_bloc.dart';
import 'package:tuannq_movie/presentation/feed/bloc/like/like_post_event.dart';
import 'package:tuannq_movie/presentation/feed/bloc/like/like_post_state.dart';
import 'package:tuannq_movie/presentation/feed/widget/title_of_post_widget.dart';

class PostBottomWidget extends StatelessWidget {
  const PostBottomWidget({
    super.key,
    required this.sharedItem,
    required this.uid,
  });

  final SharedEntity sharedItem;
  final String uid;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 0.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => LikePostBloc(sl<LikePostUseCase>())
                  ..add(
                    CheckLikeStatusRequested(postId: sharedItem.id ?? "", uid: uid),
                  ),
              ),
              BlocProvider(
                create: (context) => CommentBloc(sl<CommentUseCase>())..add(GetCommentsRequested(sharedItem.id ?? "")),
              ),
            ],
            child: BlocConsumer<LikePostBloc, LikePostState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state.status == LikePostStatus.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.status == LikePostStatus.success) {
                  return Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          state.isLiked ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 28.r,
                        ),
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          if (state.isLiked) {
                            context
                                .read<LikePostBloc>()
                                .add(UnlikePostRequested(postId: sharedItem.id ?? "", uid: uid));
                          } else {
                            context.read<LikePostBloc>().add(LikePostRequested(postId: sharedItem.id ?? "", uid: uid));
                          }
                        },
                      ),
                      Text(
                        '${state.likeCount}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18.sp,
                        ),
                      ),
                      10.horizontalSpace,
                      BlocBuilder<CommentBloc, CommentState>(
                        builder: (context, state) {
                          return Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  AppUtils.showCommentBottomSheet(
                                    context,
                                    sharedItem.id ?? '',
                                    sharedItem,
                                    uid,
                                  );
                                },
                                icon: Icon(
                                  Icons.message_sharp,
                                  size: 28.r,
                                ),
                              ),
                              Text(
                                '${state.comments?.length ?? 0}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      10.horizontalSpace,
                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MovieDetailScreen(idMovie: sharedItem.idMovie ?? 0, uid: uid),
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.ads_click,
                          size: 28.r,
                        ),
                      ),
                    ],
                  );
                } else if (state.status == LikePostStatus.failure) {
                  return Center(child: Text('Error: ${state.message}'));
                } else {
                  return Container();
                }
              },
            ),
          ),
          TitleOfPostWidget(sharedItem: sharedItem),
        ],
      ),
    );
  }
}
