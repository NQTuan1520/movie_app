// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../manager/enum/status_enum.dart';
import '../bloc/saved_video/saved_video_bloc.dart';
import '../bloc/saved_video/saved_video_event.dart';
import '../bloc/saved_video/saved_video_state.dart';
import '../widget/dismiss_video_item_widget.dart';
import '../widget/note_guide_swipe_widget.dart';

class SavedVideosScreen extends StatefulWidget {
  const SavedVideosScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SavedVideosScreenState createState() => _SavedVideosScreenState();
}

class _SavedVideosScreenState extends State<SavedVideosScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SavedVideosBloc>().add(LoadSavedVideosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('downloaded'.tr()),
      ),
      body: BlocBuilder<SavedVideosBloc, SavedVideosState>(
        builder: (context, state) {
          if (state.status == Status.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == Status.success) {
            return Column(
              children: [
                20.verticalSpace,
                const NoteGuideSwipeWidget(),
                16.verticalSpace,
                Expanded(
                  child: ListView.builder(
                    itemCount: state.savedVideos.length,
                    itemBuilder: (context, index) {
                      final video = state.savedVideos[index];
                      return DismissibleVideoItem(
                        video: video,
                        index: index,
                      );
                    },
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: Text('An error occurred'));
          }
        },
      ),
    );
  }
}
