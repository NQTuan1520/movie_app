

import 'package:equatable/equatable.dart';

class SharedPersonEvent extends Equatable {
  const SharedPersonEvent();

  @override
  List<Object> get props => [];
}

class GetShareEventById extends SharedPersonEvent {
  final String uid;
  const GetShareEventById({required this.uid});

  @override
  List<Object> get props => [uid];
}

