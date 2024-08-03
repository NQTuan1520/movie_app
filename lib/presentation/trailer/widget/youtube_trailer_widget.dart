import 'package:flutter/material.dart';
import 'package:tuannq_movie/manager/color.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerWidget extends StatelessWidget {
  final YoutubePlayerController controller;
  final bool isControllerReady;
  final ValueChanged<bool> setControllerReady;

  const YoutubePlayerWidget({
    super.key,
    required this.controller,
    required this.isControllerReady,
    required this.setControllerReady,
  });

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: controller,
      aspectRatio: 16 / 9,
      showVideoProgressIndicator: true,
      progressIndicatorColor: TAppColor.primaryColor,
      progressColors: const ProgressBarColors(
        playedColor: TAppColor.primaryColor,
        handleColor: TAppColor.primaryColor,
      ),
      bottomActions: [
        CurrentPosition(),
        ProgressBar(isExpanded: true),
        FullScreenButton(),
      ],
      topActions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.share,
          ),
          onPressed: () {
            // Your logic for sharing or other actions
          },
        ),
      ],
      onReady: () {
        setControllerReady(true);
      },
    );
  }
}
