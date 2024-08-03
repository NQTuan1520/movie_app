import 'package:equatable/equatable.dart';

class ImageEvent extends Equatable {
  const ImageEvent();

  @override

  List<Object?> get props => [];
}

class GetImageEvent extends ImageEvent {
  final int id;

  const GetImageEvent({required this.id});

  @override
  List<Object?> get props => [id];
}
