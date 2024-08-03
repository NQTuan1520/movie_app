import 'package:equatable/equatable.dart';

abstract class PageViewEvent extends Equatable {
  const PageViewEvent();

  @override
  List<Object> get props => [];
}

class PageChanged extends PageViewEvent {
  final int newPage;

  const PageChanged(this.newPage);

  @override
  List<Object> get props => [newPage];
}

class ResetPageTimer extends PageViewEvent {}
