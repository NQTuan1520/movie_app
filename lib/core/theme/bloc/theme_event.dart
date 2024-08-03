import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeChangeEvent extends ThemeEvent {
  final ThemeData themeData;

  const ThemeChangeEvent({required this.themeData});

  @override
  List<Object> get props => [themeData];
}
