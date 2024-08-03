import 'package:equatable/equatable.dart';

abstract class VideoPlayerEvent extends Equatable {
  const VideoPlayerEvent();

  @override
  List<Object> get props => [];
}

class InitializeVideo extends VideoPlayerEvent {
  final String filePath;

  const InitializeVideo(this.filePath);

  @override
  List<Object> get props => [filePath];
}

class PlayPauseVideo extends VideoPlayerEvent {}

class StopVideo extends VideoPlayerEvent {}

class SeekVideo extends VideoPlayerEvent {
  final Duration position;

  const SeekVideo(this.position);

  @override
  List<Object> get props => [position];
}
