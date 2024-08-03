import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tuannq_movie/presentation/downloaded_video/widget/saved_item_widget.dart';

import '../bloc/saved_video/saved_video_bloc.dart';
import '../bloc/saved_video/saved_video_event.dart';
import '../screen/video_player_saved_screen.dart';

class DismissibleVideoItem extends StatelessWidget {
  final Map<String, String> video;
  final int index;

  const DismissibleVideoItem({
    super.key,
    required this.video,
    required this.index,
  });

  Future<bool> _showDeleteConfirmationDialog(BuildContext context) async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Confirm Delete'),
            content: const Text('Are you sure you want to delete this video?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Delete'),
              ),
            ],
          ),
        ) ??
        false;
  }

  Future<void> _showSnackBar(BuildContext context, String message) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _navigateTo(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => widget));
  }

  Future<void> _navigatorToVideoPlayer(Map<String, String> video, BuildContext context) async {
    final dir = await getApplicationDocumentsDirectory();
    final filePath = '${dir.path}/${video['name']!}.mp4';
    final file = File(filePath);

    if (await file.exists()) {
      if (!context.mounted) return;
      _navigateTo(
          context,
          VideoPlayerScreen(
            filePath: filePath,
            name: video['name']!,
          ));
    } else {
      if (!context.mounted) return;
      _showSnackBar(context, 'Video file not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(video['id']!),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: const Icon(
          Icons.delete_sweep_outlined,
          color: Colors.white,
        ),
      ),
      confirmDismiss: (direction) async {
        return await _showDeleteConfirmationDialog(context);
      },
      onDismissed: (direction) {
        context.read<SavedVideosBloc>().add(DeleteVideoEvent(index));
        _showSnackBar(context, 'Video deleted');
      },
      child: SavedItemWidget(
        video: video,
        onTap: () {
          _navigatorToVideoPlayer(video, context);
        },
      ),
    );
  }
}
