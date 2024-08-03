import 'package:equatable/equatable.dart';

import '../../../domain/auth/entity/user_entity.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final UserEntity user;

  AuthAuthenticated(this.user);

  @override
  List<Object> get props => [user];
}

class AuthUnauthenticated extends AuthState {}

class AuthUpdateUsernameLoading extends AuthState {}

class AuthUpdateUsernameSuccess extends AuthState {
  final UserEntity user;

  AuthUpdateUsernameSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthUpdateUsernameFailure extends AuthState {
  final String message;

  AuthUpdateUsernameFailure(this.message);

  @override
  List<Object> get props => [message];
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);

  @override
  List<Object> get props => [message];
}

class AuthRegisterSuccess extends AuthState {
  final UserEntity user;

  AuthRegisterSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthRegisterFailure extends AuthState {
  final String message;

  AuthRegisterFailure(this.message);

  @override
  List<Object> get props => [message];
}

class AuthLoginSuccess extends AuthState {
  final UserEntity user;

  AuthLoginSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class AuthLoginFailure extends AuthState {
  final String message;

  AuthLoginFailure(this.message);

  @override
  List<Object> get props => [message];
}

class GetInformationLoading extends AuthState {}

class GetInformationSuccess extends AuthState {
  final UserEntity user;

  GetInformationSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class GetInformationFailure extends AuthState {
  final String message;

  GetInformationFailure(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateImageProfileSuccess extends AuthState {
  final UserEntity user;

  UpdateImageProfileSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class UpdateImageProfileFailure extends AuthState {
  final String message;

  UpdateImageProfileFailure(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateImageProfileLoading extends AuthState {}

class ResetPasswordSuccess extends AuthState {}

class ResetPasswordFailure extends AuthState {
  final String message;

  ResetPasswordFailure(this.message);

  @override
  List<Object> get props => [message];
}

class ResetPasswordLoading extends AuthState {}
