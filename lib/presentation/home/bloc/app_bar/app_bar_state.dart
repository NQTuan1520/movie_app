import 'package:equatable/equatable.dart';

enum PageViewStateStatus { initial, pageChanged }

class PageViewState extends Equatable {
  final int currentPage;
  final PageViewStateStatus status;

  const PageViewState({
    this.currentPage = 0,
    this.status = PageViewStateStatus.initial,
  });

  PageViewState copyWith({
    int? currentPage,
    PageViewStateStatus? status,
  }) {
    return PageViewState(
      currentPage: currentPage ?? this.currentPage,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [currentPage, status];
}
