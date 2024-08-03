import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuannq_movie/presentation/downloaded_video/bloc/video_player/video_player_event.dart';
import 'package:tuannq_movie/presentation/downloaded_video/bloc/video_player/video_player_state.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

class VideoPlayerBloc extends Bloc<VideoPlayerEvent, VideoPlayerState> {
  VideoPlayerBloc() : super(const VideoPlayerState());

  Stream<VideoPlayerState> mapEventToState(VideoPlayerEvent event) async* {
    if (event is InitializeVideo) {
      yield state.copyWith(status: VideoStatus.loading);
      try {
        final controller = VideoPlayerController.file(File(event.filePath));
        await controller.initialize();
        controller.setLooping(true);
        controller.play();
        yield state.copyWith(status: VideoStatus.loaded, controller: controller);
      } catch (error) {
        yield state.copyWith(status: VideoStatus.error, errorMessage: error.toString());
      }
    } else if (event is PlayPauseVideo) {
      if (state.controller != null) {
        if (state.controller!.value.isPlaying) {
          state.controller!.pause();
        } else {
          state.controller!.play();
        }
        yield state.copyWith(controller: state.controller);
      }
    } else if (event is StopVideo) {
      if (state.controller != null) {
        state.controller!.pause();
        state.controller!.seekTo(Duration.zero);
        yield state.copyWith(controller: state.controller);
      }
    } else if (event is SeekVideo) {
      if (state.controller != null) {
        state.controller!.seekTo(event.position);
        yield state.copyWith(controller: state.controller);
      }
    }
  }
}
