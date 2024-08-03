import 'package:equatable/equatable.dart';

import '../../../../manager/enum/status_enum.dart';

class SavedVideosState extends Equatable {
  final Status status;
  final List<Map<String, String>> savedVideos;

  const SavedVideosState({
    this.status = Status.initial,
    this.savedVideos = const [],
  });

  SavedVideosState copyWith({
    Status? status,
    List<Map<String, String>>? savedVideos,
  }) {
    return SavedVideosState(
      status: status ?? this.status,
      savedVideos: savedVideos ?? this.savedVideos,
    );
  }

  @override
  List<Object> get props => [status, savedVideos];
}
