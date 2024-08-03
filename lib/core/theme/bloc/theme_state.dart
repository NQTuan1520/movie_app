import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();
}

final class ThemeInitial extends ThemeState {
  final ThemeData themeData;

  const ThemeInitial({required this.themeData});
  @override
  List<Object> get props => [themeData];
}

final class ThemeLoading extends ThemeState {
  @override
  List<Object?> get props => [];
}

final class ThemeSuccess extends ThemeState {
  final ThemeData themeData;

  const ThemeSuccess({required this.themeData});
  @override
  List<Object?> get props => [themeData];
}

final class ThemeFailed extends ThemeState {
  final String message;

  const ThemeFailed({required this.message});
  @override
  List<Object?> get props => [message];
}
