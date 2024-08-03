
import 'package:equatable/equatable.dart';

class SavedVideosEvent extends Equatable {
  const SavedVideosEvent();

  @override
  List<Object> get props => [];
}

class LoadSavedVideosEvent extends SavedVideosEvent {}

class DeleteVideoEvent extends SavedVideosEvent {
  final int index;

  const DeleteVideoEvent(this.index);

  @override
  List<Object> get props => [index];
}
