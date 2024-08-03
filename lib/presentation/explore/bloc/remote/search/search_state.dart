import 'package:equatable/equatable.dart';

import '../../../../../manager/enum/status_enum.dart';

class SearchState extends Equatable {
  final Status status;
  final bool isGuest;

  const SearchState({this.status = Status.initial, this.isGuest = false});

  SearchState copyWith({Status? status, bool? isGuest}) {
    return SearchState(
      status: status ?? this.status,
      isGuest: isGuest ?? this.isGuest,
    );
  }

  @override
  List<Object> get props => [status, isGuest];
}
