import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tuannq_movie/manager/color.dart';
import 'package:tuannq_movie/manager/enum/status_enum.dart';
import 'package:tuannq_movie/manager/widget/button_back_widget.dart';
import 'package:tuannq_movie/manager/widget/cached_image_custom_widget.dart';
import 'package:tuannq_movie/manager/widget/custom_spin_widget.dart';
import 'package:tuannq_movie/presentation/downloaded_video/screen/see_download_video.dart';
import 'package:tuannq_movie/presentation/trailer/bloc/trailer/trailer_bloc.dart';
import 'package:tuannq_movie/presentation/trailer/bloc/trailer/trailer_event.dart';
import 'package:tuannq_movie/presentation/trailer/bloc/trailer/trailer_state.dart';
import 'package:tuannq_movie/presentation/trailer/widget/dropdown_type_widget.dart';
import 'package:tuannq_movie/presentation/trailer/widget/trailer_section_widget.dart';
import 'package:tuannq_movie/presentation/trailer/widget/youtube_trailer_widget.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../domain/detail_movie/entity/movie_detail_entity.dart';

class WatchTrailerScreen extends StatefulWidget {
  final MovieDetailEntity movie;
  const WatchTrailerScreen({
    super.key,
    required this.movie,
  });

  @override
  State<WatchTrailerScreen> createState() => _WatchTrailerScreenState();
}

class _WatchTrailerScreenState extends State<WatchTrailerScreen> {
  MovieDetailEntity get movie => widget.movie;

  late YoutubePlayerController _controller;
  final bool _isPlayerReady = false;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  @override
  void initState() {
    super.initState();

    context.read<TrailerBloc>().add(GetTrailerEvent(movieId: movie.id ?? 0));

    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _initControllerVideo();
  }

  void _initControllerVideo() {
    _controller = YoutubePlayerController(
      initialVideoId: '',
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: false,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
        hideControls: false,
        hideThumbnail: true,
        controlsVisibleAtStart: true,
      ),
    )..addListener(listener);
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  void listener() {
    if (_isPlayerReady && mounted) {
      setState(() {
        if (_controller.value.isFullScreen) {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
        } else {
          SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);
        }
      });
    }
  }

  void playVideo(String videoId) {
    if (context.read<TrailerBloc>().state.isControllerReady) {
      _controller.load(videoId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('something_wrong'.tr()),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void navigatorOtherScreen(Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TrailerBloc, TrailerState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return SpinCustomWidget(sized: 50.r);
          } else if (state.status == Status.success) {
            if (state.trailers?.isNotEmpty == true && state.trailers!.first.key != null) {
              if (!state.isControllerReady) {
                _controller.load(state.trailers!.first.key!);
                context.read<TrailerBloc>().add(const UpdateControllerReadyEvent(isControllerReady: true));
              }
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    leading: const ButtonBackWidget(),
                    actions: [
                      Container(
                        margin: EdgeInsets.only(right: 8.w, top: 8.h),
                        width: 40.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: IconButton(
                          onPressed: () {
                            navigatorOtherScreen(const SavedVideosScreen());
                          },
                          icon: const Icon(
                            Icons.download,
                            color: TAppColor.whiteGreyColor,
                          ),
                        ),
                      ),
                    ],
                    expandedHeight: 300.h,
                    pinned: true,
                    flexibleSpace: Stack(
                      fit: StackFit.expand,
                      children: <Widget>[
                        CachedImageCustomWidget(widget: widget, imageUrl: movie.backdropPath ?? ''),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 240.h,
                            margin: EdgeInsets.only(bottom: 0.h),
                            child: YoutubePlayerWidget(
                              controller: _controller,
                              isControllerReady: state.isControllerReady,
                              setControllerReady: (value) {
                                context.read<TrailerBloc>().add(
                                      UpdateControllerReadyEvent(
                                        isControllerReady: value,
                                      ),
                                    );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 16.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DropDownTypeWidget(
                            currentTrailerType: state.currentTrailerType,
                            onChanged: (String? value) {
                              context.read<TrailerBloc>().add(UpdateTrailerTypeEvent(trailerType: value!));
                            },
                          ),
                          16.verticalSpace,
                          BlocBuilder<TrailerBloc, TrailerState>(
                            builder: (context, state) {
                              if (state.status == Status.success) {
                                final filteredTrailers = state.trailers
                                        ?.where((trailer) => trailer.type == state.currentTrailerType)
                                        .toList() ??
                                    [];
                                return TrailerListWidget(
                                  trailers: filteredTrailers,
                                  playVideo: playVideo,
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('trailer_error'.tr()),
                    duration: const Duration(seconds: 2),
                  ),
                );
              });
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
