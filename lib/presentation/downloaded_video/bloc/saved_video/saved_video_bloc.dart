import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuannq_movie/presentation/downloaded_video/bloc/saved_video/saved_video_event.dart';
import 'package:tuannq_movie/presentation/downloaded_video/bloc/saved_video/saved_video_state.dart';

import '../../../../manager/enum/status_enum.dart';

class SavedVideosBloc extends Bloc<SavedVideosEvent, SavedVideosState> {
  SavedVideosBloc() : super(const SavedVideosState()) {
    on<LoadSavedVideosEvent>(_onLoadSavedVideos);
    on<DeleteVideoEvent>(_onDeleteVideo);
  }

  Future<void> _onLoadSavedVideos(LoadSavedVideosEvent event, Emitter<SavedVideosState> emit) async {
    emit(state.copyWith(status: Status.loading));

    final pref = await SharedPreferences.getInstance();
    final downloadedVideos = pref.getStringList('downloadedVideos') ?? [];

    final savedVideos = downloadedVideos.map((videoData) {
      final data = videoData.split('|');
      if (data.length == 3) {
        return {'name': data[0], 'id': data[1], "image": data[2]};
      } else {
        return {'name': 'Invalid Data', 'id': 'Invalid Data'};
      }
    }).toList();

    emit(state.copyWith(status: Status.success, savedVideos: savedVideos));
  }

  Future<void> _onDeleteVideo(DeleteVideoEvent event, Emitter<SavedVideosState> emit) async {
    final pref = await SharedPreferences.getInstance();
    final downloadedVideos = pref.getStringList('downloadedVideos') ?? [];

    if (downloadedVideos.isNotEmpty && event.index < downloadedVideos.length) {
      final dir = await getApplicationDocumentsDirectory();
      final videoToDelete = downloadedVideos.removeAt(event.index);
      final data = videoToDelete.split('|');
      final filePath = '${dir.path}/${data[0]}.mp4';
      final file = File(filePath);

      if (await file.exists()) {
        await file.delete();
      }

      await pref.setStringList('downloadedVideos', downloadedVideos);

      final updatedVideos = List<Map<String, String>>.from(state.savedVideos);
      updatedVideos.removeAt(event.index);

      emit(state.copyWith(savedVideos: updatedVideos));
    }
  }
}
