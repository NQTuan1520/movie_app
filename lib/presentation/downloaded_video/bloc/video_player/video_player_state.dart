import 'package:equatable/equatable.dart';
import 'package:video_player/video_player.dart';

enum VideoStatus { uninitialized, loading, loaded, error }

class VideoPlayerState extends Equatable {
  final VideoStatus status;
  final VideoPlayerController? controller;
  final String? errorMessage;

  const VideoPlayerState({
    this.status = VideoStatus.uninitialized,
    this.controller,
    this.errorMessage,
  });

  VideoPlayerState copyWith({
    VideoStatus? status,
    VideoPlayerController? controller,
    String? errorMessage,
  }) {
    return VideoPlayerState(
      status: status ?? this.status,
      controller: controller ?? this.controller,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, controller, errorMessage];
}
